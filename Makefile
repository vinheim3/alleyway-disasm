OBJS = $(shell find code/ -name '*.s' | sed "s/code/build/" | sed "s/\.s/.o/")
RAM_OBJS = build/wram.o build/hram.o
GFX_OBJS = $(shell find gfx/ -name '*.png' | sed "s/gfx/build/" | sed "s/.png/.2bpp/")

all: alleyway.gb

build/%.2bpp: gfx/%.png
	rgbgfx -o $@ $<

build/%.o: code/%.s
	rgbasm -h -L -o $@ $<

build/wram.o: include/wram.s
	rgbasm -h -L -o $@ $<

build/hram.o: include/hram.s
	rgbasm -h -L -o $@ $<

alleyway.gb: $(GFX_OBJS) $(OBJS) $(RAM_OBJS)
	rgblink -d -n alleyway.sym -m alleyway.map -o $@ $(OBJS) $(RAM_OBJS)
	rgbfix -v -l 0x01 -m 0x00 -t "ALLEY WAY" $@

	md5 $@

clean:
	rm -f build/* alleyway.gb alleyway.sym alleyway.map
	find . \( -iname '*.1bpp' -o -iname '*.2bpp' \) -exec rm {} +