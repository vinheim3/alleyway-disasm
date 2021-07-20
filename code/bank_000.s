; Disassembly of "OR"
; This file was created with:
; mgbdis v1.4 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

INCLUDE "includes.s"

SECTION "ROM Bank $000", ROM0[$0]

	jp   Begin                                                      ; $0000

	ds $40-@, $ff

VBlankInterrupt::
	jp   VBlankInterruptHandler                                     ; $0040

	ds $48-@, $ff

LCDCInterrupt::
	jp   LCDCInterruptHandler                                       ; $0048

	ds $50-@, $ff

TimerOverflowInterrupt::
	jp   TimerInterruptHandlerStub                                  ; $0050

	ds $58-@, $ff

SerialTransferCompleteInterrupt::
	jp   SerialInterruptHandler                                     ; $0058

	ds $60-@, $ff

JoypadTransitionInterrupt::
	reti                                                            ; $0060

	ds $100-@, $ff

Boot::
	nop                                                             ; $0100
	jp   Begin                                                      ; $0101


SECTION "Begin", ROM0[$150]

Begin:
; Wait until in vblank
:	ldh  a, [rLY]                                                   ; $0150
	cp   $91                                                        ; $0152
	jr   c, :-                                                      ; $0154

; Turn off lcd, set SP, and disable interrupts
	ld   a, $00                                                     ; $0156
	ldh  [rLCDC], a                                                 ; $0158
	
	ld   sp, wStackTop                                              ; $015a
	call PreserveAndClearIE                                         ; $015d

; Clear vram
	ld   hl, $9fff                                                  ; $0160
	ld   c, $1f                                                     ; $0163
	xor  a                                                          ; $0165
	ld   b, $00                                                     ; $0166
:	ld   [hl-], a                                                   ; $0168
	dec  b                                                          ; $0169
	jr   nz, :-                                                     ; $016a
	dec  c                                                          ; $016c
	jr   nz, :-                                                     ; $016d

; Clear sram and wram
	ld   hl, $dfff                                                  ; $016f
	ld   c, $3f                                                     ; $0172
	xor  a                                                          ; $0174
	ld   b, $00                                                     ; $0175
:	ld   [hl-], a                                                   ; $0177
	dec  b                                                          ; $0178
	jr   nz, :-                                                     ; $0179
	dec  c                                                          ; $017b
	jr   nz, :-                                                     ; $017c

; Clear hram
	ld   hl, $fffe                                                  ; $017e
	ld   b, $7f                                                     ; $0181
:	ld   [hl-], a                                                   ; $0183
	dec  b                                                          ; $0184
	jr   nz, :-                                                     ; $0185

; Clear oam ram
	ld   hl, $feff                                                  ; $0187
	ld   b, $ff                                                     ; $018a
:	ld   [hl-], a                                                   ; $018c
	dec  b                                                          ; $018d
	jr   nz, :-                                                     ; $018e

; Load tile data and clear screens
	call LoadTileData                                               ; $0190
	call ClearScreen0                                               ; $0193
	call ClearScreen1                                               ; $0196

; Copy oam dma func to hram
	ld   c, LOW(hOamDmaFunc)                                        ; $0199
	ld   b, OamDmaFunc.end-OamDmaFunc                               ; $019b
	ld   hl, OamDmaFunc                                             ; $019d
:	ld   a, [hl+]                                                   ; $01a0
	ldh  [c], a                                                     ; $01a1
	inc  c                                                          ; $01a2
	dec  b                                                          ; $01a3
	jr   nz, :-                                                     ; $01a4

; Only allow vblank
	ld   a, IEF_VBLANK                                              ; $01a6
	ldh  [rIF], a                                                   ; $01a8
	ldh  [hIE], a                                                   ; $01aa

; LCDC in-game triggers using LUC
	ld   a, STATF_LYC                                               ; $01ac
	ldh  [rSTAT], a                                                 ; $01ae

; Clear scroll and turn off LCD
	xor  a                                                          ; $01b0
	ldh  [rSCY], a                                                  ; $01b1
	ldh  [rSCX], a                                                  ; $01b3

	ld   a, $00                                                     ; $01b5
	ldh  [rLCDC], a                                                 ; $01b7

; Set default palettes
	ld   a, %11100100                                               ; $01b9
	ldh  [rBGP], a                                                  ; $01bb
	ldh  [rOBP0], a                                                 ; $01bd
	ldh  [rOBP1], a                                                 ; $01bf

; Start with no btns held, and clear LYC
	ld   a, $ff                                                     ; $01c1
	ldh  [hButtonsNotHeld], a                                       ; $01c3
	
	ld   a, $00                                                     ; $01c5
	ldh  [rLYC], a                                                  ; $01c7

; Clear timer hw regs
	ld   a, $00                                                     ; $01c9
	ldh  [rTAC], a                                                  ; $01cb
	ld   a, $00                                                     ; $01cd
	ldh  [rTMA], a                                                  ; $01cf

; Set unused var
	ld   a, $20                                                     ; $01d1
	ldh  [hUnusedVar_ff9b], a                                       ; $01d3

; Clear pending interrupts and scroll regs
	xor  a                                                          ; $01d5
	ldh  [rIF], a                                                   ; $01d6
	xor  a                                                          ; $01d8
	ldh  [hSCX], a                                                  ; $01d9
	ldh  [hSCY], a                                                  ; $01db

; Set state to GS_SET_INITIAL_TOP_SCORE, and clear stage-type flags
	ldh  [hGameState], a                                            ; $01dd
	ldh  [hIsBonusLevel], a                                         ; $01df
	ldh  [hIsXScrollingStage], a                                    ; $01e1

; Turn on LCD, restore interrupts and start game main loop
	ld   a, LCDCF_ON|LCDCF_OBJON|LCDCF_BGON                         ; $01e3
	ldh  [hLCDC], a                                                 ; $01e5
	ldh  [rLCDC], a                                                 ; $01e7
	call RestoreIE                                                  ; $01e9
	jp   MainLoop                                                   ; $01ec


VBlankInterruptHandler:
	push af                                                         ; $01ef
	push bc                                                         ; $01f0
	push de                                                         ; $01f1
	push hl                                                         ; $01f2

	call PollInput                                                  ; $01f3

; Set counter to 2 so that after 2 pings this frame, we process a byte we received
	ld   a, $02                                                     ; $01f6
	ldh  [hSerialCounterBeforeProcessingSB], a                      ; $01f8

; Initiate transfer
	ld   a, $81                                                     ; $01fa
	ldh  [rSC], a                                                   ; $01fc

; Always update oam, then process pending level changes
	call hOamDmaFunc                                                ; $01fe
	call DecompressLevelChanges                                     ; $0201

; Update shadow lcd and scroll regs
	ldh  a, [hLCDC]                                                 ; $0204
	ldh  [rLCDC], a                                                 ; $0206
	ldh  a, [hSCX]                                                  ; $0208
	ldh  [rSCX], a                                                  ; $020a
	ldh  a, [hSCY]                                                  ; $020c
	ldh  [rSCY], a                                                  ; $020e

; Update sound and inc frame counter
	call UpdateSound                                                ; $0210

	ldh  a, [hFrameCounter]                                         ; $0213
	inc  a                                                          ; $0215
	ldh  [hFrameCounter], a                                         ; $0216

; Set flag to exit halt loops
	ld   a, $01                                                     ; $0218
	ldh  [hVBlankInterruptHandled], a                               ; $021a

	pop  hl                                                         ; $021c
	pop  de                                                         ; $021d
	pop  bc                                                         ; $021e
	pop  af                                                         ; $021f
	reti                                                            ; $0220


WaitForVBlankIntHandled::
; Clear wait flag
	ld   a, $00                                                     ; $0221
	ldh  [hVBlankInterruptHandled], a                               ; $0223

; Wait until wait flag is set
:	halt                                                            ; $0225
	ldh  a, [hVBlankInterruptHandled]                               ; $0226
	cp   $00                                                        ; $0228
	jr   z, :-                                                      ; $022a

GameStateStub:
	ret                                                             ; $022c


RestoreIE::
	ldh  a, [hIE]                                                   ; $022d
	ldh  [rIE], a                                                   ; $022f
	ei                                                              ; $0231
	ret                                                             ; $0232


PreserveAndClearIE::
	ldh  a, [rIE]                                                   ; $0233
	ldh  [hIE], a                                                   ; $0235
	ld   a, $00                                                     ; $0237
	ldh  [rIE], a                                                   ; $0239
	di                                                              ; $023b
	ret                                                             ; $023c


WaitUntilNoCompressedLevelChanges::
; Return immediately if nothing pending..
	ldh  a, [hPendingCompressedLevelChanges]                        ; $023d
	cp   $00                                                        ; $023f
	ret  z                                                          ; $0241

; Else vblank interrupt will process it
	jr   WaitForVBlankIntHandled                                    ; $0242


TurnOnLCD::
	ldh  a, [hLCDC]                                                 ; $0244
	and  $ff-LCDCF_ON                                               ; $0246
	or   LCDCF_ON                                                   ; $0248
	ldh  [hLCDC], a                                                 ; $024a
	ldh  [rLCDC], a                                                 ; $024c
	ret                                                             ; $024e


TurnOffLCDandWaitForVBlankIntHandled::
	ldh  a, [hLCDC]                                                 ; $024f
	and  $ff-LCDCF_ON                                               ; $0251
	ldh  [hLCDC], a                                                 ; $0253

	jr   WaitForVBlankIntHandled                                    ; $0255


WaitForAVBlankIntsHandled::
:	push af                                                         ; $0257
	call WaitForVBlankIntHandled                                    ; $0258
	pop  af                                                         ; $025b
	dec  a                                                          ; $025c
	jr   nz, :-                                                     ; $025d

	ret                                                             ; $025f


LCDCInterruptHandler:
	push af                                                         ; $0260
	push bc                                                         ; $0261
	push de                                                         ; $0262
	push hl                                                         ; $0263

; Call handler once, then disable the interrupt
	call ProcessInGameScroll                                        ; $0264

	ldh  a, [rIF]                                                   ; $0267
	and  $ff-IEF_LCDC                                               ; $0269
	ldh  [rIF], a                                                   ; $026b

	pop  hl                                                         ; $026d
	pop  de                                                         ; $026e
	pop  bc                                                         ; $026f
	pop  af                                                         ; $0270
	reti                                                            ; $0271


SerialInterruptHandler:
	push af                                                         ; $0272
	push bc                                                         ; $0273

; Dec counter, jumping if not yet 0
	ldh  a, [hSerialCounterBeforeProcessingSB]                      ; $0274
	dec  a                                                          ; $0276
	ldh  [hSerialCounterBeforeProcessingSB], a                      ; $0277

	jr   nz, .done                                                  ; $0279

; B = previous SB read when counter hit 0
	ldh  a, [hPreviousDoublePingedSBReceived]                       ; $027b
	ld   b, a                                                       ; $027d

; C = curr SB read
	ldh  a, [rSB]                                                   ; $027e
	ldh  [hPreviousDoublePingedSBReceived], a                       ; $0280
	ld   c, a                                                       ; $0282

; Get similar bits, and set bits from curr SB
	xor  b                                                          ; $0283
	xor  $ff                                                        ; $0284
	or   c                                                          ; $0286
	ldh  [hPrevAndCurrSBsCombined], a                               ; $0287

	pop  bc                                                         ; $0289
	pop  af                                                         ; $028a
	reti                                                            ; $028b

.done:
; Read byte and initiate transfer
	ldh  a, [rSB]                                                   ; $028c
	ldh  [hSerialByteReceived], a                                   ; $028e
	ld   a, $81                                                     ; $0290
	ldh  [rSC], a                                                   ; $0292

	pop  bc                                                         ; $0294
	pop  af                                                         ; $0295
	reti                                                            ; $0296


InitSerial:
; Load 1 into SB
	ld   a, $01                                                     ; $0297
	ldh  [rSB], a                                                   ; $0299

; Enable IEF_SERIAL
	ld   hl, rIE                                                    ; $029b
	set  3, [hl]                                                    ; $029e
	ret                                                             ; $02a0


DecompressLevelChanges:
; Jump if no pending changes
	ldh  a, [hPendingCompressedLevelChanges]                        ; $02a1
	cp   $00                                                        ; $02a3
	jr   z, .done                                                   ; $02a5

; Else process it
	ld   de, wCompressedLevelChanges                                ; $02a7
	call DecompressData                                             ; $02aa

; Then reset compression flags
	xor  a                                                          ; $02ad
	ld   [wUnusedVar_c900], a                                       ; $02ae
	ld   [wCompressedLevelChanges], a                               ; $02b1
	ldh  [hPendingCompressedLevelChanges], a                        ; $02b4

.done:
	ret                                                             ; $02b6


_DecompressLoop:
; 1st spec byte in H, 2nd in L, 3rd in A
	inc  de                                                         ; $02b7
	ld   h, a                                                       ; $02b8
	ld   a, [de]                                                    ; $02b9
	ld   l, a                                                       ; $02ba
	inc  de                                                         ; $02bb
	ld   a, [de]                                                    ; $02bc
	inc  de                                                         ; $02bd

; Use HL and A as params
	call DecompressBlock                                            ; $02be

; DE - source of compressed data
DecompressData::
; Finish once 1st spec byte == 0
	ld   a, [de]                                                    ; $02c1
	cp   $00                                                        ; $02c2
	jr   nz, _DecompressLoop                                        ; $02c4

	ret                                                             ; $02c6


; A - decompress type + num bytes
; DE - source addr
; HL - dest addr
DecompressBlock:
; B - num bytes to copy
	push af                                                         ; $02c7
	and  $3f                                                        ; $02c8
	ld   b, a                                                       ; $02ca
	pop  af                                                         ; $02cb

; A = decompress type
	rlca                                                            ; $02cc
	rlca                                                            ; $02cd
	and  $03                                                        ; $02ce
	jr   z, .decompressType0_SimpleCopy                             ; $02d0

	dec  a                                                          ; $02d2
	jr   z, .decompressType1_SingleByteCopy                         ; $02d3

	dec  a                                                          ; $02d5
	jr   z, .decompressType2_ColumnCopy                             ; $02d6

	jr   .decompressType3_SingleByteColumnCopy                      ; $02d8

.decompressType0_SimpleCopy:
:	ld   a, [de]                                                    ; $02da
	ld   [hl+], a                                                   ; $02db
	inc  de                                                         ; $02dc
	dec  b                                                          ; $02dd
	jr   nz, :-                                                     ; $02de

	ret                                                             ; $02e0

.decompressType1_SingleByteCopy:
	ld   a, [de]                                                    ; $02e1
	inc  de                                                         ; $02e2
:	ld   [hl+], a                                                   ; $02e3
	dec  b                                                          ; $02e4
	jr   nz, :-                                                     ; $02e5

	ret                                                             ; $02e7

.decompressType2_ColumnCopy:
:	ld   a, [de]                                                    ; $02e8
	ld   [hl], a                                                    ; $02e9
	inc  de                                                         ; $02ea
	ld   a, b                                                       ; $02eb
	ld   bc, SCRN_VX_B                                              ; $02ec
	add  hl, bc                                                     ; $02ef
	ld   b, a                                                       ; $02f0
	dec  b                                                          ; $02f1
	jr   nz, :-                                                     ; $02f2

	ret                                                             ; $02f4

.decompressType3_SingleByteColumnCopy:
:	ld   a, [de]                                                    ; $02f5
	ld   [hl], a                                                    ; $02f6
	ld   a, b                                                       ; $02f7
	ld   bc, SCRN_VX_B                                              ; $02f8
	add  hl, bc                                                     ; $02fb
	ld   b, a                                                       ; $02fc
	dec  b                                                          ; $02fd
	jr   nz, :-                                                     ; $02fe

	inc  de                                                         ; $0300
	ret                                                             ; $0301


UnusedDecompressionFunc_0302:
; Get HL from return address
	pop  de                                                         ; $0302
	ld   a, [de]                                                    ; $0303
	ld   l, a                                                       ; $0304
	inc  de                                                         ; $0305
	ld   a, [de]                                                    ; $0306
	ld   h, a                                                       ; $0307
	inc  de                                                         ; $0308

; Push address to return to after HL, then preserve other regs
	push de                                                         ; $0309
	push af                                                         ; $030a
	push bc                                                         ; $030b

.nextSpecByte:
; Stop when $ff read
	ld   a, [hl+]                                                   ; $030c
	cp   $ff                                                        ; $030d
	jr   z, .done                                                   ; $030f

; Get big-endian DE, and push it
	ld   d, a                                                       ; $0311
	ld   a, [hl+]                                                   ; $0312
	ld   e, a                                                       ; $0313
	push de                                                         ; $0314

; C = low 5 bits of next byte (num rows)
	ld   a, [hl+]                                                   ; $0315
	push af                                                         ; $0316
	and  $1f                                                        ; $0317
	ld   c, a                                                       ; $0319

; Save byte after, which is num cols
	ld   a, [hl+]                                                   ; $031a
	ldh  [hUnusedDecompressionNumCols], a                           ; $031b

; Pop byte that set C, and jump to other algo if bit 7 clear
	pop  af                                                         ; $031d
	and  $80                                                        ; $031e
	jr   z, .bit7clear                                              ; $0320

.bit7set:
; Simple copy for each col
	ldh  a, [hUnusedDecompressionNumCols]                           ; $0322
	ld   b, a                                                       ; $0324

:	ld   a, [hl+]                                                   ; $0325
	ld   [de], a                                                    ; $0326
	inc  de                                                         ; $0327
	dec  b                                                          ; $0328
	jr   nz, :-                                                     ; $0329

; Get starting dest addr
	pop  de                                                         ; $032b

; Push src address to get back as HL
	push hl                                                         ; $032c

; DE becomes next row start
	ld   hl, SCRN_VX_B                                              ; $032d
	add  hl, de                                                     ; $0330
	push hl                                                         ; $0331
	pop  de                                                         ; $0332
	pop  hl                                                         ; $0333

; Save curr row start, checking next spec byte when rows are done
	push de                                                         ; $0334
	dec  c                                                          ; $0335
	jr   nz, .bit7set                                               ; $0336

	pop  de                                                         ; $0338
	jr   .nextSpecByte                                              ; $0339

.bit7clear:
; Copy 1 src byte per col
	ldh  a, [hUnusedDecompressionNumCols]                           ; $033b
	ld   b, a                                                       ; $033d

:	ld   a, [hl]                                                    ; $033e
	ld   [de], a                                                    ; $033f
	inc  de                                                         ; $0340
	dec  b                                                          ; $0341
	jr   nz, :-                                                     ; $0342

; Get starting dest addr
	pop  de                                                         ; $0344

; Push src address to get back as HL
	push hl                                                         ; $0345

; DE becomes next row start
	ld   hl, SCRN_VX_B                                              ; $0346
	add  hl, de                                                     ; $0349
	push hl                                                         ; $034a
	pop  de                                                         ; $034b
	pop  hl                                                         ; $034c

; Save curr row start, checking next spec byte when rows are done
	push de                                                         ; $034d
	dec  c                                                          ; $034e
	jr   nz, .bit7clear                                             ; $034f

	pop  de                                                         ; $0351
	inc  hl                                                         ; $0352
	jr   .nextSpecByte                                              ; $0353

.done:
	pop  bc                                                         ; $0355
	pop  af                                                         ; $0356
	ret                                                             ; $0357


ClearScreen0::
	ld   hl, _SCRN0                                                 ; $0358
	jr   :+                                                         ; $035b

ClearScreen1::
	ld   hl, _SCRN1                                                 ; $035d

:	ld   bc, $0400                                                  ; $0360

.copy:
	ld   a, TILE_BLANK                                              ; $0363
	ld   [hl+], a                                                   ; $0365
	dec  bc                                                         ; $0366
	ld   a, b                                                       ; $0367
	or   c                                                          ; $0368
	jr   nz, .copy                                                  ; $0369

	ret                                                             ; $036b


ClearShadowOam::
	ld   b, NUM_SPRITES * OAM_SIZEOF                                ; $036c
	ld   a, $00                                                     ; $036e
	ld   hl, wOam                                                   ; $0370

.loop:
	ld   [hl+], a                                                   ; $0373
	dec  b                                                          ; $0374
	jr   nz, .loop                                                  ; $0375

	ret                                                             ; $0377


ClearAnimatedOam::
; Clear to the end of oam
	ld   b, $18                                                     ; $0378
	ld   a, $00                                                     ; $037a
	ld   hl, wOam+OSLOT_MARIO                                       ; $037c
	jr   ClearShadowOam.loop                                        ; $037f


LoadTileData:
; BG-only region
	ld   hl, Gfx_TileData+$1000                                     ; $0381
	ld   de, _VRAM+$1000                                            ; $0384
	ld   bc, $0800                                                  ; $0387
:	ld   a, [hl+]                                                   ; $038a
	ld   [de], a                                                    ; $038b
	inc  de                                                         ; $038c
	dec  bc                                                         ; $038d
	ld   a, b                                                       ; $038e
	or   c                                                          ; $038f
	jr   nz, :-                                                     ; $0390

; OBJ+BG region
	ld   hl, Gfx_TileData+$800                                      ; $0392
	ld   de, _VRAM+$800                                             ; $0395
	ld   bc, $0800                                                  ; $0398
:	ld   a, [hl+]                                                   ; $039b
	ld   [de], a                                                    ; $039c
	inc  de                                                         ; $039d
	dec  bc                                                         ; $039e
	ld   a, b                                                       ; $039f
	or   c                                                          ; $03a0
	jr   nz, :-                                                     ; $03a1

; OBJ region
	ld   hl, Gfx_TileData                                           ; $03a3
	ld   de, _VRAM                                                  ; $03a6
	ld   bc, $0800                                                  ; $03a9
:	ld   a, [hl+]                                                   ; $03ac
	ld   [de], a                                                    ; $03ad
	inc  de                                                         ; $03ae
	dec  bc                                                         ; $03af
	ld   a, b                                                       ; $03b0
	or   c                                                          ; $03b1
	jr   nz, :-                                                     ; $03b2

	ret                                                             ; $03b4


OamDmaFunc:
	di                                                              ; $03b5
	ld   a, HIGH(wOam)                                              ; $03b6
	ldh  [rDMA], a                                                  ; $03b8
	ld   a, $28                                                     ; $03ba

:	dec  a                                                          ; $03bc
	jr   nz, :-                                                     ; $03bd

	ei                                                              ; $03bf
	ret                                                             ; $03c0
.end:


PollInput:
	ld   a, $20                                                     ; $03c1
	ldh  [rP1], a                                                   ; $03c3
	ldh  a, [rP1]                                                   ; $03c5
	ldh  a, [rP1]                                                   ; $03c7
	ldh  a, [rP1]                                                   ; $03c9
	ldh  a, [rP1]                                                   ; $03cb
	ldh  a, [rP1]                                                   ; $03cd
	ldh  a, [rP1]                                                   ; $03cf
	ldh  a, [rP1]                                                   ; $03d1
	ldh  a, [rP1]                                                   ; $03d3
	ldh  a, [rP1]                                                   ; $03d5
	ldh  a, [rP1]                                                   ; $03d7
	and  $0f                                                        ; $03d9
	swap a                                                          ; $03db
	ld   b, a                                                       ; $03dd
	ld   a, $10                                                     ; $03de
	ldh  [rP1], a                                                   ; $03e0
	ldh  a, [rP1]                                                   ; $03e2
	ldh  a, [rP1]                                                   ; $03e4
	ldh  a, [rP1]                                                   ; $03e6
	ldh  a, [rP1]                                                   ; $03e8
	ldh  a, [rP1]                                                   ; $03ea
	ldh  a, [rP1]                                                   ; $03ec
	ldh  a, [rP1]                                                   ; $03ee
	ldh  a, [rP1]                                                   ; $03f0
	ldh  a, [rP1]                                                   ; $03f2
	ldh  a, [rP1]                                                   ; $03f4

; Combine buttons not pressed
	and  $0f                                                        ; $03f6
	or   b                                                          ; $03f8
	ldh  [hButtonsNotHeld], a                                       ; $03f9
	ld   a, $30                                                     ; $03fb
	ldh  [rP1], a                                                   ; $03fd

; Loop for every button, with previous held in C, and curr not held in A
	ld   b, $08                                                     ; $03ff
	ldh  a, [hButtonsHeld]                                          ; $0401
	ld   c, a                                                       ; $0403
	ldh  a, [hButtonsNotHeld]                                       ; $0404

;                                 not pressed | held
; prev held - inv     curr held | set*        | set
;           - inv curr not held | set         | unset*
; prev not held - inv curr held | unset       | set*
;           - inv curr not held | set         | unset
; In general, rotate prev held into curr held, and curr held inverted into not pressed
; Exceptions are marked with asterisks and swapped appropriately below
.nextButton:
; Jump if previous button held
	rrc  c                                                          ; $0406
	jr   c, .prevBtnHeld                                            ; $0408

; If not, if current held
	rrca                                                            ; $040a
	jr   nc, .currBtnHeld                                           ; $040b

; Otherwise curr pressed & normal held is not impacted
.toNextBtn:
	dec  b                                                          ; $040d
	jr   nz, .nextButton                                            ; $040e

; Once done, A is buttons not pressed, and C is buttons held
	ldh  [hButtonsNotPressed], a                                    ; $0410
	ld   a, c                                                       ; $0412
	ldh  [hButtonsHeld], a                                          ; $0413
	ret                                                             ; $0415

.prevBtnHeld:
; Jump if not currently held
	rrca                                                            ; $0416
	jr   c, .prevHeldButCurrNotHeld                                 ; $0417

; Prev held + inv curr held -> Handles asterisk 1
	set  7, a                                                       ; $0419
	jr   .toNextBtn                                                 ; $041b

.prevHeldButCurrNotHeld:
; Prev held + inv curr not held -> Handles asterisk 2
	res  7, c                                                       ; $041d
	jr   .toNextBtn                                                 ; $041f

.currBtnHeld:
; Prev not held + inv curr held -> Handles asterisk 2
	set  7, c                                                       ; $0421
	jp   .toNextBtn                                                 ; $0423


UnusedNops_0426:
	ds $445-@, 0


UnusedStub_0445:
	ret                                                             ; $0445


UnusedDisableVBlankInterrupt:
	ldh  a, [rIE]                                                   ; $0446
	and  $ff-IEF_VBLANK                                             ; $0448

:	ldh  [rIE], a                                                   ; $044a
	ret                                                             ; $044c


UnusedEnableVBlankInterrupt:
	ldh  a, [rIE]                                                   ; $044d
	or   IEF_VBLANK                                                 ; $044f
	jr   :-                                                         ; $0451


TimerInterruptHandlerStub:
	reti                                                            ; $0453


BCequBtimesE::
	push af                                                         ; $0454
	push hl                                                         ; $0455

	ld   hl, $0000                                                  ; $0456

; Start with B << 7
	ld   c, $00                                                     ; $0459
	srl  b                                                          ; $045b
	rr   c                                                          ; $045d

; Loop for 8 bits
	ld   a, $08                                                     ; $045f

.nextBit:
; For every bit of E set, add BC
; With bit 0 set, we add B << 0
	sla  e                                                          ; $0461
	jr   nc, :+                                                     ; $0463
	add  hl, bc                                                     ; $0465
:	srl  b                                                          ; $0466
	rr   c                                                          ; $0468

	dec  a                                                          ; $046a
	jr   nz, .nextBit                                               ; $046b

; Return result in BC
	ld   c, l                                                       ; $046d
	ld   b, h                                                       ; $046e

	pop  hl                                                         ; $046f
	pop  af                                                         ; $0470
	ret                                                             ; $0471


UnusedGetDiffOfAandB:
; A -= B
	sub  b                                                          ; $0472
	ld   b, a                                                       ; $0473

; If bit 7 now set, neg A
	and  $80                                                        ; $0474
	ld   a, b                                                       ; $0476
	ret  z                                                          ; $0477

	xor  $ff                                                        ; $0478
	inc  a                                                          ; $047a
	ret                                                             ; $047b



CBAequAinBCDform::
	ld   b, $ff                                                     ; $047c
	ld   c, $ff                                                     ; $047e

; C = num 100s
.loop100s:
	inc  c                                                          ; $0480
	sub  100                                                        ; $0481
	jr   nc, .loop100s                                              ; $0483

; Add back carried 100
	add  100                                                        ; $0485

; B = num 10s
.loop10s:
	inc  b                                                          ; $0487
	sub  10                                                         ; $0488
	jr   nc, .loop10s                                               ; $048a

; Add back carried 10, A = remainder ie 1s
	add  10                                                         ; $048c
	ret                                                             ; $048e


SaveAB_BCDdigits::
	ldh  [hBCD_CalcValue+1], a                                      ; $048f
	ld   a, b                                                       ; $0491
	ldh  [hBCD_CalcValue], a                                        ; $0492

; B = word / 10k
	ld   b, $ff                                                     ; $0494

.loop10k:
	inc  b                                                          ; $0496
	ldh  a, [hBCD_CalcValue]                                        ; $0497
	sub  LOW(10000)                                                 ; $0499
	ldh  [hBCD_CalcValue], a                                        ; $049b
	ldh  a, [hBCD_CalcValue+1]                                      ; $049d
	sbc  HIGH(10000)                                                ; $049f
	ldh  [hBCD_CalcValue+1], a                                      ; $04a1
	jr   nc, .loop10k                                               ; $04a3

; Add back carried 10k
	ldh  a, [hBCD_CalcValue]                                        ; $04a5
	add  LOW(10000)                                                 ; $04a7
	ldh  [hBCD_CalcValue], a                                        ; $04a9
	ldh  a, [hBCD_CalcValue+1]                                      ; $04ab
	adc  HIGH(10000)                                                ; $04ad
	ldh  [hBCD_CalcValue+1], a                                      ; $04af

; Store 10k quotient
	ld   a, b                                                       ; $04b1
	ldh  [hBCD_10kDigit], a                                         ; $04b2

; B = remainder / 1k
	ld   b, $ff                                                     ; $04b4

.loop1k:
	inc  b                                                          ; $04b6
	ldh  a, [hBCD_CalcValue]                                        ; $04b7
	sub  LOW(1000)                                                  ; $04b9
	ldh  [hBCD_CalcValue], a                                        ; $04bb
	ldh  a, [hBCD_CalcValue+1]                                      ; $04bd
	sbc  HIGH(1000)                                                 ; $04bf
	ldh  [hBCD_CalcValue+1], a                                      ; $04c1
	jr   nc, .loop1k                                                ; $04c3

; Add back carried 1k
	ldh  a, [hBCD_CalcValue]                                        ; $04c5
	add  LOW(1000)                                                  ; $04c7
	ldh  [hBCD_CalcValue], a                                        ; $04c9
	ldh  a, [hBCD_CalcValue+1]                                      ; $04cb
	adc  HIGH(1000)                                                 ; $04cd
	ldh  [hBCD_CalcValue+1], a                                      ; $04cf

; Store 1k quotient
	ld   a, b                                                       ; $04d1
	ldh  [hBCD_1kDigit], a                                          ; $04d2

; B = remainder / 100
	ld   b, $ff                                                     ; $04d4

.loop100:
	inc  b                                                          ; $04d6
	ldh  a, [hBCD_CalcValue]                                        ; $04d7
	sub  LOW(100)                                                   ; $04d9
	ldh  [hBCD_CalcValue], a                                        ; $04db
	ldh  a, [hBCD_CalcValue+1]                                      ; $04dd
	sbc  HIGH(100)                                                  ; $04df
	ldh  [hBCD_CalcValue+1], a                                      ; $04e1
	jr   nc, .loop100                                               ; $04e3

; Add back carried 100
	ldh  a, [hBCD_CalcValue]                                        ; $04e5
	add  LOW(100)                                                   ; $04e7
	ldh  [hBCD_CalcValue], a                                        ; $04e9

; Store 100 quotient
	ld   a, b                                                       ; $04eb
	ldh  [hBCD_100Digit], a                                         ; $04ec

; B = remainder / 10
	ld   b, $ff                                                     ; $04ee

.loop10:
	inc  b                                                          ; $04f0
	ldh  a, [hBCD_CalcValue]                                        ; $04f1
	sub  10                                                         ; $04f3
	ldh  [hBCD_CalcValue], a                                        ; $04f5
	jr   nc, .loop10                                                ; $04f7

; Add back carried 10, and store remainder 1s
	ldh  a, [hBCD_CalcValue]                                        ; $04f9
	add  10                                                         ; $04fb
	ldh  [hBCD_1Digit], a                                           ; $04fd
	ldh  [hBCD_1Digit], a                                           ; $04ff

; Store 10s quotient
	ld   a, b                                                       ; $0501
	ldh  [hBCD_10Digit], a                                          ; $0502
	ret                                                             ; $0504


IncAndGetRNG:
; Add 65 every time called, eg in main loop
	ld   b, $05                                                     ; $0505
	ldh  a, [hRNGValue]                                             ; $0507

:	add  $0d                                                        ; $0509
	dec  b                                                          ; $050b
	jr   nz, :-                                                     ; $050c

	ldh  [hRNGValue], a                                             ; $050e
	ret                                                             ; $0510


MainLoop:
	nop                                                             ; $0511

; Init audio and serial
	call InitAudioControlRegs                                       ; $0512
	call InitSerial                                                 ; $0515

; Set state to GS_SET_INITIAL_TOP_SCORE, and clear stage-type flags
	xor  a                                                          ; $0518
	ldh  [hGameState], a                                            ; $0519
	ldh  [hIsBonusLevel], a                                         ; $051b
	ldh  [hIsXScrollingStage], a                                    ; $051d

.loop:
	call HandleGameState                                            ; $051f
	call IncAndGetRNG                                               ; $0522
	call WaitForVBlankIntHandled                                    ; $0525
	jp   .loop                                                      ; $0528


HandleGameState:
; Jump if start not held
	ldh  a, [hButtonsNotHeld]                                       ; $052b
	and  PADF_START                                                 ; $052d
	jr   nz, .afterResetCheck                                       ; $052f

; Jump if select not pressed
	ldh  a, [hButtonsNotPressed]                                    ; $0531
	and  PADF_SELECT                                                ; $0533
	jr   nz, .afterResetCheck                                       ; $0535

; Soft reset takes us back to the title screen
	ld   a, GS_RESET_TO_TITLE_SCREEN                                ; $0537
	ldh  [hGameState], a                                            ; $0539
	ret                                                             ; $053b

.afterResetCheck:
; Game state is a double idx into below table
	ldh  a, [hGameState]                                            ; $053c
	sla  a                                                          ; $053e
	ld   c, a                                                       ; $0540
	ld   b, $00                                                     ; $0541
	ld   hl, .gameStates                                            ; $0543
	add  hl, bc                                                     ; $0546

; Jump to state handler
	ld   a, [hl+]                                                   ; $0547
	ld   b, a                                                       ; $0548
	ld   h, [hl]                                                    ; $0549
	ld   l, b                                                       ; $054a
	jp   hl                                                         ; $054b

.gameStates:
	dw GameState0_SetInitialTopScore
	dw GameState1_ResetToTitleScreen
	dw GameState2_TitleScreen
	dw GameState3_DemoInit
	dw GameState4_InGameInit
	dw GameState5_WaitingForBall
	dw GameState6_InGameMain
	dw GameState7_BallExploding
	dw GameState8_StageComplete
	dw GameState9_GameComplete
	dw GameStateA_BonusStageComplete
	dw GameStateB_GameOver
	dw GameStateC_Paused
	dw GameStateStub
	dw GameStateStub
	dw GameStateStub


GameState0_SetInitialTopScore:
;  Start game with a high score of 200, then go to next state
	ld   a, LOW(200)                                                ; $056c
	ldh  [hTopScore], a                                             ; $056e
	lda  HIGH(200)                                                  ; $0570
	ldh  [hTopScore+1], a                                           ; $0571

	ld   a, GS_RESET_TO_TITLE_SCREEN                                ; $0573
	ldh  [hGameState], a                                            ; $0575
	ret                                                             ; $0577


GameState1_ResetToTitleScreen:
; Set counter to 4, so inc and loop in below state plays song, then set next state
	ld   a, $04                                                     ; $0578
	ld   [wReturnedToTitleScreenCounter], a                         ; $057a

	ld   a, GS_TITLE_SCREEN                                         ; $057d
	ldh  [hGameState], a                                            ; $057f
	ret                                                             ; $0581


GameState2_TitleScreen:
; Turn off LCD, and disable vblank int after handled
	call TurnOffLCDandWaitForVBlankIntHandled                       ; $0582
	call PreserveAndClearIE                                         ; $0585

; Disable LCD interrupt
	ldh  a, [hIE]                                                   ; $0588
	and  $ff-IEF_LCDC                                               ; $058a
	ldh  [hIE], a                                                   ; $058c

; Clear screen and oam
	call ClearScreen0                                               ; $058e
	call ClearShadowOam                                             ; $0591

; Load title screen layout, with top score
	ld   de, DecompressedLayout_TitleScreen                         ; $0594
	call DecompressData                                             ; $0597
	call AddTitleScreenTopScoreOam                                  ; $059a

; Set standard palettes, and hide window
	ld   a, %11100100                                               ; $059d
	ldh  [rBGP], a                                                  ; $059f

	ldh  a, [hLCDC]                                                 ; $05a1
	and  $ff-LCDCF_WINON                                            ; $05a3
	ldh  [hLCDC], a                                                 ; $05a5

; Restore interrupts and turn on LCD
	call RestoreIE                                                  ; $05a7
	call TurnOnLCD                                                  ; $05aa

; Inc counter, looping 5-> 0
	ld   a, [wReturnedToTitleScreenCounter]                         ; $05ad
	inc  a                                                          ; $05b0
	cp   $05                                                        ; $05b1
	jr   nz, :+                                                     ; $05b3
	xor  a                                                          ; $05b5
:	ld   [wReturnedToTitleScreenCounter], a                         ; $05b6

; If it's 0, play song 1, else don't have any new sounds play
	cp   $00                                                        ; $05b9
	push af                                                         ; $05bb
	push af                                                         ; $05bc
	call z, AllowSoundsToStart                                      ; $05bd
	pop  af                                                         ; $05c0
	call z, StartSong1                                              ; $05c1
	pop  af                                                         ; $05c4
	call nz, PreventSoundsFromStarting                              ; $05c5

; Go to demo after $300 frames
	ld   a, $03                                                     ; $05c8
	ld   [wNum100hFramesUntilDemoTransition], a                     ; $05ca

.mainLoop:
	call WaitForVBlankIntHandled                                    ; $05cd

; Every $100 frames..
	ldh  a, [hFrameCounter]                                         ; $05d0
	cp   $00                                                        ; $05d2
	jr   nz, .afterDemoCheck                                        ; $05d4

; Go to demo once frame counter reaches 0
	ld   a, [wNum100hFramesUntilDemoTransition]                     ; $05d6
	dec  a                                                          ; $05d9
	ld   [wNum100hFramesUntilDemoTransition], a                     ; $05da
	jr   z, .setDemoState                                           ; $05dd

.afterDemoCheck:
; Jump when start pressed
	ldh  a, [hButtonsNotPressed]                                    ; $05df
	and  PADF_START                                                 ; $05e1
	jr   z, .startPressed                                           ; $05e3

; Continue to game if linked
	ldh  a, [hPrevAndCurrSBsCombined]                               ; $05e5
	and  $80                                                        ; $05e7
	jr   nz, .mainLoop                                              ; $05e9

.startPressed:
; Clear counter vars, and more lives threshold idx
	xor  a                                                          ; $05eb
	ld   [wCurrStage], a                                            ; $05ec
	ld   [wDisplayedStage], a                                       ; $05ef
	ld   [wNumBonusStagesVisited], a                                ; $05f2
	ldh  [hCurrMoreLivesScoreThresholdIdx], a                       ; $05f5

; Start with 0 curr score, and 4 lives
	ldh  [hCurrScore], a                                            ; $05f7
	ldh  [hCurrScore+1], a                                          ; $05f9
	
	ld   a, $04                                                     ; $05fb
	ld   [wLivesLeft], a                                            ; $05fd

; Set actual score to pass, allow sounds to play and init screen
	call SetScoreThresholdForMoreLives                              ; $0600
	call AllowSoundsToStart                                         ; $0603
	call InitInGameScreen                                           ; $0606

; Start going to in-game state
	ld   a, GS_IN_GAME_INIT                                         ; $0609
	ldh  [hGameState], a                                            ; $060b
	ret                                                             ; $060d

.setDemoState:
	ld   a, GS_DEMO_INIT                                            ; $060e
	ldh  [hGameState], a                                            ; $0610
	ret                                                             ; $0612


GameState3_DemoInit:
; No sounds during demo, init game screen
	call PreventSoundsFromStarting                                  ; $0613
	call InitInGameScreen                                           ; $0616

.tryGettingRandomStage:
; Set current stage to 1 of the 32
	call IncAndGetRNG                                               ; $0619
	and  $1f                                                        ; $061c
	ld   [wCurrStage], a                                            ; $061e

; Use as triple idx into the level layouts
	ld   b, a                                                       ; $0621
	ld   e, $03                                                     ; $0622
	call BCequBtimesE                                               ; $0624
	ld   hl, LevelLayouts                                           ; $0627
	add  hl, bc                                                     ; $062a

; If it's a bonus level, try again
	ld   a, [hl]                                                    ; $062b
	bit  7, a                                                       ; $062c
	jr   nz, .tryGettingRandomStage                                 ; $062e

; Displayed stage incs to 0
	ld   a, $ff                                                     ; $0630
	ld   [wDisplayedStage], a                                       ; $0632

; Clear scroll and num lives
	inc  a                                                          ; $0635
	ldh  [hCurrScore], a                                            ; $0636
	ldh  [hCurrScore+1], a                                          ; $0638
	ld   [wLivesLeft], a                                            ; $063a

; Finally init in-game vars, display, etc, then set timer until this state is done
	call GameState4_InGameInit                                      ; $063d
	ld   a, $0a                                                     ; $0640
	ld   [wNum100hFramesUntilDemoTransition], a                     ; $0642

; Have paddle lengthened and start moving ball
	call ProcessPaddleLengthening                                   ; $0645
	call StartBallAppearingAndMoving                                ; $0648

; Start paddle where ball is, then wait
	ldh  a, [hBallX]                                                ; $064b
	sub  $0b                                                        ; $064d
	ldh  [hPaddleX], a                                              ; $064f
	call UpdatePaddleOam                                            ; $0651

	ld   a, $10                                                     ; $0654
	call WaitForAVBlankIntsHandled                                  ; $0656

.mainLoop:
; Update scrolling rows, and process ball and paddle
	call UpdateScrollingStageVars                                   ; $0659
	call ProcessBallMovementCollisionAndOam                         ; $065c
	call UpdatePaddleOam                                            ; $065f

; B = paddle's max X before it hits the right side of the screen
	ldh  a, [hPaddlePixelLength]                                    ; $0662
	ld   b, a                                                       ; $0664
	ld   a, $80                                                     ; $0665
	sub  b                                                          ; $0667
	ld   b, a                                                       ; $0668

; Keep paddle where ball is
	ldh  a, [hBallX]                                                ; $0669
	sub  $0b                                                        ; $066b
	ldh  [hPaddleX], a                                              ; $066d
	call AdjustPaddleXIfBreachingScreenEnds                         ; $066f

; Process rng, then wait until next frame
	call IncAndGetRNG                                               ; $0672
	call WaitForVBlankIntHandled                                    ; $0675

; If start pressed, act as if soft-resetted, eg play music
	ldh  a, [hButtonsNotPressed]                                    ; $0678
	and  PADF_START                                                 ; $067a
	jr   z, .softReset                                              ; $067c

; Perform soft reset if linked
	ldh  a, [hPrevAndCurrSBsCombined]                               ; $067e
	and  $80                                                        ; $0680
	jr   z, .softReset                                              ; $0682

; Every time frame counter reaches 0..
	ldh  a, [hFrameCounter]                                         ; $0684
	cp   $00                                                        ; $0686
	jr   nz, .mainLoop                                              ; $0688

; Set that $100 frames have passed..
	ld   a, [wNum100hFramesUntilDemoTransition]                     ; $068a
	dec  a                                                          ; $068d
	ld   [wNum100hFramesUntilDemoTransition], a                     ; $068e
	jr   nz, .mainLoop                                              ; $0691

; And once 0 (demo ended), wait and go back to title screen
	ld   a, $20                                                     ; $0693
	call WaitForAVBlankIntsHandled                                  ; $0695
	
	ld   a, GS_TITLE_SCREEN                                         ; $0698
	ldh  [hGameState], a                                            ; $069a
	ret                                                             ; $069c

.softReset:
	ld   a, GS_RESET_TO_TITLE_SCREEN                                ; $069d
	ldh  [hGameState], a                                            ; $069f
	ret                                                             ; $06a1


GameState4_InGameInit:
; Clear some texts
	call ClearTimeOam                                               ; $06a2
	call ClearSpecialBonusPts                                       ; $06a5

; Clear stage-type vars
	xor  a                                                          ; $06a8
	ldh  [hIsBonusLevel], a                                         ; $06a9
	ldh  [hIsXScrollingStage], a                                    ; $06ab

; Start not shortened
	ldh  [hPaddleShortened], a                                      ; $06ad
	ld   a, $18                                                     ; $06af
	ldh  [hPaddlePixelLength], a                                    ; $06b1

; Have HL point to level layout table for the curr stage
	ld   a, [wCurrStage]                                            ; $06b3
	ld   b, a                                                       ; $06b6
	ld   e, $03                                                     ; $06b7
	call BCequBtimesE                                               ; $06b9
	ld   hl, LevelLayouts                                           ; $06bc
	add  hl, bc                                                     ; $06bf

; Bit 7 determines if bonus stage, else inc displayed stage
	ld   a, [hl]                                                    ; $06c0
	bit  7, a                                                       ; $06c1
	push af                                                         ; $06c3
	push af                                                         ; $06c4
	call nz, InitBonusLevelVars                                     ; $06c5
	pop  af                                                         ; $06c8
	call z, IncDisplayedStage                                       ; $06c9

; Bit 6 determines if it's a stage with X scrolling bricks
	pop  af                                                         ; $06cc
	bit  6, a                                                       ; $06cd
	call nz, InitScrollingStageVars                                 ; $06cf

; Set initial paddle coords
	ld   a, $28                                                     ; $06d2
	ldh  [hPaddleX], a                                              ; $06d4
	ld   a, $90                                                     ; $06d6
	ldh  [hPaddleY], a                                              ; $06d8

; Populate bricks buffers, save num bricks to clear, and clear scrolls
	ld   a, [wCurrStage]                                            ; $06da
	call LoadBrickLayoutAndBreakableIntoBuffers                     ; $06dd
	call SaveNumBricksInStage                                       ; $06e0
	call ClearsRegAndRowScrolls                                     ; $06e3

; Clear the 1st brick row idx we change LYC on
	xor  a                                                          ; $06e6
	ldh  a, [hBrickRowIdxToSetLYCfor]                               ; $06e7

; Display relevant oam to finish displaying stage
	call LoadInGameLeftColumnOam                                    ; $06e9
	call AddInGameTopAndCurrScoreOam                                ; $06ec
	call DisplayLivesLeft                                           ; $06ef
	call Stub_4a29                                                  ; $06f2

; If stage == 1, show Mario jumping into the paddle
	ld   a, [wDisplayedStage]                                       ; $06f5
	cp   $01                                                        ; $06f8
	call z, AnimateMarioRunningAndJumpingIntoPaddle                 ; $06fa

; Display the relevant level text based on if bonus level
	ldh  a, [hIsBonusLevel]                                         ; $06fd
	cp   $00                                                        ; $06ff
	push af                                                         ; $0701
	call z, AddStageAndNumOam                                       ; $0702
	pop  af                                                         ; $0705
	call nz, AddBonusTextOam                                        ; $0706

; Display vars on the right side of the screen, and wait
	call AddInGameTopAndCurrScoreOam                                ; $0709
	call Stub_4a29                                                  ; $070c
	call DisplayLivesLeft                                           ; $070f
	call DisplayCurrStage                                           ; $0712
	ld   a, $10                                                     ; $0715
	call WaitForAVBlankIntsHandled                                  ; $0717

; Display brick layout, clear flashed text, and load left column oam
	call VBlankEnqueueBrickTileLayout                               ; $071a
	call ClearShadowOam                                             ; $071d
	call AddInGameTopAndCurrScoreOam                                ; $0720
	call Stub_4a29                                                  ; $0723
	call LoadInGameLeftColumnOam                                    ; $0726

; Set up timer vars, display and music for bonus stages
	ldh  a, [hIsBonusLevel]                                         ; $0729
	cp   $00                                                        ; $072b
	call nz, InitBonusStageTimerDisplaysAndSong                     ; $072d

; Start with the slowest counter until layout falls
	xor  a                                                          ; $0730
	ldh  [hFallingLayoutSpeedIdx], a                                ; $0731

; Go to next state
	ld   a, GS_WAITING_FOR_BALL                                     ; $0733
	ldh  [hGameState], a                                            ; $0735
	ret                                                             ; $0737


InitBonusLevelVars:
; Set flag and inc num visited
	ld   a, $01                                                     ; $0738
	ldh  [hIsBonusLevel], a                                         ; $073a

	ld   a, [wNumBonusStagesVisited]                                ; $073c
	inc  a                                                          ; $073f
	ld   [wNumBonusStagesVisited], a                                ; $0740
	ret                                                             ; $0743


IncDisplayedStage:
	ld   a, [wDisplayedStage]                                       ; $0744
	inc  a                                                          ; $0747
	ld   [wDisplayedStage], a                                       ; $0748
	ret                                                             ; $074b


InitScrollingStageVars:
; HL = low 6 bits idxed into table for scroll data
	and  $3f                                                        ; $074c
	sla  a                                                          ; $074e
	ld   c, a                                                       ; $0750
	ld   b, $00                                                     ; $0751
	ld   hl, ScrollXSetups                                          ; $0753
	add  hl, bc                                                     ; $0756

; HL = word pointed to
	ld   a, [hl+]                                                   ; $0757
	ld   h, [hl]                                                    ; $0758
	ld   l, a                                                       ; $0759

; Copy to counter + direction
	ld   bc, wHorizScrollDirection                                  ; $075a
	ld   de, wHorizScrollCounter                                    ; $075d
	ld   a, NUM_SCROLL_ROWS                                         ; $0760

.nextRow:
; Byte read determines direction (bit 7) + counter (low 7 bits)
	push af                                                         ; $0762
	ld   a, [hl+]                                                   ; $0763
	ld   [bc], a                                                    ; $0764
	and  $7f                                                        ; $0765
	ld   [de], a                                                    ; $0767
	inc  bc                                                         ; $0768
	inc  de                                                         ; $0769

; To next row
	pop  af                                                         ; $076a
	dec  a                                                          ; $076b
	jr   nz, .nextRow                                               ; $076c

; Finally set flag so scroll vals are processed
	ld   a, $01                                                     ; $076e
	ldh  [hIsXScrollingStage], a                                    ; $0770
	ret                                                             ; $0772


GameState5_WaitingForBall:
; Continue updating scrolls while waiting, and paddle movement
	call UpdateScrollingStageVars                                   ; $0773
	call ProcessPaddleMovementAndOam                                ; $0776

; Jump if A pressed
	ldh  a, [hButtonsNotPressed]                                    ; $0779
	and  PADF_A                                                     ; $077b
	jr   z, StartBallAppearingAndMoving                             ; $077d

; Have ball move immediately if linked
	ldh  a, [hPrevAndCurrSBsCombined]                               ; $077f
	and  $80                                                        ; $0781
	ret  nz                                                         ; $0783

StartBallAppearingAndMoving:
; Clear counters for ball speed
	xor  a                                                          ; $0784
	ldh  [hCounterUntilBallIncreasesSpeed], a                       ; $0785
	ldh  [hUpdateBallSpeedCounter], a                               ; $0787

; Set counter vars for falling layout, and display ball moving
	call ProcessFallingLayoutCounter                                ; $0789
	call SetInitialBallSpeedAndCoords                               ; $078c

; Display lives left and play square effect
	call Stub_4a29                                                  ; $078f
	call DisplayLivesLeft                                           ; $0792
	call StartSquareEffect7                                         ; $0795

; Play a different song if bonus level
	ldh  a, [hIsBonusLevel]                                         ; $0798
	cp   $00                                                        ; $079a
	call nz, StartSong6                                             ; $079c

; Go to main gameplay state
	ld   a, GS_IN_GAME_MAIN                                         ; $079f
	ldh  [hGameState], a                                            ; $07a1
	ret                                                             ; $07a3


GameState6_InGameMain:
; Handle timer if a bonus level
	ldh  a, [hIsBonusLevel]                                         ; $07a4
	cp   $00                                                        ; $07a6
	call nz, HandleBonusStageTimer                                  ; $07a8

; Update scrolls, ball object and paddle object
	call UpdateScrollingStageVars                                   ; $07ab
	call ProcessBallMovementCollisionAndOam                         ; $07ae
	call ProcessPaddleMovementAndOam                                ; $07b1

; Jump if start pressed
	ldh  a, [hButtonsNotPressed]                                    ; $07b4
	and  PADF_START                                                 ; $07b6
	jr   z, .tryPause                                               ; $07b8

; Pause if SB sent twice without bit 7 set
	ldh  a, [hPrevAndCurrSBsCombined]                               ; $07ba
	and  $80                                                        ; $07bc
	ret  nz                                                         ; $07be

	ld   a, $ff                                                     ; $07bf
	ldh  [hPrevAndCurrSBsCombined], a                               ; $07c1

.tryPause:
; Don't allow pausing for bonus levels
	ldh  a, [hIsBonusLevel]                                         ; $07c3
	cp   $00                                                        ; $07c5
	ret  nz                                                         ; $07c7

; Display pause, play song 4, then set state
	call AddPauseTextOam                                            ; $07c8
	call StartSong4                                                 ; $07cb

	ld   a, GS_PAUSED                                               ; $07ce
	ldh  [hGameState], a                                            ; $07d0
	ret                                                             ; $07d2


GameState7_BallExploding:
; Clear sounds, animate explosion, then wait
	call InitSound                                                  ; $07d3
	call AnimateBallExploding                                       ; $07d6

	ld   a, $40                                                     ; $07d9
	call WaitForAVBlankIntsHandled                                  ; $07db

; If bonus level, stage is done
	ldh  a, [hIsBonusLevel]                                         ; $07de
	cp   $00                                                        ; $07e0
	jr   nz, GameState8_StageComplete                               ; $07e2

; Else go to game over
	ld   a, GS_GAME_OVER                                            ; $07e4
	ldh  [hGameState], a                                            ; $07e6

; Dec and display lives, without looping, not resetting state if 0 lives left
	ld   a, [wLivesLeft]                                            ; $07e8
	cp   $00                                                        ; $07eb
	ret  z                                                          ; $07ed

	dec  a                                                          ; $07ee
	ld   [wLivesLeft], a                                            ; $07ef
	call DisplayLivesLeft                                           ; $07f2

; Reset paddle to lengthened state
	xor  a                                                          ; $07f5
	ldh  [hPaddleShortened], a                                      ; $07f6
	ld   a, $18                                                     ; $07f8
	ldh  [hPaddlePixelLength], a                                    ; $07fa

; Ball starts slightly faster than when stage started
	ld   a, $02                                                     ; $07fc
	ldh  [hFallingLayoutSpeedIdx], a                                ; $07fe

; Go to state where we wait for the ball
	ld   a, GS_WAITING_FOR_BALL                                     ; $0800
	ldh  [hGameState], a                                            ; $0802
	ret                                                             ; $0804


GameState8_StageComplete:
; If not bonus level, play a song, otherwise handle the complete stage state
	ldh  a, [hIsBonusLevel]                                         ; $0805
	cp   $00                                                        ; $0807
	push af                                                         ; $0809
	call z, StartSong5andWait                                       ; $080a
	pop  af                                                         ; $080d
	call nz, GameStateA_BonusStageComplete                          ; $080e

; Inc curr stage, and init it
	call IncCurrStage                                               ; $0811
	ld   b, GS_IN_GAME_INIT                                         ; $0814

; If looped past last stage, go to game complete state instead
	ld   a, [wCurrStage]                                            ; $0816
	cp   $00                                                        ; $0819
	jr   nz, :+                                                     ; $081b
	ld   b, GS_GAME_COMPLETE                                        ; $081d
:	ld   a, b                                                       ; $081f
	ldh  [hGameState], a                                            ; $0820
	ret                                                             ; $0822


StartSong5andWait:
	call StartSong5                                                 ; $0823
	ld   a, $90                                                     ; $0826
	jp   WaitForAVBlankIntsHandled                                  ; $0828


IncCurrStage:
; Inc stage, looping $20->0
	ld   a, [wCurrStage]                                            ; $082b
	inc  a                                                          ; $082e
	cp   $20                                                        ; $082f
	jr   c, :+                                                      ; $0831
	ld   a, $00                                                     ; $0833
:	ld   [wCurrStage], a                                            ; $0835
	ret                                                             ; $0838


GameState9_GameComplete:
; Fade out and disable lcd interrupt
	call FadeOut                                                    ; $0839
	ldh  a, [hIE]                                                   ; $083c
	and  $ff-IEF_LCDC                                               ; $083e
	ldh  [hIE], a                                                   ; $0840

; Display game screen, and again, disable lcd interrupt
	call InitInGameScreen                                           ; $0842
	ldh  a, [hIE]                                                   ; $0845
	and  $ff-IEF_LCDC                                               ; $0847
	ldh  [hIE], a                                                   ; $0849
	ldh  [rIE], a                                                   ; $084b

; Display usual rest of game screen, except bricks + paddle
	call LoadInGameLeftColumnOam                                    ; $084d
	call AddInGameTopAndCurrScoreOam                                ; $0850
	call DisplayLivesLeft                                           ; $0853
	call Stub_4a29                                                  ; $0856
	call DisplayCurrStage                                           ; $0859

; Play song and fade back in
	call StartSongC                                                 ; $085c
	call FadeIn                                                     ; $085f

; Wait $2a1 frames
	ld   a, $00                                                     ; $0862
	call WaitForAVBlankIntsHandled                                  ; $0864
	ld   a, $00                                                     ; $0867
	call WaitForAVBlankIntsHandled                                  ; $0869
	ld   a, $a0                                                     ; $086c
	call WaitForAVBlankIntsHandled                                  ; $086e
	ld   a, $01                                                     ; $0871
	call WaitForAVBlankIntsHandled                                  ; $0873

; Have Mario blink, then wait $101 frames
	call AnimateBigMarioBlinking                                    ; $0876
	ld   a, $00                                                     ; $0879
	call WaitForAVBlankIntsHandled                                  ; $087b
	ld   a, $01                                                     ; $087e
	call WaitForAVBlankIntsHandled                                  ; $0880

; Display the Try Again text, and wait
	call DisplayTryAgain                                            ; $0883
	ld   a, $c0                                                     ; $0886
	call WaitForAVBlankIntsHandled                                  ; $0888

; Clear try again and fade out
	call ClearTryAgain                                              ; $088b
	call FadeOut                                                    ; $088e

; Re-enable lcdc interrupt
	ldh  a, [hIE]                                                   ; $0891
	or   IEF_LCDC                                                   ; $0893
	ldh  [hIE], a                                                   ; $0895
	ldh  [rIE], a                                                   ; $0897

; Clear bricks buffer and clear in game layout
	call ClearBrickTypeAndBreakableBuffer                           ; $0899
	call VBlankEnqueueClearedInGameLayout                           ; $089c

; Fade in and go back to the game from the 1st level
	call FadeIn                                                     ; $089f
	ld   a, GS_IN_GAME_INIT                                         ; $08a2
	ldh  [hGameState], a                                            ; $08a4
	ret                                                             ; $08a6


FadeIn:
	ld   hl, FadeInPalettes                                         ; $08a7
	jr   :+                                                         ; $08aa

FadeOut:
	ld   hl, FadeOutPalettes                                        ; $08ac

:	ld   b, $04                                                     ; $08af

.loop:
; Get palette val and set palettes
	ld   a, [hl+]                                                   ; $08b1
	call SetPalettes                                                ; $08b2

; Wait $10 frames before repeating until all 4 palette vals are done
	push bc                                                         ; $08b5
	push hl                                                         ; $08b6
	ld   a, $10                                                     ; $08b7
	call WaitForAVBlankIntsHandled                                  ; $08b9
	pop  hl                                                         ; $08bc
	pop  bc                                                         ; $08bd
	dec  b                                                          ; $08be
	jr   nz, .loop                                                  ; $08bf

	ret                                                             ; $08c1


FadeInPalettes:
	db %00000000
	db %01000000
	db %10010000
	db %11100100


FadeOutPalettes:
	db %11100100
	db %10010000
	db %01000000
	db %00000000
	

; A - palette val
SetPalettes::
	ldh  [rBGP], a                                                  ; $08ca
	ldh  [rOBP0], a                                                 ; $08cc
	ldh  [rOBP1], a                                                 ; $08ce
	ret                                                             ; $08d0


GameStateB_GameOver:
; Have Mario fall off screen and wait
	call AnimateMarioFallingOffScreen                               ; $08d1
	ld   a, $40                                                     ; $08d4
	call WaitForAVBlankIntsHandled                                  ; $08d6

; Turn off lcd, clear interrupts, screen and oam
	call TurnOffLCDandWaitForVBlankIntHandled                       ; $08d9
	call PreserveAndClearIE                                         ; $08dc
	call ClearScreen0                                               ; $08df
	call ClearShadowOam                                             ; $08e2

; Hide game screen's window
	ldh  a, [hLCDC]                                                 ; $08e5
	and  $ff-LCDCF_WINON                                            ; $08e7
	ldh  [hLCDC], a                                                 ; $08e9

; Disable lcdc interrupt
	ldh  a, [hIE]                                                   ; $08eb
	and  $ff-IEF_LCDC                                               ; $08ed
	ldh  [hIE], a                                                   ; $08ef

; Play song, display game over, restore interrupts, then turn on LCD
	call StartSong3                                                 ; $08f1
	call AddGameOverOam                                             ; $08f4
	call RestoreIE                                                  ; $08f7
	call TurnOnLCD                                                  ; $08fa

; Wait, then soft reset
	ld   a, $c0                                                     ; $08fd
	call WaitForAVBlankIntsHandled                                  ; $08ff
	
	ld   a, GS_RESET_TO_TITLE_SCREEN                                ; $0902
	ldh  [hGameState], a                                            ; $0904
	ret                                                             ; $0906


GameStateC_Paused:
; Jump when start pressed
	ldh  a, [hButtonsNotPressed]                                    ; $0907
	and  PADF_START                                                 ; $0909
	jr   z, .unpause                                                ; $090b

; Unpause if SB sent twice without bit 7 set
	ldh  a, [hPrevAndCurrSBsCombined]                               ; $090d
	and  $80                                                        ; $090f
	ret  nz                                                         ; $0911

	ld   a, $ff                                                     ; $0912
	ldh  [hPrevAndCurrSBsCombined], a                               ; $0914

.unpause:
; Clear all oam, then re-add just score + left column
	call ClearShadowOam                                             ; $0916
	call AddInGameTopAndCurrScoreOam                                ; $0919
	call Stub_4a29                                                  ; $091c
	call LoadInGameLeftColumnOam                                    ; $091f

; Play song, then resume main game state
	call StartSong4                                                 ; $0922
	ld   a, GS_IN_GAME_MAIN                                         ; $0925
	ldh  [hGameState], a                                            ; $0927
	ret                                                             ; $0929


; A - curr stage
LoadBrickLayoutAndBreakableIntoBuffers:
; HL = triple curr stage idx into table
	ld   b, a                                                       ; $092a
	ld   e, $03                                                     ; $092b
	call BCequBtimesE                                               ; $092d
	ld   hl, LevelLayouts                                           ; $0930
	add  hl, bc                                                     ; $0933

; Skip 1st byte and get DE = pointer to layout addr
	inc  hl                                                         ; $0934
	ld   e, [hl]                                                    ; $0935
	inc  hl                                                         ; $0936
	ld   d, [hl]                                                    ; $0937

; Clear current brick data in ram, then clear layout
	push de                                                         ; $0938
	call ClearBrickTypeAndBreakableBuffer                           ; $0939
	call VBlankEnqueueClearedInGameLayout                           ; $093c
	pop  de                                                         ; $093f

; Start populating both buffers, B = row
	ld   hl, wBrickLayoutBuffer                                     ; $0940
	ld   b, $00                                                     ; $0943

.loopTilFF:
; Loop for every brick col
	ld   c, NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2                        ; $0945

.loopCol:
	push bc                                                         ; $0947
	push de                                                         ; $0948
	push hl                                                         ; $0949

; Store 1 byte for brick type into the buffer, jump if it was 0
	ld   a, [de]                                                    ; $094a
	ld   [hl], a                                                    ; $094b
	cp   $00                                                        ; $094c
	jr   z, .afterBrickTypeCheck                                    ; $094e

; HL points to metadata for brick type
	push hl                                                         ; $0950
	dec  a                                                          ; $0951
	ld   b, a                                                       ; $0952
	ld   e, $06                                                     ; $0953
	call BCequBtimesE                                               ; $0955
	ld   hl, BricksMetadata                                         ; $0958
	add  hl, bc                                                     ; $095b

; Get 4th byte
	ld   b, $00                                                     ; $095c
	ld   c, $03                                                     ; $095e
	add  hl, bc                                                     ; $0960

; Low nybble of the 4th byte determines if the brick is breakable
	ld   a, [hl]                                                    ; $0961
	and  $0f                                                        ; $0962
	pop  hl                                                         ; $0964
	ld   bc, wBreakableBricksBuffer-wBrickLayoutBuffer              ; $0965
	add  hl, bc                                                     ; $0968
	ld   [hl], a                                                    ; $0969

.afterBrickTypeCheck:
	pop  hl                                                         ; $096a
	pop  de                                                         ; $096b
	pop  bc                                                         ; $096c

; To next col
	inc  hl                                                         ; $096d
	inc  de                                                         ; $096e
	dec  c                                                          ; $096f
	jr   nz, .loopCol                                               ; $0970

; Inc row, and keep going until $ff found
	inc  b                                                          ; $0972
	ld   a, [de]                                                    ; $0973
	cp   $ff                                                        ; $0974
	jr   nz, .loopTilFF                                             ; $0976

; Num rows processed is num brick rows
	ld   a, b                                                       ; $0978
	ldh  [hNumBrickRowsForStage], a                                 ; $0979

; For layouts >= $14 brick rows, store the current rows hidden from view
	sub  $14                                                        ; $097b
	jr   nc, :+                                                     ; $097d
	xor  a                                                          ; $097f
:	ldh  [hNumBrickRowsOnTopOfCurrLayout], a                        ; $0980
	ret                                                             ; $0982


ClearBrickTypeAndBreakableBuffer:
	ld   hl, wBrickLayoutBuffer                                     ; $0983
	ld   de, wBreakableBricksBuffer                                 ; $0986
	ld   bc, wBrickLayoutBuffer.end-wBrickLayoutBuffer              ; $0989

.loop:
; Clear both layout and breakable status
	ld   a, $00                                                     ; $098c
	ld   [hl+], a                                                   ; $098e
	ld   [de], a                                                    ; $098f
	inc  de                                                         ; $0990

; To next entry in the buffer
	dec  bc                                                         ; $0991
	ld   a, b                                                       ; $0992
	or   c                                                          ; $0993
	jr   nz, .loop                                                  ; $0994

	ret                                                             ; $0996


VBlankEnqueueBrickTileLayout:
; Brick row to draw to is num-2 (as we draw from row 2 downwards)
	ldh  a, [hNumBrickRowsForStage]                                 ; $0997
	dec  a                                                          ; $0999
	dec  a                                                          ; $099a
	ldh  [hGameplayScreenBrickRowToDrawTo], a                       ; $099b

; Loop for 10 rows at most
	ld   a, $0a                                                     ; $099d

.nextTileRow:
; Display a tile row
	push af                                                         ; $099f
	call VBlankEnqueueBrickTileLayoutRow                            ; $09a0
	call WaitForVBlankIntHandled                                    ; $09a3

; Go up 2 brick rows (next tile row)
	ldh  a, [hGameplayScreenBrickRowToDrawTo]                       ; $09a6
	dec  a                                                          ; $09a8
	dec  a                                                          ; $09a9
	ldh  [hGameplayScreenBrickRowToDrawTo], a                       ; $09aa

; To next tile row
	pop  af                                                         ; $09ac
	dec  a                                                          ; $09ad
	jr   nz, .nextTileRow                                           ; $09ae

; If there are any rows on top, display the last one as the 1st row
	ldh  a, [hNumBrickRowsOnTopOfCurrLayout]                        ; $09b0
	cp   $00                                                        ; $09b2
	ret  z                                                          ; $09b4

	dec  a                                                          ; $09b5
	ldh  [hGameplayScreenBrickRowToDrawTo], a                       ; $09b6
	jp   VBlankEnqueueBrickTileLayoutRow                            ; $09b8


VBlankEnqueueClearedInGameLayout:
; Start clearing from the bottom
	ld   a, $3a                                                     ; $09bb
	ldh  [hGameplayScreenBrickRowToDrawTo], a                       ; $09bd

.loop:
; Clear row in vblank
	call VBlankEnqueueBrickTileLayoutRow                            ; $09bf
	call WaitForVBlankIntHandled                                    ; $09c2

; Return when we've updated the top
	ldh  a, [hGameplayScreenBrickRowToDrawTo]                       ; $09c5
	cp   $00                                                        ; $09c7
	ret  z                                                          ; $09c9

; Else go to next tile row
	dec  a                                                          ; $09ca
	dec  a                                                          ; $09cb
	ldh  [hGameplayScreenBrickRowToDrawTo], a                       ; $09cc
	jr   .loop                                                      ; $09ce


SaveNumBricksInStage:
; DE keeps track of num bricks
	ld   hl, wBrickLayoutBuffer                                     ; $09d0
	ld   de, $0000                                                  ; $09d3
	ld   bc, wBrickLayoutBuffer.end-wBrickLayoutBuffer              ; $09d6

.nextBrick:
	push bc                                                         ; $09d9
	push hl                                                         ; $09da

; Jump if no brick at location
	ld   a, [hl]                                                    ; $09db
	cp   $00                                                        ; $09dc
	jr   z, .toNextBrick                                            ; $09de

; Get breakable status, jumping if not breakable
	ld   bc, wBreakableBricksBuffer-wBrickLayoutBuffer              ; $09e0
	add  hl, bc                                                     ; $09e3
	ld   a, [hl]                                                    ; $09e4
	cp   $00                                                        ; $09e5
	jr   z, .toNextBrick                                            ; $09e7

; +1 to num bricks (non-breakables are blocks)
	inc  de                                                         ; $09e9

.toNextBrick:
; Next src address
	pop  hl                                                         ; $09ea
	inc  hl                                                         ; $09eb

; Dec and check next brick
	pop  bc                                                         ; $09ec
	dec  bc                                                         ; $09ed
	ld   a, b                                                       ; $09ee
	or   c                                                          ; $09ef
	jr   nz, .nextBrick                                             ; $09f0

; Store num bricks
	ld   a, d                                                       ; $09f2
	ldh  [hNumBricksInStage], a                                     ; $09f3
	ld   a, e                                                       ; $09f5
	ldh  [hNumBricksInStage+1], a                                   ; $09f6
	ret                                                             ; $09f8


VBlankEnqueueHitBrickChange:
	call WaitUntilNoCompressedLevelChanges                          ; $09f9

; BC = row offset in game screen with the brick to update
	ldh  a, [hGameplayScreenBrickRowHit]                            ; $09fc
	srl  a                                                          ; $09fe
	ld   b, a                                                       ; $0a00
	ld   e, $20                                                     ; $0a01
	call BCequBtimesE                                               ; $0a03

; HL = col offset added to above
	ldh  a, [hGameplayScreenBrickColHit]                            ; $0a06
	ld   l, a                                                       ; $0a08
	ld   h, $00                                                     ; $0a09
	add  hl, bc                                                     ; $0a0b

; Save address where tile is being replaced
	ld   a, h                                                       ; $0a0c
	ldh  [hTileMapOffsetInGameScreenOfHitBrick], a                  ; $0a0d
	ld   a, l                                                       ; $0a0f
	ldh  [hTileMapOffsetInGameScreenOfHitBrick+1], a                ; $0a10

; BC = relevant row offset in the ram buffers
	ldh  a, [hGameplayScreenBrickRowHit]                            ; $0a12
	srl  a                                                          ; $0a14
	ld   b, a                                                       ; $0a16
	ld   e, NUM_BYTES_IN_LAYOUT_BUFFER_ROW                          ; $0a17
	call BCequBtimesE                                               ; $0a19

; HL = the additional offset for the column hit
	ldh  a, [hGameplayScreenBrickColHit]                            ; $0a1c
	ld   l, a                                                       ; $0a1e
	ld   h, $00                                                     ; $0a1f
	add  hl, bc                                                     ; $0a21

; Default tile to copy is $ff
	ld   a, $ff                                                     ; $0a22
	ldh  [hBrickTileToCopyToCompressedBuffer], a                    ; $0a24

	xor  a                                                          ; $0a26
	push af                                                         ; $0a27

; If byte in ram is non-0,..
	ld   bc, wBrickLayoutBuffer                                     ; $0a28
	add  hl, bc                                                     ; $0a2b
	ld   a, [hl]                                                    ; $0a2c
	cp   $00                                                        ; $0a2d
	jr   z, .afterTopHalfCheck                                      ; $0a2f

; Use that as the tile to copy then set bit 0 of pushed A (top half exists)
	ldh  [hBrickTileToCopyToCompressedBuffer], a                    ; $0a31
	pop  af                                                         ; $0a33
	or   $01                                                        ; $0a34
	push af                                                         ; $0a36

.afterTopHalfCheck:
; Get value in 8x4 block below (+$0e)
	ld   b, HIGH(NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2)                  ; $0a37
	ld   c, LOW(NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2)                   ; $0a39
	add  hl, bc                                                     ; $0a3b

; If byte in ram is non-0,..
	ld   a, [hl]                                                    ; $0a3c
	cp   $00                                                        ; $0a3d
	jr   z, .afterBottomHalfCheck                                   ; $0a3f

; Use that as the tile to copy then set bit 1 of pushed A (bottom half exists)
	ldh  [hBrickTileToCopyToCompressedBuffer], a                    ; $0a41
	pop  af                                                         ; $0a43
	or   $02                                                        ; $0a44
	push af                                                         ; $0a46

.afterBottomHalfCheck:
; Jump if pushed A was not impacted by above checks
	pop  af                                                         ; $0a47
	cp   $00                                                        ; $0a48
	jp   z, .vblankEnqueueTile                                      ; $0a4a

; Push that value-1
	dec  a                                                          ; $0a4d
	push af                                                         ; $0a4e

; The tile found is idxed into the table
	ldh  a, [hBrickTileToCopyToCompressedBuffer]                    ; $0a4f
	dec  a                                                          ; $0a51
	ld   b, a                                                       ; $0a52
	ld   e, $06                                                     ; $0a53
	call BCequBtimesE                                               ; $0a55
	ld   hl, BricksMetadata                                         ; $0a58
	add  hl, bc                                                     ; $0a5b

; Get the value that determines the top/bottom half's existance, as another idx
	pop  af                                                         ; $0a5c
	ld   b, $00                                                     ; $0a5d
	ld   c, a                                                       ; $0a5f
	add  hl, bc                                                     ; $0a60

; Save the tile in the table as the tile to copy
	ld   a, [hl]                                                    ; $0a61
	ldh  [hBrickTileToCopyToCompressedBuffer], a                    ; $0a62

.vblankEnqueueTile:
; HL = regular address to replace tile
	ldh  a, [hTileMapOffsetInGameScreenOfHitBrick]                  ; $0a64
	ld   b, a                                                       ; $0a66
	ldh  a, [hTileMapOffsetInGameScreenOfHitBrick+1]                ; $0a67
	ld   c, a                                                       ; $0a69
	ld   hl, _SCRN0+$21                                             ; $0a6a
	add  hl, bc                                                     ; $0a6d

; Push this regular address
	ld   b, h                                                       ; $0a6e
	ld   c, l                                                       ; $0a6f
	push bc                                                         ; $0a70

; BC = mirrored address to copy to
	ld   b, HIGH(NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2)                  ; $0a71
	ld   c, LOW(NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2)                   ; $0a73
	add  hl, bc                                                     ; $0a75
	ld   b, h                                                       ; $0a76
	ld   c, l                                                       ; $0a77

; Store mirrored layout address to copy to
	ld   hl, wCompressedLevelChanges                                ; $0a78
	ld   a, b                                                       ; $0a7b
	ld   [hl+], a                                                   ; $0a7c
	ld   a, c                                                       ; $0a7d
	ld   [hl+], a                                                   ; $0a7e

; Set that we're simple copying 1 byte, then copy that byte in
	ld   a, $01                                                     ; $0a7f
	ld   [hl+], a                                                   ; $0a81

	ldh  a, [hBrickTileToCopyToCompressedBuffer]                    ; $0a82
	ld   [hl+], a                                                   ; $0a84

; Store regular layout address to copy to
	pop  bc                                                         ; $0a85
	ld   a, b                                                       ; $0a86
	ld   [hl+], a                                                   ; $0a87
	ld   a, c                                                       ; $0a88
	ld   [hl+], a                                                   ; $0a89

; Set that we're simple copying 1 byte, then copy that byte in
	ld   a, $01                                                     ; $0a8a
	ld   [hl+], a                                                   ; $0a8c

	ldh  a, [hBrickTileToCopyToCompressedBuffer]                    ; $0a8d
	ld   [hl+], a                                                   ; $0a8f

; Null terminator
	xor  a                                                          ; $0a90
	ld   [hl+], a                                                   ; $0a91

; Set that we have a pending vram change
	inc  a                                                          ; $0a92
	ldh  [hPendingCompressedLevelChanges], a                        ; $0a93
	ret                                                             ; $0a95


VBlankEnqueueBrickTileLayoutRow:
	call WaitUntilNoCompressedLevelChanges                          ; $0a96

; 2 bricks per tile row
	ldh  a, [hGameplayScreenBrickRowToDrawTo]                       ; $0a99
	srl  a                                                          ; $0a9b
	ld   b, a                                                       ; $0a9d
	ld   e, SCRN_VX_B                                               ; $0a9e
	call BCequBtimesE                                               ; $0aa0

; BC = addr of that row in the gameplay screen
	ld   hl, _SCRN0+$21                                             ; $0aa3
	add  hl, bc                                                     ; $0aa6
	ld   b, h                                                       ; $0aa7
	ld   c, l                                                       ; $0aa8

; Store the addr
	ld   hl, wCompressedLevelChanges                                ; $0aa9
	ld   a, b                                                       ; $0aac
	ld   [hl+], a                                                   ; $0aad
	ld   a, c                                                       ; $0aae
	ld   [hl+], a                                                   ; $0aaf

; Spec byte set to simple copy $1c bytes
	ld   a, NUM_BYTES_IN_LAYOUT_BUFFER_ROW                          ; $0ab0
	ld   [hl], a                                                    ; $0ab2

; Each tile row is stored  layout buffer
	ldh  a, [hGameplayScreenBrickRowToDrawTo]                       ; $0ab3
	srl  a                                                          ; $0ab5
	ld   b, a                                                       ; $0ab7
	ld   e, NUM_BYTES_IN_LAYOUT_BUFFER_ROW                          ; $0ab8
	call BCequBtimesE                                               ; $0aba

; BC = addr of the row in the layout buffer
	ld   hl, wBrickLayoutBuffer                                     ; $0abd
	add  hl, bc                                                     ; $0ac0

; DE = start of bytes to copy, 2 bytes in the buffer make a tile
	ld   de, wCompressedLevelChanges+3                              ; $0ac1
	ld   a, NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2                        ; $0ac4

.loopCol:
	push af                                                         ; $0ac6
	push hl                                                         ; $0ac7
	push de                                                         ; $0ac8

; Default tile to copy is $ff
	ld   a, $ff                                                     ; $0ac9
	ldh  [hBrickTileToCopyToCompressedBuffer], a                    ; $0acb

	xor  a                                                          ; $0acd
	push af                                                         ; $0ace

; If byte in ram is non-0,..
	ld   a, [hl]                                                    ; $0acf
	cp   $00                                                        ; $0ad0
	jr   z, .afterTopHalfCheck                                      ; $0ad2

; Use that as the tile to copy then set bit 0 of pushed A (top half exists)
	ldh  [hBrickTileToCopyToCompressedBuffer], a                    ; $0ad4
	pop  af                                                         ; $0ad6
	or   $01                                                        ; $0ad7
	push af                                                         ; $0ad9

.afterTopHalfCheck:
; Get value in 8x4 block below (+$0e)
	ld   b, HIGH(NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2)                  ; $0ada
	ld   c, LOW(NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2)                   ; $0adc
	add  hl, bc                                                     ; $0ade

; If byte in ram is non-0,..
	ld   a, [hl]                                                    ; $0adf
	cp   $00                                                        ; $0ae0
	jr   z, .afterBottomHalfCheck                                   ; $0ae2

; Use that as the tile to copy then set bit 1 of pushed A (bottom half exists)
	ldh  [hBrickTileToCopyToCompressedBuffer], a                    ; $0ae4
	pop  af                                                         ; $0ae6
	or   $02                                                        ; $0ae7
	push af                                                         ; $0ae9

.afterBottomHalfCheck:
; Jump if pushed A was not impacted by above checks
	pop  af                                                         ; $0aea
	cp   $00                                                        ; $0aeb
	jp   z, .vblankEnqueueTile                                      ; $0aed

; Push that value-1
	dec  a                                                          ; $0af0
	push af                                                         ; $0af1

; The tile found is idxed into the table
	ldh  a, [hBrickTileToCopyToCompressedBuffer]                    ; $0af2
	dec  a                                                          ; $0af4
	ld   b, a                                                       ; $0af5
	ld   e, $06                                                     ; $0af6
	call BCequBtimesE                                               ; $0af8
	ld   hl, BricksMetadata                                         ; $0afb
	add  hl, bc                                                     ; $0afe

; Get the value that determines the top/bottom half's existance, as another idx
	pop  af                                                         ; $0aff
	ld   b, $00                                                     ; $0b00
	ld   c, a                                                       ; $0b02
	add  hl, bc                                                     ; $0b03

; Save the tile in the table as the tile to copy
	ld   a, [hl]                                                    ; $0b04
	ldh  [hBrickTileToCopyToCompressedBuffer], a                    ; $0b05

.vblankEnqueueTile:
; Pop compressed buffer dest, and set tile in there
	pop  de                                                         ; $0b07
	ldh  a, [hBrickTileToCopyToCompressedBuffer]                    ; $0b08
	ld   [de], a                                                    ; $0b0a

; Set tile in the compressed buffer $0e tiles after (layout is mirrored)
	ld   b, d                                                       ; $0b0b
	ld   c, e                                                       ; $0b0c
	ld   hl, NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2                       ; $0b0d
	add  hl, bc                                                     ; $0b10
	ld   [hl+], a                                                   ; $0b11

; BC points to that latter of the compressed buffer
	ld   b, h                                                       ; $0b12
	ld   c, l                                                       ; $0b13

; Go to next dest and src
	inc  de                                                         ; $0b14
	pop  hl                                                         ; $0b15
	inc  hl                                                         ; $0b16

; To next loop
	pop  af                                                         ; $0b17
	dec  a                                                          ; $0b18
	jr   nz, .loopCol                                               ; $0b19

; Null terminator
	xor  a                                                          ; $0b1b
	ld   [bc], a                                                    ; $0b1c

; Set that we have pending changes
	inc  a                                                          ; $0b1d
	ldh  [hPendingCompressedLevelChanges], a                        ; $0b1e
	ret                                                             ; $0b20


UpdateScrollingStageVars:
; Return if not scrolling stage
	ldh  a, [hIsXScrollingStage]                                    ; $0b21
	cp   $00                                                        ; $0b23
	ret  z                                                          ; $0b25

; Regs point to 3 scroll tables
	ld   hl, wHorizScrollingLayoutSCXVals                           ; $0b26
	ld   de, wHorizScrollDirection                                  ; $0b29
	ld   bc, wHorizScrollCounter                                    ; $0b2c

; Default counter = 0
	ld   a, $00                                                     ; $0b2f

.loop:
; Jump if dec'd counter != 0
	push af                                                         ; $0b31
	ld   a, [bc]                                                    ; $0b32
	dec  a                                                          ; $0b33
	jr   nz, .setCounter                                            ; $0b34

; Jump if the row has no scroll set for it
	ld   a, [de]                                                    ; $0b36
	cp   $00                                                        ; $0b37
	jr   z, .setCounter                                             ; $0b39

; Jump based on direction (positive = right)
	and  $80                                                        ; $0b3b
	push af                                                         ; $0b3d
	call z, IncScrollRowsX                                          ; $0b3e
	pop  af                                                         ; $0b41
	call nz, DecScrollRowsX                                         ; $0b42

; Direction has base counter in low 7 bits
	ld   a, [de]                                                    ; $0b45
	and  $7f                                                        ; $0b46

.setCounter:
	ld   [bc], a                                                    ; $0b48

; Inc all pointers to scroll tables
	inc  hl                                                         ; $0b49
	inc  de                                                         ; $0b4a
	inc  bc                                                         ; $0b4b

; Stop when all rows done
	pop  af                                                         ; $0b4c
	inc  a                                                          ; $0b4d
	cp   NUM_SCROLL_ROWS                                            ; $0b4e
	jr   c, .loop                                                   ; $0b50

	ret                                                             ; $0b52


; HL - points to curr row's curr X
IncScrollRowsX:
; Inc and loop $70->0
	ld   a, [hl]                                                    ; $0b53
	inc  a                                                          ; $0b54
	cp   $70                                                        ; $0b55
	jr   c, :+                                                      ; $0b57
	ld   a, $00                                                     ; $0b59
:	ld   [hl], a                                                    ; $0b5b
	ret                                                             ; $0b5c


; HL - points to curr row's curr X
DecScrollRowsX:
; Dec and loop 0->$6f
	ld   a, [hl]                                                    ; $0b5d
	dec  a                                                          ; $0b5e
	cp   $ff                                                        ; $0b5f
	jr   nz, :+                                                     ; $0b61
	ld   a, $6f                                                     ; $0b63
:	ld   [hl], a                                                    ; $0b65
	ret                                                             ; $0b66


ProcessInGameScroll:
; Get current brick row idx, inc and store it,
; Jumping if we've reached the end of scrolling rows
	ldh  a, [hBrickRowIdxToSetLYCfor]                               ; $0b67
	ld   c, a                                                       ; $0b69
	inc  a                                                          ; $0b6a
	cp   NUM_SCROLL_ROWS+1                                          ; $0b6b
	jr   nc, .endOfScrollingVals                                    ; $0b6d

	ldh  [hBrickRowIdxToSetLYCfor], a                               ; $0b6f

; That idx * 4 + 7 is the inc'd brick idx's LY-1
	sla  a                                                          ; $0b71
	sla  a                                                          ; $0b73
	ld   b, $07                                                     ; $0b75
	add  b                                                          ; $0b77
	ldh  [rLYC], a                                                  ; $0b78
	ld   b, $00                                                     ; $0b7a

; Get current scroll X to set
	ld   hl, wHorizScrollingLayoutSCXVals                           ; $0b7c
	add  hl, bc                                                     ; $0b7f
	ld   a, [hl]                                                    ; $0b80
	ldh  [rSCX], a                                                  ; $0b81

; If at the 1st brick row idx, set the SCY too
	xor  a                                                          ; $0b83
	cp   c                                                          ; $0b84
	ret  nz                                                         ; $0b85

	ld   a, [wFallingLayoutSCY]                                     ; $0b86
	ldh  [rSCY], a                                                  ; $0b89
	ret                                                             ; $0b8b

.endOfScrollingVals:
; Reset brick row idx to set LY for, and set LYC based on it
	xor  a                                                          ; $0b8c
	ldh  [hBrickRowIdxToSetLYCfor], a                               ; $0b8d

	ld   b, $07                                                     ; $0b8f
	add  b                                                          ; $0b91
	ldh  [rLYC], a                                                  ; $0b92

; Set last scy and clear scx
	ld   a, [wLastInGameSCY]                                        ; $0b94
	ldh  [rSCY], a                                                  ; $0b97
	xor  a                                                          ; $0b99
	ldh  [rSCX], a                                                  ; $0b9a
	ret                                                             ; $0b9c


ClearsRegAndRowScrolls:
; Clear scx
	ld   a, $00                                                     ; $0b9d
	ldh  [hSCX], a                                                  ; $0b9f

; Clear starting scx vals for each row
	ld   hl, wHorizScrollingLayoutSCXVals                           ; $0ba1
	ld   b, NUM_SCROLL_ROWS                                         ; $0ba4

.loop:
	ld   [hl+], a                                                   ; $0ba6
	dec  b                                                          ; $0ba7
	jr   nz, .loop                                                  ; $0ba8

; Also clear scy
	xor  a                                                          ; $0baa
	ldh  [hSCY], a                                                  ; $0bab

SetFallingLayoutSCYandLastXScrollSCY:
; Set SCY to skip brick rows above our layout
	ldh  a, [hNumBrickRowsOnTopOfCurrLayout]                        ; $0bad
	sla  a                                                          ; $0baf
	sla  a                                                          ; $0bb1
	add  $00                                                        ; $0bb3
	ld   [wFallingLayoutSCY], a                                     ; $0bb5

; Set last SCY past x scrolling rows to $70 if $14 or less rows left to load, else $b0
	ld   b, $70                                                     ; $0bb8
	ldh  a, [hNumBrickRowsOnTopOfCurrLayout]                        ; $0bba
	cp   $15                                                        ; $0bbc
	jr   c, :+                                                      ; $0bbe
	ld   b, $b0                                                     ; $0bc0
:	ld   a, b                                                       ; $0bc2
	ld   [wLastInGameSCY], a                                        ; $0bc3
	ret                                                             ; $0bc6


MoveLayoutDown:
; Return if we've hit the max scroll
	ldh  a, [hNumBrickRowsOnTopOfCurrLayout]                        ; $0bc7
	cp   $00                                                        ; $0bc9
	ret  z                                                          ; $0bcb

; Else move the layout down, and play song
	dec  a                                                          ; $0bcc
	ldh  [hNumBrickRowsOnTopOfCurrLayout], a                        ; $0bcd
	call StartSongB                                                 ; $0bcf

; Set scy params, and clear any bricks that have made its way to the bottom
	call SetFallingLayoutSCYandLastXScrollSCY                       ; $0bd2
	call ClearAllBricksInRowBottomOfScreen                          ; $0bd5

; Return if we've scrolled down all the way
	ldh  a, [hNumBrickRowsOnTopOfCurrLayout]                        ; $0bd8
	cp   $00                                                        ; $0bda
	ret  z                                                          ; $0bdc

; Or 1 row left to scroll down
	dec  a                                                          ; $0bdd
	ret  z                                                          ; $0bde

; Or 3, 5, etc left to scroll down
	ld   b, a                                                       ; $0bdf
	and  $01                                                        ; $0be0
	ret  z                                                          ; $0be2

; Draw brick row using an even number
	ld   a, b                                                       ; $0be3
	ldh  [hGameplayScreenBrickRowToDrawTo], a                       ; $0be4
	call VBlankEnqueueBrickTileLayoutRow                            ; $0be6

; Draw brick row 11 tiles down
	ldh  a, [hGameplayScreenBrickRowToDrawTo]                       ; $0be9
	add  $16                                                        ; $0beb
	ldh  [hGameplayScreenBrickRowToDrawTo], a                       ; $0bed
	jp   VBlankEnqueueBrickTileLayoutRow                            ; $0bef


ClearAllBricksInRowBottomOfScreen:
; B = $14 brick rows from what we're seeing
	ldh  a, [hNumBrickRowsOnTopOfCurrLayout]                        ; $0bf2
	add  $14                                                        ; $0bf4
	ld   b, a                                                       ; $0bf6

; Loop through every col in row
	ld   e, NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2                        ; $0bf7
	call BCequBtimesE                                               ; $0bf9

	ld   hl, wBrickLayoutBuffer                                     ; $0bfc
	add  hl, bc                                                     ; $0bff
	ld   a, NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2                        ; $0c00

.loopCol:
	push af                                                         ; $0c02
	push hl                                                         ; $0c03

; Skip if no brick at col
	ld   a, [hl]                                                    ; $0c04
	cp   $00                                                        ; $0c05
	jr   z, .toLoopCol                                              ; $0c07

; DE points to layout buffer, HL points to breakable buffer
	ld   d, h                                                       ; $0c09
	ld   e, l                                                       ; $0c0a
	ld   bc, wBreakableBricksBuffer-wBrickLayoutBuffer              ; $0c0b
	add  hl, bc                                                     ; $0c0e

; Remove brick, go to next col if it was unbreakable
	ld   a, [hl]                                                    ; $0c0f
	cp   $00                                                        ; $0c10
	ld   a, $00                                                     ; $0c12
	ld   [de], a                                                    ; $0c14
	jr   z, .toLoopCol                                              ; $0c15

; Dec num bricks in stage
	ldh  a, [hNumBricksInStage]                                     ; $0c17
	ld   b, a                                                       ; $0c19
	ldh  a, [hNumBricksInStage+1]                                   ; $0c1a
	ld   c, a                                                       ; $0c1c

	dec  bc                                                         ; $0c1d

	ld   a, b                                                       ; $0c1e
	ldh  [hNumBricksInStage], a                                     ; $0c1f
	ld   a, c                                                       ; $0c21
	ldh  [hNumBricksInStage+1], a                                   ; $0c22

; Set game state to stage complete if num bricks == 0
	or   b                                                          ; $0c24
	jr   nz, .toLoopCol                                             ; $0c25

	ld   a, GS_STAGE_COMPLETE                                       ; $0c27
	ldh  [hGameState], a                                            ; $0c29

.toLoopCol:
; HL to point to next buffer brick in row
	pop  hl                                                         ; $0c2b
	inc  hl                                                         ; $0c2c
	
	pop  af                                                         ; $0c2d
	dec  a                                                          ; $0c2e
	jr   nz, .loopCol                                               ; $0c2f

	ret                                                             ; $0c31


; A - brick type 1-indexed
AddToScoreBasedOnBrickHit:
; HL = relevant row for brick
	dec  a                                                          ; $0c32
	ld   b, a                                                       ; $0c33
	ld   e, $06                                                     ; $0c34
	call BCequBtimesE                                               ; $0c36
	ld   hl, BricksMetadata                                         ; $0c39
	add  hl, bc                                                     ; $0c3c

; HL points to 3rd byte, which has score in upper nybble
	ld   b, $00                                                     ; $0c3d
	ld   c, $03                                                     ; $0c3f
	add  hl, bc                                                     ; $0c41

; B = that score val
	ld   a, [hl]                                                    ; $0c42
	swap a                                                          ; $0c43
	and  $0f                                                        ; $0c45
	ld   b, a                                                       ; $0c47

; Add score
	ldh  a, [hCurrScore]                                            ; $0c48
	add  b                                                          ; $0c4a
	ldh  [hCurrScore], a                                            ; $0c4b
	ldh  a, [hCurrScore+1]                                          ; $0c4d
	adc  $00                                                        ; $0c4f
	ldh  [hCurrScore+1], a                                          ; $0c51
	ret  nc                                                         ; $0c53

; If a carry happened, set max score to $ffff
	xor  a                                                          ; $0c54
	dec  a                                                          ; $0c55
	ldh  [hCurrScore+1], a                                          ; $0c56
	ldh  [hCurrScore], a                                            ; $0c58
	ret                                                             ; $0c5a


UpdateTopScoreIfBeaten:
	ld   bc, hTopScore                                              ; $0c5b
	ld   hl, hCurrScore                                             ; $0c5e

; Push low byte result of top score - curr score
	ldh  a, [c]                                                     ; $0c61
	sub  [hl]                                                       ; $0c62
	push af                                                         ; $0c63

; Go to high byte
	inc  c                                                          ; $0c64
	inc  hl                                                         ; $0c65
	pop  af                                                         ; $0c66

; Continue subtraction, returning if top score > curr score
	ldh  a, [c]                                                     ; $0c67
	sbc  [hl]                                                       ; $0c68
	ret  nc                                                         ; $0c69

; New score, store high byte then low byte of curr score into top score
	ld   a, [hl]                                                    ; $0c6a
	ldh  [c], a                                                     ; $0c6b
	dec  c                                                          ; $0c6c
	dec  hl                                                         ; $0c6d
	ld   a, [hl]                                                    ; $0c6e
	ldh  [c], a                                                     ; $0c6f
	ret                                                             ; $0c70


CheckIfPastScoreThresholdForMoreLives:
; Get score threshold - curr score, returning if it's greater
	ld   hl, hCurrScore                                             ; $0c71
	ldh  a, [hNextScoreThresholdForMoreLives]                       ; $0c74
	sub  [hl]                                                       ; $0c76
	push af                                                         ; $0c77
	inc  hl                                                         ; $0c78
	
	pop  af                                                         ; $0c79
	ldh  a, [hNextScoreThresholdForMoreLives+1]                     ; $0c7a
	sbc  [hl]                                                       ; $0c7c
	ret  nc                                                         ; $0c7d

; If not at max lives..
	ld   a, [wLivesLeft]                                            ; $0c7e
	cp   $09                                                        ; $0c81
	jr   nc, :+                                                     ; $0c83

; Add 1 to lives and play a sound effect
	inc  a                                                          ; $0c85
	ld   [wLivesLeft], a                                            ; $0c86
	call StartSquareEffect1                                         ; $0c89

:	call DisplayLivesLeft                                           ; $0c8c

SetScoreThresholdForMoreLives:
; HL uses a double idx into the score thresholds table
	ldh  a, [hCurrMoreLivesScoreThresholdIdx]                       ; $0c8f
	sla  a                                                          ; $0c91
	ld   c, a                                                       ; $0c93
	ld   b, $00                                                     ; $0c94
	ld   hl, ScoreThresholdsForMoreLives                            ; $0c96
	add  hl, bc                                                     ; $0c99

; Store big-endian value
	ld   a, [hl+]                                                   ; $0c9a
	ldh  [hNextScoreThresholdForMoreLives+1], a                     ; $0c9b
	ld   a, [hl]                                                    ; $0c9d
	ldh  [hNextScoreThresholdForMoreLives], a                       ; $0c9e

; Inc idx for the next time this function is called
	ldh  a, [hCurrMoreLivesScoreThresholdIdx]                       ; $0ca0
	inc  a                                                          ; $0ca2
	ldh  [hCurrMoreLivesScoreThresholdIdx], a                       ; $0ca3
	ret                                                             ; $0ca5


ProcessBallMovementCollisionAndOam:
	call UpdateBallPosition                                         ; $0ca6
	call CheckBallCollisions                                        ; $0ca9
	call UpdateBallOam                                              ; $0cac
	ret                                                             ; $0caf


CheckBallCollisions:
	nop                                                             ; $0cb0

; Jump if speed is negative (moving up)
	ldh  a, [hBallSpeedY]                                           ; $0cb1
	and  $80                                                        ; $0cb3
	jr   nz, .afterPaddleHitCheck                                   ; $0cb5

; Jump if ball Y < $8d (not near paddle)
	ldh  a, [hBallY]                                                ; $0cb7
	sub  $8d                                                        ; $0cb9
	jr   c, .afterPaddleHitCheck                                    ; $0cbb

; Or if >= $95 (past paddle)
	cp   $08                                                        ; $0cbd
	jr   nc, .afterPaddleHitCheck                                   ; $0cbf

; C = Y position it may be hitting paddle
	ld   c, a                                                       ; $0cc1

; D = paddle length+5
	ldh  a, [hPaddlePixelLength]                                    ; $0cc2
	add  $05                                                        ; $0cc4
	ld   d, a                                                       ; $0cc6

; B = paddle X - 3
	ldh  a, [hPaddleX]                                              ; $0cc7
	sub  $03                                                        ; $0cc9
	ld   b, a                                                       ; $0ccb

; Get ball X - (paddle X - 3), jumping if >= paddle length+5
	ldh  a, [hBallX]                                                ; $0ccc
	sub  b                                                          ; $0cce
	cp   d                                                          ; $0ccf
	jr   nc, .afterPaddleHitCheck                                   ; $0cd0

; Hit paddle, B = diff / 2
	srl  a                                                          ; $0cd2
	ld   b, a                                                       ; $0cd4

; Check Y position paddle was hit, and call appropriate func based on which half hit
; With A correlating to ball's position after left of paddle's left side
	ld   a, c                                                       ; $0cd5
	cp   $07                                                        ; $0cd6
	ld   a, b                                                       ; $0cd8
	push af                                                         ; $0cd9
	call c, BallHitTopOfPaddle                                      ; $0cda
	pop  af                                                         ; $0cdd
	call nc, BallBouncingHorizontally                               ; $0cde

.afterPaddleHitCheck:
; Jump if ball Y has hit the top pipe row
	ldh  a, [hBallY]                                                ; $0ce1
	cp   $18                                                        ; $0ce3
	jp   c, .ballHitTopRow                                          ; $0ce5

; Jump if ball is still in the game field
	cp   $a0                                                        ; $0ce8
	jp   c, .processBallInGameField                                 ; $0cea

; Hit bottom of screen
	ld   a, GS_BALL_EXPLODING                                       ; $0ced
	ldh  [hGameState], a                                            ; $0cef
	ret                                                             ; $0cf1

.ballHitTopRow:
; Play sound and skip if bonus level
	call StartSquareEffectC                                         ; $0cf2
	ldh  a, [hIsBonusLevel]                                         ; $0cf5
	cp   $00                                                        ; $0cf7
	jr   nz, .afterShortenedCheck                                   ; $0cf9

; Jump if paddle is already shorteneed
	ldh  a, [hPaddleShortened]                                      ; $0cfb
	cp   $00                                                        ; $0cfd
	jr   nz, .afterShortenedCheck                                   ; $0cff

; Set paddle shortened, and its pixel length
	ld   a, $01                                                     ; $0d01
	ldh  [hPaddleShortened], a                                      ; $0d03
	ld   a, $10                                                     ; $0d05
	ldh  [hPaddlePixelLength], a                                    ; $0d07

; Adjust paddle X so it looks like it hasn't moved, then play square effect
	ldh  a, [hPaddleX]                                              ; $0d09
	add  $04                                                        ; $0d0b
	ldh  [hPaddleX], a                                              ; $0d0d

	call StartSquareEffectB                                         ; $0d0f

.afterShortenedCheck:
	call BallBouncingVertically                                     ; $0d12

.processBallInGameField:
; Jump if ball X has hit the left pipe..
	ldh  a, [hBallX]                                                ; $0d15
	cp   $10                                                        ; $0d17
	jp   c, .ballXhitPipe                                           ; $0d19

; Skip if it hasn't hit the right pipe
	cp   $7c                                                        ; $0d1c
	jp   c, .afterBallHitPipeCheck                                  ; $0d1e

.ballXhitPipe:
; Process collision and play sound
	call BallBouncingHorizontally                                   ; $0d21
	call StartSquareEffectC                                         ; $0d24

.afterBallHitPipeCheck:
; Return if ball Y >= $88 (not in game field)
	ldh  a, [hBallY]                                                ; $0d27
	sub  $88                                                        ; $0d29
	ret  nc                                                         ; $0d2b

; Clear this flag, and call func which will adjust ball if a brick collision happened
	xor  a                                                          ; $0d2c
	ldh  [hBallHitATile], a                                         ; $0d2d
	call BouncOrMoveBallFurtherBasedOnCornerHit                     ; $0d2f

; Run the func again if the ball did hit a tile
	ldh  a, [hBallHitATile]                                         ; $0d32
	cp   $00                                                        ; $0d34
	ret  z                                                          ; $0d36

BouncOrMoveBallFurtherBasedOnCornerHit:
; Move ball further if it hit the boundary between tiles
	ldh  a, [hBallSpeedX]                                           ; $0d37
	and  $80                                                        ; $0d39
	push af                                                         ; $0d3b
	call z, CheckBallXSideHit_MoveFurtherIfHitTopLeft               ; $0d3c
	pop  af                                                         ; $0d3f
	call nz, CheckBallXSideHit_MoveFurtherIfHitTopRight             ; $0d40

; Bounce ball vertically if it tries to get stuck, eg in a corner
	ldh  a, [hBallSpeedY]                                           ; $0d43
	and  $80                                                        ; $0d45
	push af                                                         ; $0d47
	call z, BounceBallVerticallyIfBottomLeftCornerHit               ; $0d48
	pop  af                                                         ; $0d4b
	call nz, BounceBallVerticallyIfTopLeftCornerHit                 ; $0d4c
	ret                                                             ; $0d4f


BounceBallVerticallyIfBottomLeftCornerHit:
; Check collision with ball's bottom left corner - bounce if detected
	ldh  a, [hBallY]                                                ; $0d50
	add  $03                                                        ; $0d52
	ldh  [hYCollisionValToCheck], a                                 ; $0d54

	ldh  a, [hPrevBallX]                                            ; $0d56
	ldh  [hXCollisionValToCheck], a                                 ; $0d58

	call CheckBallCollisionWithBricks                               ; $0d5a
	cp   $00                                                        ; $0d5d
	jp   nz, BallBouncingVertically                                 ; $0d5f

; Check collision with ball's top left corner - do nothing
	ldh  a, [hBallY]                                                ; $0d62
	ldh  [hYCollisionValToCheck], a                                 ; $0d64

	ldh  a, [hPrevBallX]                                            ; $0d66
	ldh  [hXCollisionValToCheck], a                                 ; $0d68

	call CheckBallCollisionWithBricks                               ; $0d6a
	cp   $00                                                        ; $0d6d
	ret  z                                                          ; $0d6f

	jp   Stub_0ecd                                                  ; $0d70


BounceBallVerticallyIfTopLeftCornerHit:
; Check collision with ball's top left corner - bounce if detected
	ldh  a, [hBallY]                                                ; $0d73
	ldh  [hYCollisionValToCheck], a                                 ; $0d75

	ldh  a, [hPrevBallX]                                            ; $0d77
	ldh  [hXCollisionValToCheck], a                                 ; $0d79

	call CheckBallCollisionWithBricks                               ; $0d7b
	cp   $00                                                        ; $0d7e
	jp   nz, BallBouncingVertically                                 ; $0d80

; Check collision with ball's bottom left corner - do nothing
	ldh  a, [hBallY]                                                ; $0d83
	add  $03                                                        ; $0d85
	ldh  [hYCollisionValToCheck], a                                 ; $0d87

	ldh  a, [hPrevBallX]                                            ; $0d89
	ldh  [hXCollisionValToCheck], a                                 ; $0d8b

	call CheckBallCollisionWithBricks                               ; $0d8d
	cp   $00                                                        ; $0d90
	ret  z                                                          ; $0d92

	jp   Stub_0ecd                                                  ; $0d93


CheckBallXSideHit_MoveFurtherIfHitTopLeft:
; Check collision with ball's top right corner - bounce if detected
	ldh  a, [hPrevBallY]                                            ; $0d96
	ldh  [hYCollisionValToCheck], a                                 ; $0d98

	ldh  a, [hBallX]                                                ; $0d9a
	add  $03                                                        ; $0d9c
	ldh  [hXCollisionValToCheck], a                                 ; $0d9e

	call CheckBallCollisionWithBricks                               ; $0da0
	cp   $00                                                        ; $0da3
	jp   nz, BallBouncingHorizontally                               ; $0da5

; Check collision with ball's top left corner - move in the same direction
	ldh  a, [hPrevBallY]                                            ; $0da8
	ldh  [hYCollisionValToCheck], a                                 ; $0daa

	ldh  a, [hBallX]                                                ; $0dac
	ldh  [hXCollisionValToCheck], a                                 ; $0dae
	call CheckBallCollisionWithBricks                               ; $0db0
	cp   $00                                                        ; $0db3
	ret  z                                                          ; $0db5

	jp   MoveBallFurtherHoriz                                       ; $0db6


CheckBallXSideHit_MoveFurtherIfHitTopRight:
; Check collision with ball's top left corner - bounce if detected
	ldh  a, [hPrevBallY]                                            ; $0db9
	ldh  [hYCollisionValToCheck], a                                 ; $0dbb

	ldh  a, [hBallX]                                                ; $0dbd
	ldh  [hXCollisionValToCheck], a                                 ; $0dbf
	call CheckBallCollisionWithBricks                               ; $0dc1
	cp   $00                                                        ; $0dc4
	jp   nz, BallBouncingHorizontally                               ; $0dc6

; Check collision with ball's top right corner - move in the same direction
	ldh  a, [hPrevBallY]                                            ; $0dc9
	ldh  [hYCollisionValToCheck], a                                 ; $0dcb

	ldh  a, [hBallX]                                                ; $0dcd
	add  $03                                                        ; $0dcf
	ldh  [hXCollisionValToCheck], a                                 ; $0dd1
	call CheckBallCollisionWithBricks                               ; $0dd3
	cp   $00                                                        ; $0dd6
	ret  z                                                          ; $0dd8

	jp   MoveBallFurtherHoriz                                       ; $0dd9


; Returns if collision happened in A
CheckBallCollisionWithBricks:
; B = falling scy
	ld   a, [wFallingLayoutSCY]                                     ; $0ddc
	sub  $00                                                        ; $0ddf
	ld   b, a                                                       ; $0de1

; Pixel row for collisions starts from 8 pixels from top (after pipe)
	ldh  a, [hYCollisionValToCheck]                                 ; $0de2
	sub  $18                                                        ; $0de4

; No collision if we haven't hit layout
	add  b                                                          ; $0de6
	jr   c, .noCollision                                            ; $0de7

; 4 pixels per brick row
	srl  a                                                          ; $0de9
	srl  a                                                          ; $0deb
	ldh  [hGameplayScreenBrickRowHit], a                            ; $0ded

; No collision if we haven't hit layout
	cp   $3c                                                        ; $0def
	jr   c, .afterOutOfBoundsCheck                                  ; $0df1

.noCollision:
	ld   a, $00                                                     ; $0df3
	ret                                                             ; $0df5

.afterOutOfBoundsCheck:
; B = brick row hit, C = num brick rows hidden
	ld   b, a                                                       ; $0df6
	ldh  a, [hNumBrickRowsOnTopOfCurrLayout]                        ; $0df7
	ld   c, a                                                       ; $0df9

; BC = B - C, ie shown row
	ld   a, b                                                       ; $0dfa
	sub  c                                                          ; $0dfb
	ld   c, a                                                       ; $0dfc
	ld   b, $00                                                     ; $0dfd
	ld   hl, wHorizScrollingLayoutSCXVals                           ; $0dff
	add  hl, bc                                                     ; $0e02

; Get SCX val of collision area into B
	ld   a, [hl]                                                    ; $0e03
	sub  $00                                                        ; $0e04
	ld   b, a                                                       ; $0e06

; X collision starts from +8 (past pixel pipe)
	ldh  a, [hXCollisionValToCheck]                                 ; $0e07
	sub  $10                                                        ; $0e09

; Add SCX, keeping within 1st $70 game screen
	add  b                                                          ; $0e0b
	cp   $70                                                        ; $0e0c
	jr   c, :+                                                      ; $0e0e
	sub  $70                                                        ; $0e10

; 8 pixel cols per brick
:	srl  a                                                          ; $0e12
	srl  a                                                          ; $0e14
	srl  a                                                          ; $0e16
	ldh  [hGameplayScreenBrickColHit], a                            ; $0e18

; BC = tile row offset in layout buffer
	ldh  a, [hGameplayScreenBrickRowHit]                            ; $0e1a
	ld   b, a                                                       ; $0e1c
	ld   e, NUM_BYTES_IN_LAYOUT_BUFFER_ROW/2                        ; $0e1d
	call BCequBtimesE                                               ; $0e1f

; Add on col offset
	ldh  a, [hGameplayScreenBrickColHit]                            ; $0e22
	ld   l, a                                                       ; $0e24
	ld   h, $00                                                     ; $0e25
	add  hl, bc                                                     ; $0e27

	ld   bc, wBrickLayoutBuffer                                     ; $0e28
	add  hl, bc                                                     ; $0e2b

; Return if there is no brick there
	ld   a, [hl]                                                    ; $0e2c
	cp   $00                                                        ; $0e2d
	ret  z                                                          ; $0e2f

; Else set the brick that we hit
	ldh  [hTileHitByBall], a                                        ; $0e30

; On brick hit, change speeds if needed
	push hl                                                         ; $0e32
	call ProcessSpeedChangeFromHittingBrick                         ; $0e33
	pop  hl                                                         ; $0e36

; DE points to layout buffer, HL points to breakable buffer
	ld   d, h                                                       ; $0e37
	ld   e, l                                                       ; $0e38

	ld   bc, wBreakableBricksBuffer-wBrickLayoutBuffer              ; $0e39
	add  hl, bc                                                     ; $0e3c

; Jump if we hit a solid block
	ld   a, [hl]                                                    ; $0e3d
	cp   $00                                                        ; $0e3e
	jr   z, .notBreakable                                           ; $0e40

	ld   b, a                                                       ; $0e42

; If not bonus level..
	ldh  a, [hIsBonusLevel]                                         ; $0e43
	cp   $00                                                        ; $0e45
	jr   nz, .clearBrickInLayourBuffer                              ; $0e47

; Store 0 in the breakable buffer
	dec  b                                                          ; $0e49
	ld   [hl], b                                                    ; $0e4a
	ret  nz                                                         ; $0e4b

.clearBrickInLayourBuffer:
	xor  a                                                          ; $0e4c
	ld   [de], a                                                    ; $0e4d

; Add to score, and call updates based on score
	ldh  a, [hTileHitByBall]                                        ; $0e4e
	call AddToScoreBasedOnBrickHit                                  ; $0e50
	call UpdateTopScoreIfBeaten                                     ; $0e53
	call CheckIfPastScoreThresholdForMoreLives                      ; $0e56
	call AddInGameTopAndCurrScoreOam                                ; $0e59

; Play relevant sound and display changed brick in vblank
	call PlaySquareEffectBasedOnPieceHit                            ; $0e5c
	call VBlankEnqueueHitBrickChange                                ; $0e5f

; Dec num bricks in stage
	ldh  a, [hNumBricksInStage]                                     ; $0e62
	ld   b, a                                                       ; $0e64
	ldh  a, [hNumBricksInStage+1]                                   ; $0e65
	ld   c, a                                                       ; $0e67

	dec  bc                                                         ; $0e68

	ld   a, b                                                       ; $0e69
	ldh  [hNumBricksInStage], a                                     ; $0e6a
	ld   a, c                                                       ; $0e6c
	ldh  [hNumBricksInStage+1], a                                   ; $0e6d

; Jump if there are still bricks
	or   b                                                          ; $0e6f
	jr   nz, .afterBrickNumCheck                                    ; $0e70

; Else set that stage is complete
	ld   a, GS_STAGE_COMPLETE                                       ; $0e72
	ldh  [hGameState], a                                            ; $0e74

.afterBrickNumCheck:
; Return with flag cleared if bonus level
	ldh  a, [hIsBonusLevel]                                         ; $0e76
	cp   $00                                                        ; $0e78
	jp   nz, .noCollision                                           ; $0e7a

; Set that a tile was hit, and return A = 1 (collision occurred)
:	ldh  a, [hBallHitATile]                                         ; $0e7d
	inc  a                                                          ; $0e7f
	ldh  [hBallHitATile], a                                         ; $0e80

	ld   a, $01                                                     ; $0e82
	ret                                                             ; $0e84

.notBreakable:
; Update Y/X ball speeds every 10 solid blocks hit, and play square effect
	call ChangeYXballSpeedsEvery10calls                             ; $0e85
	call PlaySquareEffectBasedOnPieceHit                            ; $0e88
	jr   :-                                                         ; $0e8b


BallBouncingVertically:
; Call appropriate func based on if ball is moving down, or up
	ldh  a, [hBallSpeedY]                                           ; $0e8d
	and  $80                                                        ; $0e8f
	push af                                                         ; $0e91
	call z, MoveBallUpDueToCollision                                ; $0e92
	pop  af                                                         ; $0e95
	call nz, MoveBallDownDueToCollision                             ; $0e96

; Reverse Y speed
	ldh  a, [hBallSpeedY]                                           ; $0e99
	ld   b, a                                                       ; $0e9b
	ldh  a, [hBallSpeedSubY]                                        ; $0e9c
	ld   c, a                                                       ; $0e9e

	call NegBC                                                      ; $0e9f

	ld   a, b                                                       ; $0ea2
	ldh  [hBallSpeedY], a                                           ; $0ea3
	ld   a, c                                                       ; $0ea5
	ldh  [hBallSpeedSubY], a                                        ; $0ea6

; Set that we changed ball Y
	ldh  a, [hBallY]                                                ; $0ea8
	ldh  [hPrevBallY], a                                            ; $0eaa
	ret                                                             ; $0eac


BallBouncingHorizontally:
; Call handler based on direction ball is moving
	ldh  a, [hBallSpeedX]                                           ; $0ead
	and  $80                                                        ; $0eaf
	push af                                                         ; $0eb1
	call z, MoveBallLeftDueToCollision                              ; $0eb2
	pop  af                                                         ; $0eb5
	call nz, MoveBallRightDueToCollision                            ; $0eb6

; Get current x speed, reverse it and save it
	ldh  a, [hBallSpeedX]                                           ; $0eb9
	ld   b, a                                                       ; $0ebb
	ldh  a, [hBallSpeedSubX]                                        ; $0ebc
	ld   c, a                                                       ; $0ebe

	call NegBC                                                      ; $0ebf

	ld   a, b                                                       ; $0ec2
	ldh  [hBallSpeedX], a                                           ; $0ec3
	ld   a, c                                                       ; $0ec5
	ldh  [hBallSpeedSubX], a                                        ; $0ec6

;; Set that we changed ball X
	ldh  a, [hBallX]                                                ; $0ec8
	ldh  [hPrevBallX], a                                            ; $0eca
	ret                                                             ; $0ecc


Stub_0ecd:
	ret                                                             ; $0ecd


UnusedMoveBallFurtherVertically:
; If ball is moving up, move it more up, same with down
	ldh  a, [hBallSpeedY]                                           ; $0ece
	and  $80                                                        ; $0ed0
	push af                                                         ; $0ed2
	call nz, MoveBallUpDueToCollision                               ; $0ed3
	pop  af                                                         ; $0ed6
	call z, MoveBallDownDueToCollision                              ; $0ed7
	ret                                                             ; $0eda


MoveBallFurtherHoriz:
; If ball is moving left, move it more left, same with right
	ldh  a, [hBallSpeedX]                                           ; $0edb
	and  $80                                                        ; $0edd
	push af                                                         ; $0edf
	call nz, MoveBallLeftDueToCollision                             ; $0ee0
	pop  af                                                         ; $0ee3
	call z, MoveBallRightDueToCollision                             ; $0ee4
	ret                                                             ; $0ee7


MoveBallUpDueToCollision:
; Return if ball Y is already adjusted to a brick row
	ldh  a, [hBallY]                                                ; $0ee8
	and  $03                                                        ; $0eea
	ret  z                                                          ; $0eec

; Move ball up, past its brick row
	ld   b, a                                                       ; $0eed
	ldh  a, [hBallY]                                                ; $0eee
	and  $fc                                                        ; $0ef0
	sub  b                                                          ; $0ef2

	inc  a                                                          ; $0ef3
	ldh  [hBallY], a                                                ; $0ef4
	ret                                                             ; $0ef6


MoveBallDownDueToCollision:
; Return if ball Y is already adjusted to a brick row
	ldh  a, [hBallY]                                                ; $0ef7
	and  $03                                                        ; $0ef9
	ret  z                                                          ; $0efb

; Move ball down, past its brick row
	ld   b, a                                                       ; $0efc
	ldh  a, [hBallY]                                                ; $0efd
	and  $fc                                                        ; $0eff
	add  $08                                                        ; $0f01
	sub  b                                                          ; $0f03

	dec  a                                                          ; $0f04
	ldh  [hBallY], a                                                ; $0f05
	ret                                                             ; $0f07


MoveBallLeftDueToCollision:
; B = 4 if hit the right half of a brick, or -4 if hit the left half
	ld   b, $04                                                     ; $0f08
	ldh  a, [hBallX]                                                ; $0f0a
	and  $04                                                        ; $0f0c
	jr   nz, :+                                                     ; $0f0e
	ld   b, $fc                                                     ; $0f10

; Adjust X with above, with a minimum X of $10
:	ldh  a, [hBallX]                                                ; $0f12
	and  $f8                                                        ; $0f14
	add  b                                                          ; $0f16
	cp   $10                                                        ; $0f17
	jr   nc, :+                                                     ; $0f19
	
	ld   a, $10                                                     ; $0f1b
:	ldh  [hBallX], a                                                ; $0f1d
	ret                                                             ; $0f1f


MoveBallRightDueToCollision:
; Move ball right, with a max X of $7c
	ldh  a, [hBallX]                                                ; $0f20
	and  $f8                                                        ; $0f22
	add  $08                                                        ; $0f24
	cp   $7c                                                        ; $0f26
	jr   c, :+                                                      ; $0f28

	ld   a, $7c                                                     ; $0f2a
:	ldh  [hBallX], a                                                ; $0f2c
	ret                                                             ; $0f2e


ProcessSpeedChangeFromHittingBrick:
; Get metadata for brick hit
	ldh  a, [hTileHitByBall]                                        ; $0f2f
	dec  a                                                          ; $0f31
	ld   b, a                                                       ; $0f32
	ld   e, $06                                                     ; $0f33
	call BCequBtimesE                                               ; $0f35
	ld   hl, BricksMetadata                                         ; $0f38
	add  hl, bc                                                     ; $0f3b

; Get 5th byte
	ld   b, $00                                                     ; $0f3c
	ld   c, $04                                                     ; $0f3e
	add  hl, bc                                                     ; $0f40

; Return if 0
	ld   a, [hl]                                                    ; $0f41
	cp   $00                                                        ; $0f42
	ret  z                                                          ; $0f44

; Else, set in B, returning if curr ball speed is greater than it
	ld   b, a                                                       ; $0f45
	ldh  a, [hBallSpeed]                                            ; $0f46
	cp   b                                                          ; $0f48
	ret  nc                                                         ; $0f49

; If higher speed, set it, and set its Y and X vals
	ld   a, b                                                       ; $0f4a
	ldh  [hBallSpeed], a                                            ; $0f4b
	jr   SetYXSpeedsFromUpdatedBallSpeed                            ; $0f4d


ChangeYXballSpeedsEvery10calls:
	ldh  a, [hUpdateBallSpeedCounter]                               ; $0f4f
	inc  a                                                          ; $0f51
	cp   $0a                                                        ; $0f52
	jr   c, .setCounter                                             ; $0f54

	call SetYXSpeedsFromUpdatedBallSpeed                            ; $0f56
	xor  a                                                          ; $0f59

.setCounter:
	ldh  [hUpdateBallSpeedCounter], a                               ; $0f5a
	ret                                                             ; $0f5c


UnusedIncBallSpeed:
; Inc counter, jumping if not hit 8 yet
	ldh  a, [hCounterUntilBallIncreasesSpeed]                       ; $0f5d
	inc  a                                                          ; $0f5f
	cp   $08                                                        ; $0f60
	jr   c, .setCounter                                             ; $0f62

; Once hit, inc speed and set Y/X adjust vals, then reset counter
	call IncBallSpeed                                               ; $0f64
	call SetYXSpeedsFromUpdatedBallSpeed                            ; $0f67
	xor  a                                                          ; $0f6a

.setCounter:
	ldh  [hCounterUntilBallIncreasesSpeed], a                       ; $0f6b
	ret                                                             ; $0f6d


IncBallSpeed:
; Inc ball speed, looping $1a->3
	ldh  a, [hBallSpeed]                                            ; $0f6e
	inc  a                                                          ; $0f70
	cp   $1a                                                        ; $0f71
	jr   c, :+                                                      ; $0f73
	ld   a, $03                                                     ; $0f75
:	ldh  [hBallSpeed], a                                            ; $0f77
	jp   Stub_4a29                                                  ; $0f79


UpdateBallPosition:
; Store prev Y, and get HL = ball Y
	ldh  a, [hBallY]                                                ; $0f7c
	ldh  [hPrevBallY], a                                            ; $0f7e
	ld   h, a                                                       ; $0f80
	ldh  a, [hBallSubY]                                             ; $0f81
	ld   l, a                                                       ; $0f83

; HL = speed added to ball Y
	ldh  a, [hBallSpeedY]                                           ; $0f84
	ld   b, a                                                       ; $0f86
	ldh  a, [hBallSpeedSubY]                                        ; $0f87
	ld   c, a                                                       ; $0f89
	add  hl, bc                                                     ; $0f8a

; Unnecessary save of speed Y
	ld   a, c                                                       ; $0f8b
	ldh  [hBallSpeedSubY], a                                        ; $0f8c
	ld   a, b                                                       ; $0f8e
	ldh  [hBallSpeedY], a                                           ; $0f8f

; Set new Y coords
	ld   a, l                                                       ; $0f91
	ldh  [hBallSubY], a                                             ; $0f92
	ld   a, h                                                       ; $0f94
	ldh  [hBallY], a                                                ; $0f95

; Store prev X, and get HL = ball X
	ldh  a, [hBallX]                                                ; $0f97
	ldh  [hPrevBallX], a                                            ; $0f99
	ld   h, a                                                       ; $0f9b
	ldh  a, [hBallSubX]                                             ; $0f9c
	ld   l, a                                                       ; $0f9e

; HL = speed added to ball X
	ldh  a, [hBallSpeedX]                                           ; $0f9f
	ld   b, a                                                       ; $0fa1
	ldh  a, [hBallSpeedSubX]                                        ; $0fa2
	ld   c, a                                                       ; $0fa4
	add  hl, bc                                                     ; $0fa5

; Unnecessary save of speed X
	ld   a, c                                                       ; $0fa6
	ldh  [hBallSpeedSubX], a                                        ; $0fa7
	ld   a, b                                                       ; $0fa9
	ldh  [hBallSpeedX], a                                           ; $0faa

; Set new X coords
	ld   a, l                                                       ; $0fac
	ldh  [hBallSubX], a                                             ; $0fad
	ld   a, h                                                       ; $0faf
	ldh  [hBallX], a                                                ; $0fb0
	ret                                                             ; $0fb2


NegBC:
	ld   a, b                                                       ; $0fb3
	xor  $ff                                                        ; $0fb4
	ld   b, a                                                       ; $0fb6
	ld   a, c                                                       ; $0fb7
	xor  $ff                                                        ; $0fb8
	ld   c, a                                                       ; $0fba
	inc  bc                                                         ; $0fbb
	ret                                                             ; $0fbc


SetYXSpeedsFromUpdatedBallSpeed:
; HL = ball speed double idxed into table
	ld   b, $00                                                     ; $0fbd
	ldh  a, [hBallSpeed]                                            ; $0fbf
	dec  a                                                          ; $0fc1
	sla  a                                                          ; $0fc2
	ld   c, a                                                       ; $0fc4
	ld   hl, BallSpeedAndAngleYXvalues                              ; $0fc5
	add  hl, bc                                                     ; $0fc8

; Push the word in the table
	ld   a, [hl+]                                                   ; $0fc9
	ld   c, a                                                       ; $0fca
	ld   a, [hl]                                                    ; $0fcb
	ld   b, a                                                       ; $0fcc
	push bc                                                         ; $0fcd

; Get a random value from this table (1 of 6, 8, 10)
	call IncAndGetRNG                                               ; $0fce
	and  $07                                                        ; $0fd1
	ld   b, $00                                                     ; $0fd3
	ld   c, a                                                       ; $0fd5
	ld   hl, RandomDegrees_30_40_50                                 ; $0fd6
	add  hl, bc                                                     ; $0fd9

; HL points to random set of 4 bytes in table
	ld   a, [hl]                                                    ; $0fda
	pop  bc                                                         ; $0fdb
	sla  a                                                          ; $0fdc
	sla  a                                                          ; $0fde
	ld   h, $00                                                     ; $0fe0
	ld   l, a                                                       ; $0fe2
	add  hl, bc                                                     ; $0fe3

; 1st word in BC
	ld   a, [hl+]                                                   ; $0fe4
	ld   b, a                                                       ; $0fe5
	ld   a, [hl+]                                                   ; $0fe6
	ld   c, a                                                       ; $0fe7

; If ball is moving up, neg the 1st word, and set new y speed
	ldh  a, [hBallSpeedY]                                           ; $0fe8
	and  $80                                                        ; $0fea
	jr   z, :+                                                      ; $0fec
	call NegBC                                                      ; $0fee
:	ld   a, b                                                       ; $0ff1
	ldh  [hBallSpeedY], a                                           ; $0ff2
	ld   a, c                                                       ; $0ff4
	ldh  [hBallSpeedSubY], a                                        ; $0ff5

; 2nd word in BC
	ld   a, [hl+]                                                   ; $0ff7
	ld   b, a                                                       ; $0ff8
	ld   a, [hl+]                                                   ; $0ff9
	ld   c, a                                                       ; $0ffa

; If ball is moving left, neg the 2nd word, and set new x speed
	ldh  a, [hBallSpeedX]                                           ; $0ffb
	and  $80                                                        ; $0ffd
	jr   z, :+                                                      ; $0fff
	call NegBC                                                      ; $1001
:	ld   a, b                                                       ; $1004
	ldh  [hBallSpeedX], a                                           ; $1005
	ld   a, c                                                       ; $1007
	ldh  [hBallSpeedSubX], a                                        ; $1008
	ret                                                             ; $100a


RandomDegrees_30_40_50:
	db $06, $08, $0a, $06, $08, $0a, $08, $0a
	

UnusedRandomDegrees_50_60_70:
	db $0a, $0c, $0e, $0a, $0c, $0e, $0a, $0c


SetInitialBallSpeedAndCoords:
; Ball X and Y now on the pixel
	xor  a                                                          ; $101b
	ldh  [hBallSubY], a                                             ; $101c
	ldh  [hBallSubX], a                                             ; $101e

; Starting speed is 3
	ld   a, $03                                                     ; $1020
	ldh  [hBallSpeed], a                                            ; $1022

; Jump if bonus level
	ldh  a, [hIsBonusLevel]                                         ; $1024
	cp   $00                                                        ; $1026
	jr   nz, .fasterBallSpeed                                       ; $1028

; If there are more than 40 bricks, ball is faster
	ldh  a, [hNumBricksInStage]                                     ; $102a
	cp   HIGH($28)                                                  ; $102c
	jr   nz, .afterBallSpeedCheck                                   ; $102e

	ldh  a, [hNumBricksInStage+1]                                   ; $1030
	cp   LOW($28)                                                   ; $1032
	jr   nc, .afterBallSpeedCheck                                   ; $1034

.fasterBallSpeed:
	ld   a, $07                                                     ; $1036
	ldh  [hBallSpeed], a                                            ; $1038

.afterBallSpeedCheck:
; B = +$18 to start with
	ld   a, $18                                                     ; $103a
	ld   b, a                                                       ; $103c

; C = paddle length / 2
	ldh  a, [hPaddlePixelLength]                                    ; $103d
	srl  a                                                          ; $103f
	ld   c, a                                                       ; $1041

; If midpoint is >= $48, B = -$18
	ldh  a, [hPaddleX]                                              ; $1042
	add  c                                                          ; $1044
	cp   $48                                                        ; $1045
	jr   c, .afterPaddleLocCheck                                    ; $1047

	ld   a, -$18                                                    ; $1049
	ld   b, a                                                       ; $104b

.afterPaddleLocCheck:
; Ball X = paddle midpoint +/- $18
	ldh  a, [hPaddleX]                                              ; $104c
	add  b                                                          ; $104e
	add  c                                                          ; $104f
	ldh  [hBallX], a                                                ; $1050
	ldh  [hPrevBallX], a                                            ; $1052

; Set initial ball Y
	ld   a, $8c                                                     ; $1054
	sub  $18                                                        ; $1056
	ldh  [hBallY], a                                                ; $1058
	ldh  [hPrevBallY], a                                            ; $105a

; Save +/- $18
	ld   a, b                                                       ; $105c
	push af                                                         ; $105d

; HL points to address containing slowest speed vals
	ld   b, $00                                                     ; $105e
	ld   c, $00                                                     ; $1060
	ld   hl, BallSpeedAndAngleYXvalues                              ; $1062
	add  hl, bc                                                     ; $1065

; BC is that address
	ld   a, [hl+]                                                   ; $1066
	ld   c, a                                                       ; $1067
	ld   a, [hl]                                                    ; $1068
	ld   b, a                                                       ; $1069

; HL points to 45 degrees entry
	ld   a, $09                                                     ; $106a
	sla  a                                                          ; $106c
	sla  a                                                          ; $106e
	ld   h, $00                                                     ; $1070
	ld   l, a                                                       ; $1072
	add  hl, bc                                                     ; $1073

; Set Y speed from entry
	ld   a, [hl+]                                                   ; $1074
	ldh  [hBallSpeedY], a                                           ; $1075
	ld   a, [hl+]                                                   ; $1077
	ldh  [hBallSpeedSubY], a                                        ; $1078

; BC = X speed from entry
	ld   a, [hl+]                                                   ; $107a
	ld   b, a                                                       ; $107b
	ld   a, [hl+]                                                   ; $107c
	ld   c, a                                                       ; $107d

; Ball moves right if starting from left of paddle, and vice versae
	pop  af                                                         ; $107e
	cp   $80                                                        ; $107f
	jr   nc, :+                                                     ; $1081
	call NegBC                                                      ; $1083
	
:	ld   a, b                                                       ; $1086
	ldh  [hBallSpeedX], a                                           ; $1087
	ld   a, c                                                       ; $1089
	ldh  [hBallSpeedSubX], a                                        ; $108a
	ret                                                             ; $108c


UpdateBallOam:
	ld   hl, wOam+OSLOT_BALL                                        ; $108d
	ldh  a, [hBallY]                                                ; $1090
	ld   [hl+], a                                                   ; $1092

	ldh  a, [hBallX]                                                ; $1093
	ld   [hl+], a                                                   ; $1095

	ld   a, TILE_BALL                                               ; $1096
	ld   [hl+], a                                                   ; $1098
	ld   a, $00                                                     ; $1099
	ld   [hl+], a                                                   ; $109b
	ret                                                             ; $109c


ProcessPaddleMovementAndOam:
	call ProcessPaddleMovement                                      ; $109d
	call UpdatePaddleOam                                            ; $10a0
	ret                                                             ; $10a3


ProcessPaddleMovement:
; Jump if we received a serial byte between $00 and $f0
	ldh  a, [hSerialByteReceived]                                   ; $10a4
	cp   $f1                                                        ; $10a6
	jr   c, .setPaddleXFromSerialByte                               ; $10a8

; B = movement speed, jump if A pressed with speed = 5 (fastest)
	ld   b, $05                                                     ; $10aa
	ldh  a, [hButtonsNotHeld]                                       ; $10ac
	rrca                                                            ; $10ae
	jr   nc, .afterPaddleSpeedCheck                                 ; $10af

; Jump if B pressed (slowest speed)
	ld   b, $01                                                     ; $10b1
	rrca                                                            ; $10b3
	jr   nc, .afterPaddleSpeedCheck                                 ; $10b4

; Else use medium speed
	ld   b, $03                                                     ; $10b6

.afterPaddleSpeedCheck:
; Flip to get bits set per btn held, returning if left/right not held
	ldh  a, [hButtonsNotHeld]                                       ; $10b8
	xor  $ff                                                        ; $10ba
	and  PADF_LEFT|PADF_RIGHT                                       ; $10bc
	ret  z                                                          ; $10be

; Jump if it was holding right
	and  PADF_LEFT                                                  ; $10bf
	jr   z, .movingRight                                            ; $10c1

; X -= speed
	ldh  a, [hPaddleX]                                              ; $10c3
	sub  b                                                          ; $10c5
	cp   $0f                                                        ; $10c6
	jr   nc, .setPaddleX                                            ; $10c8

; With a minimum of $0f
	ld   a, $0f                                                     ; $10ca
	jr   .setPaddleX                                                ; $10cc

.movingRight:
; C = paddle length
	ldh  a, [hPaddlePixelLength]                                    ; $10ce
	ld   c, a                                                       ; $10d0

; C = end of screen - paddle length
	ld   a, $7f                                                     ; $10d1
	sub  c                                                          ; $10d3
	ld   c, a                                                       ; $10d4

; Add speed onto paddle X
	ldh  a, [hPaddleX]                                              ; $10d5
	add  b                                                          ; $10d7
	cp   c                                                          ; $10d8
	jr   c, .setPaddleX                                             ; $10d9

; With a max of end of screen - paddle length
	ld   a, c                                                       ; $10db

.setPaddleX:
	ldh  [hPaddleX], a                                              ; $10dc
	ret                                                             ; $10de

.setPaddleXFromSerialByte:
; Paddle max X is right edge of screen - length
	ldh  a, [hPaddlePixelLength]                                    ; $10df
	ld   b, a                                                       ; $10e1
	ld   a, $7f                                                     ; $10e2
	sub  b                                                          ; $10e4
	ld   b, a                                                       ; $10e5

; Curr paddle X = serial byte - $30, ie possible vals from $00 to $c0
	ldh  a, [hSerialByteReceived]                                   ; $10e6
	sub  $30                                                        ; $10e8
	jr   c, :+                                                      ; $10ea

; A - paddle's X
; B - paddle's maximum X
AdjustPaddleXIfBreachingScreenEnds:
; Paddle X is a minimum of $0f
	cp   $0f                                                        ; $10ec
	jr   nc, .afterLeftCheck                                        ; $10ee

:	ld   a, $0f                                                     ; $10f0
	jr   .setPaddleX                                                ; $10f2

.afterLeftCheck:
; Paddle X is a maximum of B
	cp   b                                                          ; $10f4
	jr   c, .setPaddleX                                             ; $10f5

	ld   a, b                                                       ; $10f7

.setPaddleX:
	ldh  [hPaddleX], a                                              ; $10f8
	ret                                                             ; $10fa


ProcessPaddleLengthening::
; Lengthen paddle, setting its correct length
	xor  a                                                          ; $10fb
	ldh  [hPaddleShortened], a                                      ; $10fc

	ld   a, $18                                                     ; $10fe
	ldh  [hPaddlePixelLength], a                                    ; $1100

; Adjust X so it doesn't look like it moved
	ldh  a, [hPaddleX]                                              ; $1102
	sub  $04                                                        ; $1104
	ldh  [hPaddleX], a                                              ; $1106

; B = $80 - paddle pixel length
	ldh  a, [hPaddlePixelLength]                                    ; $1108
	ld   b, a                                                       ; $110a
	ld   a, $80                                                     ; $110b
	sub  b                                                          ; $110d
	ld   b, a                                                       ; $110e

; A and B as params to func to adjust if breaching screen ends
	ldh  a, [hPaddleX]                                              ; $110f
	jr   AdjustPaddleXIfBreachingScreenEnds                         ; $1111

	
; A - ball's position from left side of paddle
BallHitTopOfPaddle:
	push af                                                         ; $1113

; HL points to address containing angle data for curr speed
	ld   b, $00                                                     ; $1114
	ldh  a, [hBallSpeed]                                            ; $1116
	dec  a                                                          ; $1118
	sla  a                                                          ; $1119
	ld   c, a                                                       ; $111b
	ld   hl, BallSpeedAndAngleYXvalues                              ; $111c
	add  hl, bc                                                     ; $111f

; BC points to angles for the curr speed
	ld   a, [hl+]                                                   ; $1120
	ld   c, a                                                       ; $1121
	ld   a, [hl]                                                    ; $1122
	ld   b, a                                                       ; $1123
	pop  af                                                         ; $1124

; Preserve orig A, and set DE to be the idx of angles when hitting the paddle
	push af                                                         ; $1125
	ld   d, $00                                                     ; $1126
	ld   e, a                                                       ; $1128

; Get new ball angle based on length, and further idxed by hit area
	ld   hl, AnglesWhenHittingLongPaddle                            ; $1129
	ldh  a, [hPaddleShortened]                                      ; $112c
	cp   $00                                                        ; $112e
	jr   z, :+                                                      ; $1130
	ld   hl, AnglesWhenHittingShortPaddle                           ; $1132
:	add  hl, de                                                     ; $1135

; Get angle's entry in the speed table
	ld   a, [hl]                                                    ; $1136
	sla  a                                                          ; $1137
	sla  a                                                          ; $1139
	ld   h, $00                                                     ; $113b
	ld   l, a                                                       ; $113d
	add  hl, bc                                                     ; $113e

; BC = ball Y speed
	ld   a, [hl+]                                                   ; $113f
	ld   b, a                                                       ; $1140
	ld   a, [hl+]                                                   ; $1141
	ld   c, a                                                       ; $1142

; Have ball move up
	call NegBC                                                      ; $1143
	ld   a, b                                                       ; $1146
	ldh  [hBallSpeedY], a                                           ; $1147
	ld   a, c                                                       ; $1149
	ldh  [hBallSpeedSubY], a                                        ; $114a

; BC = ball X speed
	ld   a, [hl+]                                                   ; $114c
	ld   b, a                                                       ; $114d
	ld   a, [hl+]                                                   ; $114e
	ld   c, a                                                       ; $114f

; D = 8 if paddle lengthened, or 6 if not
	ld   d, $08                                                     ; $1150
	ldh  a, [hPaddleShortened]                                      ; $1152
	cp   $00                                                        ; $1154
	jr   z, :+                                                      ; $1156
	ld   d, $06                                                     ; $1158

; If we hit the left side of paddle left + D, move left instead of right
:	pop  af                                                         ; $115a
	cp   d                                                          ; $115b
	jr   nc, :+                                                     ; $115c
	call NegBC                                                      ; $115e
	
:	ld   a, b                                                       ; $1161
	ldh  [hBallSpeedX], a                                           ; $1162
	ld   a, c                                                       ; $1164
	ldh  [hBallSpeedSubX], a                                        ; $1165

; Move layout down over time, and play square effect
	call TickFallingLayoutCounter                                   ; $1167
	jp   StartSquareEffect4                                         ; $116a


TickFallingLayoutCounter:
; Dec counter, jumping and updating it, if not yet 0
	ldh  a, [hFallingLayoutCounter]                                 ; $116d
	dec  a                                                          ; $116f
	ldh  [hFallingLayoutCounter], a                                 ; $1170

	jr   nz, ProcessFallingLayoutCounter.setFallingCounter          ; $1172

; Once 0, move layout down
	call MoveLayoutDown                                             ; $1174

ProcessFallingLayoutCounter:
; If table idx is within table, set speed from table
	ldh  a, [hFallingLayoutSpeedIdx]                                ; $1177
	cp   LayoutFallingSpeeds.end-LayoutFallingSpeeds                ; $1179
	jr   c, .nonSuperFastSpeed                                      ; $117b

; Else have layout drop 1 paddle hit at a time
	ld   a, $01                                                     ; $117d
	jr   .setFallingCounter                                         ; $117f

.nonSuperFastSpeed:
; BC = table idx for curr counter. Set inc'd speed idx
	ld   c, a                                                       ; $1181
	ld   b, $00                                                     ; $1182
	inc  a                                                          ; $1184
	ldh  [hFallingLayoutSpeedIdx], a                                ; $1185

; Set new falling counter
	ld   hl, LayoutFallingSpeeds                                    ; $1187
	add  hl, bc                                                     ; $118a
	ld   a, [hl]                                                    ; $118b

.setFallingCounter:
	ldh  [hFallingLayoutCounter], a                                 ; $118c
	ret                                                             ; $118e


UpdatePaddleOam::
	ld   hl, wOam+OSLOT_PADDLE                                      ; $118f

; Different routine for shortened paddle
	ldh  a, [hPaddleShortened]                                      ; $1192
	cp   $00                                                        ; $1194
	jr   nz, .shortened                                             ; $1196

; For left end bit, store paddle Y, then paddle X+1
	ldh  a, [hPaddleY]                                              ; $1198
	ld   [hl+], a                                                   ; $119a
	ldh  a, [hPaddleX]                                              ; $119b
	add  $01                                                        ; $119d
	ld   [hl+], a                                                   ; $119f

; Set tile idx and no attrs
	ld   a, TILE_PADDLE_END                                         ; $11a0
	ld   [hl+], a                                                   ; $11a2
	ld   a, $00                                                     ; $11a3
	ld   [hl+], a                                                   ; $11a5

; For middle bit, store Y and X+9
	ldh  a, [hPaddleY]                                              ; $11a6
	ld   [hl+], a                                                   ; $11a8
	ldh  a, [hPaddleX]                                              ; $11a9
	add  $09                                                        ; $11ab
	ld   [hl+], a                                                   ; $11ad

; Set tile idx and no attrs
	ld   a, TILE_PADDLE_MIDDLE                                      ; $11ae
	ld   [hl+], a                                                   ; $11b0
	ld   a, $00                                                     ; $11b1
	ld   [hl+], a                                                   ; $11b3

; For right end bit, store Y and X+$11
	ldh  a, [hPaddleY]                                              ; $11b4
	ld   [hl+], a                                                   ; $11b6
	ldh  a, [hPaddleX]                                              ; $11b7
	add  $11                                                        ; $11b9
	ld   [hl+], a                                                   ; $11bb

; Set tile idx, and attr to xflip it
	ld   a, TILE_PADDLE_END                                         ; $11bc
	ld   [hl+], a                                                   ; $11be
	ld   a, OAMF_XFLIP                                              ; $11bf
	ld   [hl+], a                                                   ; $11c1
	ret                                                             ; $11c2

.shortened:
; For left end bit, store paddle Y, then paddle X+1
	ldh  a, [hPaddleY]                                              ; $11c3
	ld   [hl+], a                                                   ; $11c5
	ldh  a, [hPaddleX]                                              ; $11c6
	add  $01                                                        ; $11c8
	ld   [hl+], a                                                   ; $11ca

; Set tile idx, and no attrs
	ld   a, TILE_PADDLE_END                                         ; $11cb
	ld   [hl+], a                                                   ; $11cd
	ld   a, $00                                                     ; $11ce
	ld   [hl+], a                                                   ; $11d0

; For right end bit, store Y and X+9
	ldh  a, [hPaddleY]                                              ; $11d1
	ld   [hl+], a                                                   ; $11d3
	ldh  a, [hPaddleX]                                              ; $11d4
	add  $09                                                        ; $11d6
	ld   [hl+], a                                                   ; $11d8

; Set tile idx and attr to xflip it
	ld   a, $00                                                     ; $11d9
	ld   [hl+], a                                                   ; $11db
	ld   a, OAMF_XFLIP                                              ; $11dc
	ld   [hl+], a                                                   ; $11de

; For middle bit, store Y and X+5
	ldh  a, [hPaddleY]                                              ; $11df
	ld   [hl+], a                                                   ; $11e1
	ldh  a, [hPaddleX]                                              ; $11e2
	add  $05                                                        ; $11e4
	ld   [hl+], a                                                   ; $11e6

; Set tile idx and no attrs
	ld   a, TILE_PADDLE_MIDDLE                                      ; $11e7
	ld   [hl+], a                                                   ; $11e9
	ld   a, $00                                                     ; $11ea
	ld   [hl+], a                                                   ; $11ec
	ret                                                             ; $11ed


BallSpeedAndAngleYXvalues:
	dw .speed00
	dw .speed01
	dw .speed02
	dw .speed03
	dw .speed04
	dw .speed05
	dw .speed06
	dw .speed07
	dw .speed08
	dw .speed09
	dw .speed0a
	dw .speed0b
	dw .speed0c
	dw .speed0d
	dw .speed0e
	dw .speed0f
	dw .speed10
	dw .speed11
	dw .speed12
	dw .speed13
	dw .speed14
	dw .speed15
	dw .speed16
	dw .speed17
	dw .speed18

; Y movement, X movement
.speed00:
	dwbe $0000, $0100
	dwbe $0016, $00ff
	dwbe $002c, $00fc
	dwbe $0042, $00f7
	dwbe $0058, $00f1
	dwbe $006c, $00e8
	dwbe $0080, $00de
	dwbe $0093, $00d2
	dwbe $00a5, $00c4
	dwbe $00b5, $00b5
	dwbe $00c4, $00a5
	dwbe $00d2, $0093
	dwbe $00de, $0080
	dwbe $00e8, $006c
	dwbe $00f1, $0058
	dwbe $00f7, $0042
	dwbe $00fc, $002c
	dwbe $00ff, $0016
	dwbe $0100, $0000

.speed01:
	dwbe $0000, $0120
	dwbe $0019, $011f
	dwbe $0032, $011c
	dwbe $004b, $0116
	dwbe $0063, $010f
	dwbe $007a, $0105
	dwbe $0090, $00f9
	dwbe $00a5, $00ec
	dwbe $00b9, $00dd
	dwbe $00cc, $00cc
	dwbe $00dd, $00b9
	dwbe $00ec, $00a5
	dwbe $00f9, $0090
	dwbe $0105, $007a
	dwbe $010f, $0063
	dwbe $0116, $004b
	dwbe $011c, $0032
	dwbe $011f, $0019
	dwbe $0120, $0000

.speed02:
	dwbe $0000, $0140
	dwbe $001c, $013f
	dwbe $0038, $013b
	dwbe $0053, $0135
	dwbe $006d, $012d
	dwbe $0087, $0122
	dwbe $00a0, $0115
	dwbe $00b8, $0106
	dwbe $00ce, $00f5
	dwbe $00e2, $00e2
	dwbe $00f5, $00ce
	dwbe $0106, $00b8
	dwbe $0115, $00a0
	dwbe $0122, $0087
	dwbe $012d, $006d
	dwbe $0135, $0053
	dwbe $013b, $0038
	dwbe $013f, $001c
	dwbe $0140, $0000

.speed03:
	dwbe $0000, $0160
	dwbe $001f, $015f
	dwbe $003d, $015b
	dwbe $005b, $0154
	dwbe $0078, $014b
	dwbe $0095, $013f
	dwbe $00b0, $0131
	dwbe $00ca, $0120
	dwbe $00e2, $010e
	dwbe $00f9, $00f9
	dwbe $010e, $00e2
	dwbe $0120, $00ca
	dwbe $0131, $00b0
	dwbe $013f, $0095
	dwbe $014b, $0078
	dwbe $0154, $005b
	dwbe $015b, $003d
	dwbe $015f, $001f
	dwbe $0160, $0000

.speed04:
	dwbe $0000, $0180
	dwbe $0021, $017f
	dwbe $0043, $017a
	dwbe $0063, $0173
	dwbe $0083, $0169
	dwbe $00a2, $015c
	dwbe $00c0, $014d
	dwbe $00dc, $013b
	dwbe $00f7, $0126
	dwbe $0110, $0110
	dwbe $0126, $00f7
	dwbe $013b, $00dc
	dwbe $014d, $00c0
	dwbe $015c, $00a2
	dwbe $0169, $0083
	dwbe $0173, $0063
	dwbe $017a, $0043
	dwbe $017f, $0021
	dwbe $0180, $0000

.speed05:
	dwbe $0000, $01a0
	dwbe $0024, $019e
	dwbe $0048, $019a
	dwbe $006c, $0192
	dwbe $008e, $0187
	dwbe $00b0, $0179
	dwbe $00d0, $0168
	dwbe $00ef, $0155
	dwbe $010b, $013f
	dwbe $0126, $0126
	dwbe $013f, $010b
	dwbe $0155, $00ef
	dwbe $0168, $00d0
	dwbe $0179, $00b0
	dwbe $0187, $008e
	dwbe $0192, $006c
	dwbe $019a, $0048
	dwbe $019e, $0024
	dwbe $01a0, $0000

.speed06:
	dwbe $0000, $01c0
	dwbe $0027, $01be
	dwbe $004e, $01b9
	dwbe $0074, $01b1
	dwbe $0099, $01a5
	dwbe $00bd, $0196
	dwbe $00e0, $0184
	dwbe $0101, $016f
	dwbe $0120, $0157
	dwbe $013d, $013d
	dwbe $0157, $0120
	dwbe $016f, $0101
	dwbe $0184, $00e0
	dwbe $0196, $00bd
	dwbe $01a5, $0099
	dwbe $01b1, $0074
	dwbe $01b9, $004e
	dwbe $01be, $0027
	dwbe $01c0, $0000

.speed07:
	dwbe $0000, $01e0
	dwbe $002a, $01de
	dwbe $0053, $01d9
	dwbe $007c, $01d0
	dwbe $00a4, $01c3
	dwbe $00cb, $01b3
	dwbe $00f0, $01a0
	dwbe $0113, $0189
	dwbe $0135, $0170
	dwbe $0153, $0153
	dwbe $0170, $0135
	dwbe $0189, $0113
	dwbe $01a0, $00f0
	dwbe $01b3, $00cb
	dwbe $01c3, $00a4
	dwbe $01d0, $007c
	dwbe $01d9, $0053
	dwbe $01de, $002a
	dwbe $01e0, $0000

.speed08:
	dwbe $0000, $0200
	dwbe $002d, $01fe
	dwbe $0059, $01f8
	dwbe $0085, $01ef
	dwbe $00af, $01e1
	dwbe $00d8, $01d0
	dwbe $0100, $01bb
	dwbe $0126, $01a3
	dwbe $0149, $0188
	dwbe $016a, $016a
	dwbe $0188, $0149
	dwbe $01a3, $0126
	dwbe $01bb, $0100
	dwbe $01d0, $00d8
	dwbe $01e1, $00af
	dwbe $01ef, $0085
	dwbe $01f8, $0059
	dwbe $01fe, $002d
	dwbe $0200, $0000

.speed09:
	dwbe $0000, $0220
	dwbe $002f, $021e
	dwbe $005e, $0218
	dwbe $008d, $020d
	dwbe $00ba, $01ff
	dwbe $00e6, $01ed
	dwbe $0110, $01d7
	dwbe $0138, $01be
	dwbe $015e, $01a1
	dwbe $0181, $0181
	dwbe $01a1, $015e
	dwbe $01be, $0138
	dwbe $01d7, $0110
	dwbe $01ed, $00e6
	dwbe $01ff, $00ba
	dwbe $020d, $008d
	dwbe $0218, $005e
	dwbe $021e, $002f
	dwbe $0220, $0000

.speed0a:
	dwbe $0000, $0240
	dwbe $0032, $023e
	dwbe $0064, $0237
	dwbe $0095, $022c
	dwbe $00c5, $021d
	dwbe $00f3, $020a
	dwbe $0120, $01f3
	dwbe $014a, $01d8
	dwbe $0172, $01b9
	dwbe $0197, $0197
	dwbe $01b9, $0172
	dwbe $01d8, $014a
	dwbe $01f3, $0120
	dwbe $020a, $00f3
	dwbe $021d, $00c5
	dwbe $022c, $0095
	dwbe $0237, $0064
	dwbe $023e, $0032
	dwbe $0240, $0000

.speed0b:
	dwbe $0000, $0260
	dwbe $0035, $025e
	dwbe $006a, $0257
	dwbe $009d, $024b
	dwbe $00d0, $023b
	dwbe $0101, $0227
	dwbe $0130, $020f
	dwbe $015d, $01f2
	dwbe $0187, $01d2
	dwbe $01ae, $01ae
	dwbe $01d2, $0187
	dwbe $01f2, $015d
	dwbe $020f, $0130
	dwbe $0227, $0101
	dwbe $023b, $00d0
	dwbe $024b, $009d
	dwbe $0257, $006a
	dwbe $025e, $0035
	dwbe $0260, $0000

.speed0c:
	dwbe $0000, $0280
	dwbe $0038, $027e
	dwbe $006f, $0276
	dwbe $00a6, $026a
	dwbe $00db, $0259
	dwbe $010e, $0244
	dwbe $0140, $022a
	dwbe $016f, $020c
	dwbe $019b, $01ea
	dwbe $01c5, $01c5
	dwbe $01ea, $019b
	dwbe $020c, $016f
	dwbe $022a, $0140
	dwbe $0244, $010e
	dwbe $0259, $00db
	dwbe $026a, $00a6
	dwbe $0276, $006f
	dwbe $027e, $0038
	dwbe $0280, $0000

.speed0d:
	dwbe $0000, $02a0
	dwbe $003b, $029d
	dwbe $0075, $0296
	dwbe $00ae, $0289
	dwbe $00e6, $0277
	dwbe $011c, $0261
	dwbe $0150, $0246
	dwbe $0181, $0226
	dwbe $01b0, $0203
	dwbe $01db, $01db
	dwbe $0203, $01b0
	dwbe $0226, $0181
	dwbe $0246, $0150
	dwbe $0261, $011c
	dwbe $0277, $00e6
	dwbe $0289, $00ae
	dwbe $0296, $0075
	dwbe $029d, $003b
	dwbe $02a0, $0000

.speed0e:
	dwbe $0000, $02c0
	dwbe $003d, $02bd
	dwbe $007a, $02b5
	dwbe $00b6, $02a8
	dwbe $00f1, $0296
	dwbe $012a, $027e
	dwbe $0160, $0262
	dwbe $0194, $0241
	dwbe $01c5, $021b
	dwbe $01f2, $01f2
	dwbe $021b, $01c5
	dwbe $0241, $0194
	dwbe $0262, $0160
	dwbe $027e, $012a
	dwbe $0296, $00f1
	dwbe $02a8, $00b6
	dwbe $02b5, $007a
	dwbe $02bd, $003d
	dwbe $02c0, $0000

.speed0f:
	dwbe $0000, $02e0
	dwbe $0040, $02dd
	dwbe $0080, $02d5
	dwbe $00be, $02c7
	dwbe $00fc, $02b4
	dwbe $0137, $029b
	dwbe $0170, $027d
	dwbe $01a6, $025b
	dwbe $01d9, $0234
	dwbe $0208, $0208
	dwbe $0234, $01d9
	dwbe $025b, $01a6
	dwbe $027d, $0170
	dwbe $029b, $0137
	dwbe $02b4, $00fc
	dwbe $02c7, $00be
	dwbe $02d5, $0080
	dwbe $02dd, $0040
	dwbe $02e0, $0000

.speed10:
	dwbe $0000, $0300
	dwbe $0043, $02fd
	dwbe $0085, $02f4
	dwbe $00c7, $02e6
	dwbe $0107, $02d2
	dwbe $0145, $02b8
	dwbe $0180, $0299
	dwbe $01b9, $0275
	dwbe $01ee, $024c
	dwbe $021f, $021f
	dwbe $024c, $01ee
	dwbe $0275, $01b9
	dwbe $0299, $0180
	dwbe $02b8, $0145
	dwbe $02d2, $0107
	dwbe $02e6, $00c7
	dwbe $02f4, $0085
	dwbe $02fd, $0043
	dwbe $0300, $0000

.speed11:
	dwbe $0000, $0320
	dwbe $0046, $031d
	dwbe $008b, $0314
	dwbe $00cf, $0305
	dwbe $0112, $02f0
	dwbe $0152, $02d5
	dwbe $0190, $02b5
	dwbe $01cb, $028f
	dwbe $0202, $0265
	dwbe $0236, $0236
	dwbe $0265, $0202
	dwbe $028f, $01cb
	dwbe $02b5, $0190
	dwbe $02d5, $0152
	dwbe $02f0, $0112
	dwbe $0305, $00cf
	dwbe $0314, $008b
	dwbe $031d, $0046
	dwbe $0320, $0000

.speed12:
	dwbe $0000, $0340
	dwbe $0049, $033d
	dwbe $0090, $0333
	dwbe $00d7, $0324
	dwbe $011d, $030e
	dwbe $0160, $02f2
	dwbe $01a0, $02d1
	dwbe $01dd, $02aa
	dwbe $0217, $027d
	dwbe $024c, $024c
	dwbe $027d, $0217
	dwbe $02aa, $01dd
	dwbe $02d1, $01a0
	dwbe $02f2, $0160
	dwbe $030e, $011d
	dwbe $0324, $00d7
	dwbe $0333, $0090
	dwbe $033d, $0049
	dwbe $0340, $0000

.speed13:
	dwbe $0000, $0360
	dwbe $004b, $035d
	dwbe $0096, $0353
	dwbe $00e0, $0343
	dwbe $0128, $032c
	dwbe $016d, $030f
	dwbe $01b0, $02ec
	dwbe $01f0, $02c4
	dwbe $022b, $0296
	dwbe $0263, $0263
	dwbe $0296, $022b
	dwbe $02c4, $01f0
	dwbe $02ec, $01b0
	dwbe $030f, $016d
	dwbe $032c, $0128
	dwbe $0343, $00e0
	dwbe $0353, $0096
	dwbe $035d, $004b
	dwbe $0360, $0000

.speed14:
	dwbe $0000, $0380
	dwbe $004e, $037d
	dwbe $009c, $0372
	dwbe $00e8, $0361
	dwbe $0132, $034a
	dwbe $017b, $032c
	dwbe $01c0, $0308
	dwbe $0202, $02de
	dwbe $0240, $02ae
	dwbe $027a, $027a
	dwbe $02ae, $0240
	dwbe $02de, $0202
	dwbe $0308, $01c0
	dwbe $032c, $017b
	dwbe $034a, $0132
	dwbe $0361, $00e8
	dwbe $0372, $009c
	dwbe $037d, $004e
	dwbe $0380, $0000

.speed15:
	dwbe $0000, $03a0
	dwbe $0051, $039c
	dwbe $00a1, $0392
	dwbe $00f0, $0380
	dwbe $013d, $0368
	dwbe $0188, $0349
	dwbe $01d0, $0324
	dwbe $0214, $02f8
	dwbe $0255, $02c7
	dwbe $0290, $0290
	dwbe $02c7, $0255
	dwbe $02f8, $0214
	dwbe $0324, $01d0
	dwbe $0349, $0188
	dwbe $0368, $013d
	dwbe $0380, $00f0
	dwbe $0392, $00a1
	dwbe $039c, $0051
	dwbe $03a0, $0000

.speed16:
	dwbe $0000, $03c0
	dwbe $0054, $03bc
	dwbe $00a7, $03b1
	dwbe $00f8, $039f
	dwbe $0148, $0386
	dwbe $0196, $0366
	dwbe $01e0, $033f
	dwbe $0227, $0312
	dwbe $0269, $02df
	dwbe $02a7, $02a7
	dwbe $02df, $0269
	dwbe $0312, $0227
	dwbe $033f, $01e0
	dwbe $0366, $0196
	dwbe $0386, $0148
	dwbe $039f, $00f8
	dwbe $03b1, $00a7
	dwbe $03bc, $0054
	dwbe $03c0, $0000

.speed17:
	dwbe $0000, $03e0
	dwbe $0056, $03dc
	dwbe $00ac, $03d1
	dwbe $0101, $03be
	dwbe $0153, $03a4
	dwbe $01a3, $0383
	dwbe $01f0, $035b
	dwbe $0239, $032d
	dwbe $027e, $02f8
	dwbe $02bd, $02bd
	dwbe $02f8, $027e
	dwbe $032d, $0239
	dwbe $035b, $01f0
	dwbe $0383, $01a3
	dwbe $03a4, $0153
	dwbe $03be, $0101
	dwbe $03d1, $00ac
	dwbe $03dc, $0056
	dwbe $03e0, $0000

.speed18:
	dwbe $0000, $0400
	dwbe $0059, $03fc
	dwbe $00b2, $03f0
	dwbe $0109, $03dd
	dwbe $015e, $03c2
	dwbe $01b1, $03a0
	dwbe $0200, $0377
	dwbe $024b, $0347
	dwbe $0292, $0310
	dwbe $02d4, $02d4
	dwbe $0310, $0292
	dwbe $0347, $024b
	dwbe $0377, $0200
	dwbe $03a0, $01b1
	dwbe $03c2, $015e
	dwbe $03dd, $0109
	dwbe $03f0, $00b2
	dwbe $03fc, $0059
	dwbe $0400, $0000


HandleBonusStageTimer:
; Tick every 32 frames
	ldh  a, [hFrameCounter]                                         ; $198c
	and  $1f                                                        ; $198e
	ret  nz                                                         ; $1990

; Dec timer
	ld   a, [wBonusStageTimer]                                      ; $1991
	dec  a                                                          ; $1994
	ld   [wBonusStageTimer], a                                      ; $1995

; Have ball explode once timer == 0
	push af                                                         ; $1998
	call z, SetBallExplodingState                                   ; $1999
	pop  af                                                         ; $199c

; Start song once we're in the last 20 seconds
	cp   20                                                         ; $199d
	call z, StartSong7                                              ; $199f

DisplayBonusStageTimer:
	ld   hl, wOam+OSLOT_FLASHED_IN_GAME_TEXT                        ; $19a2
	ld   a, [wBonusStageTimer]                                      ; $19a5

; Timer 1s in C, 10s in B
	call CBAequAinBCDform                                           ; $19a8
	ld   c, a                                                       ; $19ab

; Display 10s
	ld   a, $80                                                     ; $19ac
	ld   [hl+], a                                                   ; $19ae
	ld   a, $90                                                     ; $19af
	ld   [hl+], a                                                   ; $19b1
	ld   a, b                                                       ; $19b2
	add  "0"                                                        ; $19b3
	ld   [hl+], a                                                   ; $19b5
	ld   a, $00                                                     ; $19b6
	ld   [hl+], a                                                   ; $19b8

; Display 1s
	ld   a, $80                                                     ; $19b9
	ld   [hl+], a                                                   ; $19bb
	ld   a, $98                                                     ; $19bc
	ld   [hl+], a                                                   ; $19be
	ld   a, c                                                       ; $19bf
	add  "0"                                                        ; $19c0
	ld   [hl+], a                                                   ; $19c2
	ld   a, $00                                                     ; $19c3
	ld   [hl+], a                                                   ; $19c5
	ret                                                             ; $19c6


SetBallExplodingState:
	ld   a, GS_BALL_EXPLODING                                       ; $19c7
	ldh  [hGameState], a                                            ; $19c9
	ret                                                             ; $19cb


InitBonusStageTimerDisplaysAndSong:
; Set initial timer for bonus stage
	call GetPointerToCurrBonusStageTimerAndPoints                   ; $19cc
	ld   a, [hl]                                                    ; $19cf
	ld   [wBonusStageTimer], a                                      ; $19d0

; Display time text oam, timer, start song, then wait
	call AddTimeOam                                                 ; $19d3
	call DisplayBonusStageTimer                                     ; $19d6

	call StartSong8                                                 ; $19d9

	ld   a, $20                                                     ; $19dc
	call WaitForAVBlankIntsHandled                                  ; $19de
	ret                                                             ; $19e1


GetPointerToCurrBonusStageTimerAndPoints:
; B = num bonus stages visited as a 0-idx, with a max of 3
	ld   a, [wNumBonusStagesVisited]                                ; $19e2
	dec  a                                                          ; $19e5
	cp   $03                                                        ; $19e6
	jr   c, :+                                                      ; $19e8
	ld   a, $03                                                     ; $19ea
:	ld   b, a                                                       ; $19ec

; Return HL pointing to the relevant 3-byte entry
	ld   e, $03                                                     ; $19ed
	call BCequBtimesE                                               ; $19ef
	ld   hl, BonusStageTimeAndPoints                                ; $19f2
	add  hl, bc                                                     ; $19f5
	ret                                                             ; $19f6


GameStateA_BonusStageComplete:
; Clear sound and jump if all bricks cleared
	call InitSound                                                  ; $19f7

	ldh  a, [hNumBricksInStage]                                     ; $19fa
	ld   b, a                                                       ; $19fc
	ldh  a, [hNumBricksInStage+1]                                   ; $19fd
	or   b                                                          ; $19ff
	jr   z, .allBricksCleared                                       ; $1a00

; Else play song 9 and wait
	call StartSong9                                                 ; $1a02
	ld   a, $80                                                     ; $1a05
	jp   WaitForAVBlankIntsHandled                                  ; $1a07

.allBricksCleared:
; Play a new song and wait $13f frames
	call StartSongA                                                 ; $1a0a
	ld   a, $ff                                                     ; $1a0d
	call WaitForAVBlankIntsHandled                                  ; $1a0f
	ld   a, $40                                                     ; $1a12
	call WaitForAVBlankIntsHandled                                  ; $1a14

	jp   .unnecessaryJp                                             ; $1a17

.unnecessaryJp:
; Text to accompany pts
	call DisplaySpecialBonusPts                                     ; $1a1a

; BC = extra points for bonus stage (big-endian)
	call GetPointerToCurrBonusStageTimerAndPoints                   ; $1a1d
	inc  hl                                                         ; $1a20
	ld   b, [hl]                                                    ; $1a21
	inc  hl                                                         ; $1a22
	ld   c, [hl]                                                    ; $1a23

; Display initial extra pts and wait
	push bc                                                         ; $1a24
	call AddBonusStageExtraPtsOam                                   ; $1a25
	ld   a, $80                                                     ; $1a28
	call WaitForAVBlankIntsHandled                                  ; $1a2a
	pop  bc                                                         ; $1a2d

.loopCountingDownPts:
; Return once pts in BC == 0
	ld   a, b                                                       ; $1a2e
	cp   $00                                                        ; $1a2f
	jr   nz, .dec10pts                                              ; $1a31

	ld   a, c                                                       ; $1a33
	cp   $00                                                        ; $1a34
	ret  z                                                          ; $1a36

; Once at the last 10 pts, count down each of them
	cp   10                                                         ; $1a37
	jr   c, .loopDecrementingLast10pts                              ; $1a39

.dec10pts:
rept 10
	dec  bc                                                         ; $1a3b
endr
	push bc                                                         ; $1a45

; Display dec'd pts
	call AddBonusStageExtraPtsOam                                   ; $1a46

; Add 10 to curr score
	ldh  a, [hCurrScore+1]                                          ; $1a49
	ld   h, a                                                       ; $1a4b
	ldh  a, [hCurrScore]                                            ; $1a4c
	ld   l, a                                                       ; $1a4e

	ld   b, $00                                                     ; $1a4f
	ld   c, 10                                                      ; $1a51
	add  hl, bc                                                     ; $1a53

	ld   a, h                                                       ; $1a54
	ldh  [hCurrScore+1], a                                          ; $1a55
	ld   a, l                                                       ; $1a57
	ldh  [hCurrScore], a                                            ; $1a58

; Process curr score updating
	call UpdateTopScoreIfBeaten                                     ; $1a5a
	call CheckIfPastScoreThresholdForMoreLives                      ; $1a5d
	call AddInGameTopAndCurrScoreOam                                ; $1a60

; Play sound, then continue next frame
	call StartSquareEffect8                                         ; $1a63
	call WaitForVBlankIntHandled                                    ; $1a66

	pop  bc                                                         ; $1a69
	jr   .loopCountingDownPts                                       ; $1a6a

.loopDecrementingLast10pts:
; Dec pt and update extra pts oam
	dec  bc                                                         ; $1a6c
	push bc                                                         ; $1a6d
	call AddBonusStageExtraPtsOam                                   ; $1a6e

; Add 1 to curr score
	ldh  a, [hCurrScore+1]                                          ; $1a71
	ld   h, a                                                       ; $1a73
	ldh  a, [hCurrScore]                                            ; $1a74
	ld   l, a                                                       ; $1a76

	ld   b, $00                                                     ; $1a77
	ld   c, $01                                                     ; $1a79
	add  hl, bc                                                     ; $1a7b

	ld   a, h                                                       ; $1a7c
	ldh  [hCurrScore+1], a                                          ; $1a7d
	ld   a, l                                                       ; $1a7f
	ldh  [hCurrScore], a                                            ; $1a80

; Process curr score updating
	call UpdateTopScoreIfBeaten                                     ; $1a82
	call CheckIfPastScoreThresholdForMoreLives                      ; $1a85
	call AddInGameTopAndCurrScoreOam                                ; $1a88

; Play sound,t hen continue next frame
	call StartSquareEffect8                                         ; $1a8b
	call WaitForVBlankIntHandled                                    ; $1a8e

; End once last pt done
	pop  bc                                                         ; $1a91
	ld   a, b                                                       ; $1a92
	or   c                                                          ; $1a93
	jr   nz, .loopDecrementingLast10pts                             ; $1a94

	ret                                                             ; $1a96


DisplaySpecialBonusPts:
	call WaitUntilNoCompressedLevelChanges                          ; $1a97

; Copy below compressed changes
	ld   hl, .compressedSpecialBonusPts                             ; $1a9a
	ld   de, wCompressedLevelChanges                                ; $1a9d
	ld   b, .end-.compressedSpecialBonusPts                         ; $1aa0

.loop:
	ld   a, [hl+]                                                   ; $1aa2
	ld   [de], a                                                    ; $1aa3
	inc  de                                                         ; $1aa4
	dec  b                                                          ; $1aa5
	jr   nz, .loop                                                  ; $1aa6

; Wait until its processed
	ld   a, $01                                                     ; $1aa8
	ldh  [hPendingCompressedLevelChanges], a                        ; $1aaa
	jp   WaitForVBlankIntHandled                                    ; $1aac

.compressedSpecialBonusPts:
; SPECIAL BONUS
	dwbe (_SCRN0+$342)
	db $0c
	db $c4, $c5, $c6, $c7, "A", $c8, TILE_BLANK, "BONUS"

; PTS
	dwbe (_SCRN0+$369)
	db $04
	db "PTS."
	db $00
.end:


ClearSpecialBonusPts:
	call WaitUntilNoCompressedLevelChanges                          ; $1ac6

; Copy below compressed changes
	ld   hl, .compressedClearedTiles                                ; $1ac9
	ld   de, wCompressedLevelChanges                                ; $1acc
	ld   b, .end-.compressedClearedTiles                            ; $1acf

.loop:
	ld   a, [hl+]                                                   ; $1ad1
	ld   [de], a                                                    ; $1ad2
	inc  de                                                         ; $1ad3
	dec  b                                                          ; $1ad4
	jr   nz, .loop                                                  ; $1ad5

; Wait until its processed
	ld   a, $01                                                     ; $1ad7
	ldh  [hPendingCompressedLevelChanges], a                        ; $1ad9
	jp   WaitForVBlankIntHandled                                    ; $1adb

.compressedClearedTiles:
	dwbe (_SCRN0+$342)
	db $0c
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

	dwbe (_SCRN0+$369)
	db $04
	db $ff, $ff, $ff, $ff
	db $00
.end:


DisplayTryAgain:
	call WaitUntilNoCompressedLevelChanges                          ; $1af5

; Copy below compressed changes
	ld   hl, .compressedTryAgain                                    ; $1af8
	ld   de, wCompressedLevelChanges                                ; $1afb
	ld   b, .end-.compressedTryAgain                                ; $1afe

.loop:
	ld   a, [hl+]                                                   ; $1b00
	ld   [de], a                                                    ; $1b01
	inc  de                                                         ; $1b02
	dec  b                                                          ; $1b03
	jr   nz, .loop                                                  ; $1b04

; Wait until its processed
	ld   a, $01                                                     ; $1b06
	ldh  [hPendingCompressedLevelChanges], a                        ; $1b08
	jp   WaitForVBlankIntHandled                                    ; $1b0a

.compressedTryAgain:
	dwbe (_SCRN0+$1c3)
	db $0a
	db "TRY", TILE_BLANK, "AGAIN!"
	db $00
.end:


ClearTryAgain:
	call WaitUntilNoCompressedLevelChanges                          ; $1b1b

; Copy below compressed changes
	ld   hl, .compressedClearedTiles                                ; $1b1e
	ld   de, wCompressedLevelChanges                                ; $1b21
	ld   b, .end-.compressedClearedTiles                            ; $1b24

.loop:
	ld   a, [hl+]                                                   ; $1b26
	ld   [de], a                                                    ; $1b27
	inc  de                                                         ; $1b28
	dec  b                                                          ; $1b29
	jr   nz, .loop                                                  ; $1b2a

; Wait until its processed
	ld   a, $01                                                     ; $1b2c
	ldh  [hPendingCompressedLevelChanges], a                        ; $1b2e
	jp   WaitForVBlankIntHandled                                    ; $1b30

.compressedClearedTiles:
	dwbe (_SCRN0+$1c3)
	db $0a
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	db $00
.end:


AnglesWhenHittingLongPaddle:
	db $03, $06, $06, $06, $09, $09, $09, $09
	db $09, $09, $09, $09, $06, $06, $06, $03


AnglesWhenHittingShortPaddle:
	db $03, $06, $06, $09, $09, $09, $09, $09
	db $09, $06, $06, $03


ScoreThresholdsForMoreLives:
	dwbe 1000
	dwbe 2000
	dwbe 3000
	dwbe 4000
	dwbe 5000
	dwbe 6000
	dwbe 7000
	dwbe 8000
	dwbe 9000
	dw $ffff
	

BonusStageTimeAndPoints:
	dbwbe 95, 500
	dbwbe 90, 700
	dbwbe 85, 1000
	dbwbe 80, 1500

	
LayoutFallingSpeeds:
	db $08, $08, $05, $05, $03
	db $03, $02, $02, $02, $02
.end:


; 1) Top half-only tile
; 2) Bottom half-only tile
; 3) Both halves filled tile
; 4) High-nybble: score added when hit, low nybble: breakable flag
; 5) If non-0, ball speed when the brick is hit
; 6) Idx used to determine sound played
BricksMetadata::
	db $ab, $ae, $a8, $11, $00, $01
	db $ac, $af, $a9, $21, $05, $02
	db $ad, $b0, $aa, $31, $07, $03
	db $00, $00, $b3, $10, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00
	db $00, $00, $00, $11, $00, $00


; Bit 7 set - is bonus level
; Bit 6 set - is x scrolling level
; Bit 5-0 - scrolling speeds idx
LevelLayouts:
	dbw $00, Layout_1c44
	dbw $40, Layout_1c44
	dbw $00, Layout_23f4
	dbw $80, Layout_357c
	dbw $02, Layout_1d09
	dbw $41, Layout_1d09
	dbw $00, Layout_2625
	dbw $80, Layout_3695
	dbw $00, Layout_1dce
	dbw $42, Layout_1dce
	dbw $00, Layout_2856
	dbw $80, Layout_37ae
	dbw $00, Layout_1ee7
	dbw $43, Layout_1ee7
	dbw $00, Layout_2a87
	dbw $80, Layout_38c7
	dbw $00, Layout_1fc8
	dbw $44, Layout_1fc8
	dbw $00, Layout_2cb8
	dbw $80, Layout_39e0
	dbw $00, Layout_20c5
	dbw $45, Layout_20c5
	dbw $00, Layout_2ee9
	dbw $80, Layout_3af9
	dbw $00, Layout_21de
	dbw $46, Layout_21de
	dbw $00, Layout_311a
	dbw $80, Layout_3c12
	dbw $00, Layout_22f7
	dbw $47, Layout_22f7
	dbw $00, Layout_334b
	dbw $80, Layout_3d2b
	dbw $00, Layout_1c44


Layout_1c44:
	db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $00
	db $00, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $00
	db $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00
	db $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $ff


Layout_1d09:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $ff


Layout_1dce:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00
	db $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00
	db $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03
	db $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
	db $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $ff


Layout_1ee7:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $04, $03, $03, $03, $03, $04, $03, $03, $03, $03
	db $03, $03, $03, $03, $04, $03, $03, $03, $03, $04, $03, $03, $03, $03
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $02, $02, $02, $02, $04, $02, $02, $02, $02, $04, $02, $02, $02, $02
	db $02, $02, $02, $02, $04, $02, $02, $02, $02, $04, $02, $02, $02, $02
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $01, $01, $01, $01, $04, $01, $01, $01, $01, $04, $01, $01, $01, $01
	db $01, $01, $01, $01, $04, $01, $01, $01, $01, $04, $01, $01, $01, $01
	db $01, $01, $01, $01, $04, $01, $01, $01, $01, $04, $01, $01, $01, $01
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $ff


Layout_1fc8:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $00, $00, $00, $00, $00, $03, $03, $00, $00, $00, $00, $00, $03
	db $03, $03, $00, $00, $00, $03, $03, $03, $03, $00, $00, $00, $03, $03
	db $00, $03, $03, $00, $03, $03, $00, $00, $03, $03, $00, $03, $03, $00
	db $00, $00, $03, $03, $03, $00, $00, $00, $00, $03, $03, $03, $00, $00
	db $00, $00, $00, $03, $00, $00, $00, $00, $00, $00, $03, $00, $00, $00
	db $02, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $02
	db $02, $02, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $02
	db $00, $02, $02, $00, $02, $02, $00, $00, $02, $02, $00, $02, $02, $00
	db $00, $00, $02, $02, $02, $00, $00, $00, $00, $02, $02, $02, $00, $00
	db $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $00, $00, $00
	db $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $01
	db $01, $01, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01
	db $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $00, $01, $01, $01
	db $00, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $00
	db $00, $00, $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00
	db $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00
	db $ff


Layout_20c5:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00
	db $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00
	db $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00
	db $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00
	db $00, $00, $00, $01, $01, $03, $01, $01, $03, $03, $03, $03, $00, $00
	db $00, $00, $00, $01, $01, $03, $01, $01, $03, $03, $03, $03, $00, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $03, $01, $01, $03, $03, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $03, $01, $01, $03, $03, $00
	db $00, $01, $01, $01, $01, $03, $01, $03, $03, $01, $01, $03, $03, $00
	db $00, $01, $01, $01, $01, $03, $01, $03, $03, $01, $01, $03, $03, $00
	db $00, $00, $03, $03, $03, $03, $03, $01, $01, $01, $03, $03, $03, $00
	db $00, $00, $03, $03, $03, $03, $03, $01, $01, $01, $03, $03, $03, $00
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $03, $03, $03, $00, $00
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $03, $03, $03, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $04, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $04
	db $04, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $04
	db $ff


Layout_21de:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $04, $04, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $04, $04
	db $04, $04, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $04, $04
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $ff


Layout_22f7:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $02, $02, $02, $04, $04, $04, $02, $02, $04, $04, $04, $02, $02, $02
	db $02, $02, $02, $04, $04, $04, $02, $02, $04, $04, $04, $02, $02, $02
	db $02, $02, $04, $04, $02, $02, $02, $02, $02, $02, $04, $04, $02, $02
	db $02, $02, $04, $04, $02, $02, $02, $02, $02, $02, $04, $04, $02, $02
	db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $00
	db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $00
	db $01, $01, $04, $01, $01, $01, $01, $01, $01, $01, $01, $04, $01, $01
	db $01, $01, $04, $01, $01, $01, $01, $01, $01, $01, $01, $04, $01, $01
	db $01, $01, $04, $04, $01, $01, $01, $01, $01, $01, $04, $04, $01, $01
	db $01, $01, $04, $04, $01, $01, $01, $01, $01, $01, $04, $04, $01, $01
	db $00, $00, $00, $04, $04, $04, $00, $00, $04, $04, $04, $00, $00, $00
	db $00, $00, $00, $04, $04, $04, $00, $00, $04, $04, $04, $00, $00, $00
	db $ff


Layout_23f4:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $00
	db $00, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $00
	db $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00
	db $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $ff


Layout_2625:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $ff


Layout_2856:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00
	db $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00
	db $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03
	db $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
	db $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03
	db $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03
	db $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00
	db $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00
	db $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
	db $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00
	db $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
	db $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01
	db $ff


Layout_2a87:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $04, $03, $03, $03, $03, $04, $03, $03, $03, $03
	db $03, $03, $03, $03, $04, $03, $03, $03, $03, $04, $03, $03, $03, $03
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $02, $02, $02, $02, $04, $02, $02, $02, $02, $04, $02, $02, $02, $02
	db $02, $02, $02, $02, $04, $02, $02, $02, $02, $04, $02, $02, $02, $02
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $01, $01, $01, $01, $04, $01, $01, $01, $01, $04, $01, $01, $01, $01
	db $01, $01, $01, $01, $04, $01, $01, $01, $01, $04, $01, $01, $01, $01
	db $01, $01, $01, $01, $04, $01, $01, $01, $01, $04, $01, $01, $01, $01
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $04, $03, $03, $03, $03, $04, $03, $03, $03, $03
	db $03, $03, $03, $03, $04, $03, $03, $03, $03, $04, $03, $03, $03, $03
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $02, $02, $02, $02, $04, $02, $02, $02, $02, $04, $02, $02, $02, $02
	db $02, $02, $02, $02, $04, $02, $02, $02, $02, $04, $02, $02, $02, $02
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $01, $01, $01, $01, $04, $01, $01, $01, $01, $04, $01, $01, $01, $01
	db $01, $01, $01, $01, $04, $01, $01, $01, $01, $04, $01, $01, $01, $01
	db $01, $01, $01, $01, $04, $01, $01, $01, $01, $04, $01, $01, $01, $01
	db $00, $00, $00, $00, $04, $00, $00, $00, $00, $04, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $ff


Layout_2cb8:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $00, $00, $00, $00, $00, $03, $03, $00, $00, $00, $00, $00, $03
	db $03, $03, $00, $00, $00, $03, $03, $03, $03, $00, $00, $00, $03, $03
	db $00, $03, $03, $00, $03, $03, $00, $00, $03, $03, $00, $03, $03, $00
	db $00, $00, $03, $03, $03, $00, $00, $00, $00, $03, $03, $03, $00, $00
	db $00, $00, $00, $03, $00, $00, $00, $00, $00, $00, $03, $00, $00, $00
	db $02, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $02
	db $02, $02, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $02
	db $00, $02, $02, $00, $02, $02, $00, $00, $02, $02, $00, $02, $02, $00
	db $00, $00, $02, $02, $02, $00, $00, $00, $00, $02, $02, $02, $00, $00
	db $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $00, $00, $00
	db $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $01
	db $01, $01, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01
	db $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $00, $01, $01, $01
	db $00, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $00
	db $00, $00, $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00
	db $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $00, $00, $00, $00, $00, $03, $03, $00, $00, $00, $00, $00, $03
	db $03, $03, $00, $00, $00, $03, $03, $03, $03, $00, $00, $00, $03, $03
	db $00, $03, $03, $00, $03, $03, $00, $00, $03, $03, $00, $03, $03, $00
	db $00, $00, $03, $03, $03, $00, $00, $00, $00, $03, $03, $03, $00, $00
	db $00, $00, $00, $03, $00, $00, $00, $00, $00, $00, $03, $00, $00, $00
	db $02, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $02
	db $02, $02, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $02
	db $00, $02, $02, $00, $02, $02, $00, $00, $02, $02, $00, $02, $02, $00
	db $00, $00, $02, $02, $02, $00, $00, $00, $00, $02, $02, $02, $00, $00
	db $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $02, $00, $00, $00
	db $01, $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $01
	db $01, $01, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $01, $01
	db $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $00, $01, $01, $01
	db $00, $01, $01, $01, $01, $01, $00, $00, $01, $01, $01, $01, $01, $00
	db $00, $00, $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00
	db $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $ff


Layout_2ee9:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00
	db $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00
	db $00, $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00
	db $00, $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00
	db $00, $00, $03, $03, $03, $03, $01, $01, $03, $01, $01, $00, $00, $00
	db $00, $00, $03, $03, $03, $03, $01, $01, $03, $01, $01, $00, $00, $00
	db $00, $03, $03, $01, $01, $03, $01, $01, $01, $01, $01, $01, $01, $00
	db $00, $03, $03, $01, $01, $03, $01, $01, $01, $01, $01, $01, $01, $00
	db $00, $03, $03, $01, $01, $03, $03, $01, $03, $01, $01, $01, $01, $00
	db $00, $03, $03, $01, $01, $03, $03, $01, $03, $01, $01, $01, $01, $00
	db $00, $03, $03, $03, $01, $01, $01, $03, $03, $03, $03, $03, $00, $00
	db $00, $03, $03, $03, $01, $01, $01, $03, $03, $03, $03, $03, $00, $00
	db $00, $00, $03, $03, $03, $01, $01, $01, $01, $01, $01, $00, $00, $00
	db $00, $00, $03, $03, $03, $01, $01, $01, $01, $01, $01, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $04, $04, $04, $04, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $04, $04, $04, $04, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00
	db $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00
	db $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00
	db $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00
	db $00, $00, $00, $01, $01, $03, $01, $01, $03, $03, $03, $03, $00, $00
	db $00, $00, $00, $01, $01, $03, $01, $01, $03, $03, $03, $03, $00, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $03, $01, $01, $03, $03, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $03, $01, $01, $03, $03, $00
	db $00, $01, $01, $01, $01, $03, $01, $03, $03, $01, $01, $03, $03, $00
	db $00, $01, $01, $01, $01, $03, $01, $03, $03, $01, $01, $03, $03, $00
	db $00, $00, $03, $03, $03, $03, $03, $01, $01, $01, $03, $03, $03, $00
	db $00, $00, $03, $03, $03, $03, $03, $01, $01, $01, $03, $03, $03, $00
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $03, $03, $03, $00, $00
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $03, $03, $03, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $04, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $04
	db $04, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $04
	db $ff


Layout_311a:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $04, $04, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $04, $04
	db $04, $04, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $04, $04
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00
	db $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $04, $04, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $04, $04
	db $04, $04, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $04, $04
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $ff


Layout_334b:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $04, $04, $04, $03, $03, $03, $03, $04, $04, $04, $03, $03
	db $03, $03, $04, $04, $04, $03, $03, $03, $03, $04, $04, $04, $03, $03
	db $00, $00, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $00, $00
	db $00, $00, $00, $00, $04, $04, $00, $00, $04, $04, $00, $00, $00, $00
	db $02, $02, $02, $02, $02, $04, $02, $02, $04, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $04, $02, $02, $04, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $04, $02, $02, $04, $02, $02, $02, $02, $02
	db $02, $02, $02, $02, $02, $04, $02, $02, $04, $02, $02, $02, $02, $02
	db $00, $00, $00, $00, $00, $04, $00, $00, $04, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $04, $00, $00, $04, $00, $00, $00, $00, $00
	db $01, $01, $01, $01, $04, $04, $01, $01, $04, $04, $01, $01, $01, $01
	db $01, $01, $01, $01, $04, $04, $01, $01, $04, $04, $01, $01, $01, $01
	db $01, $01, $04, $04, $04, $01, $01, $01, $01, $04, $04, $04, $01, $01
	db $01, $01, $04, $04, $04, $01, $01, $01, $01, $04, $04, $04, $01, $01
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
	db $02, $02, $02, $04, $04, $04, $02, $02, $04, $04, $04, $02, $02, $02
	db $02, $02, $02, $04, $04, $04, $02, $02, $04, $04, $04, $02, $02, $02
	db $02, $02, $04, $04, $02, $02, $02, $02, $02, $02, $04, $04, $02, $02
	db $02, $02, $04, $04, $02, $02, $02, $02, $02, $02, $04, $04, $02, $02
	db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $00
	db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $00
	db $01, $01, $04, $01, $01, $01, $01, $01, $01, $01, $01, $04, $01, $01
	db $01, $01, $04, $01, $01, $01, $01, $01, $01, $01, $01, $04, $01, $01
	db $01, $01, $04, $04, $01, $01, $01, $01, $01, $01, $04, $04, $01, $01
	db $01, $01, $04, $04, $01, $01, $01, $01, $01, $01, $04, $04, $01, $01
	db $00, $00, $00, $04, $04, $04, $00, $00, $04, $04, $04, $00, $00, $00
	db $00, $00, $00, $04, $04, $04, $00, $00, $04, $04, $04, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $ff


Layout_357c:
	db $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00
	db $00, $00, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00
	db $00, $00, $00, $00, $01, $03, $01, $03, $03, $03, $00, $00, $00, $00
	db $00, $00, $00, $01, $01, $03, $01, $03, $03, $03, $03, $00, $00, $00
	db $00, $00, $01, $01, $01, $01, $01, $03, $01, $03, $03, $00, $00, $00
	db $00, $00, $01, $01, $01, $01, $01, $03, $01, $03, $03, $00, $00, $00
	db $00, $00, $03, $03, $03, $03, $03, $01, $01, $03, $03, $00, $00, $00
	db $00, $00, $00, $03, $03, $03, $03, $01, $01, $03, $00, $00, $00, $00
	db $00, $00, $00, $01, $01, $01, $01, $01, $03, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $02, $03, $02, $02, $03, $02, $02, $00, $00, $00, $00
	db $00, $00, $02, $02, $03, $02, $02, $03, $02, $02, $02, $00, $00, $00
	db $00, $01, $01, $03, $01, $03, $03, $01, $03, $02, $01, $01, $00, $00
	db $00, $01, $01, $03, $01, $03, $03, $01, $03, $02, $01, $01, $00, $00
	db $00, $01, $03, $03, $03, $03, $03, $03, $03, $03, $01, $01, $00, $00
	db $00, $01, $03, $03, $03, $03, $03, $03, $03, $03, $01, $01, $00, $00
	db $00, $00, $03, $03, $03, $03, $00, $03, $03, $03, $03, $00, $00, $00
	db $00, $00, $03, $03, $03, $00, $00, $00, $03, $03, $03, $00, $00, $00
	db $00, $02, $02, $02, $02, $00, $00, $00, $02, $02, $02, $02, $00, $00
	db $00, $02, $02, $02, $02, $00, $00, $00, $02, $02, $02, $02, $00, $00
	db $ff


Layout_3695:
	db $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $03, $01, $02, $00, $00, $00, $03, $03, $03, $00, $00, $00, $00
	db $02, $03, $01, $02, $00, $00, $03, $03, $03, $03, $03, $00, $00, $00
	db $02, $01, $01, $02, $02, $00, $03, $01, $03, $03, $03, $00, $00, $00
	db $02, $01, $01, $02, $02, $03, $03, $01, $03, $03, $03, $03, $00, $00
	db $02, $02, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03, $00, $00
	db $02, $00, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03, $00, $00
	db $02, $00, $02, $02, $00, $03, $03, $03, $03, $03, $03, $03, $00, $00
	db $00, $00, $02, $02, $00, $03, $03, $03, $03, $03, $03, $03, $00, $00
	db $00, $02, $02, $02, $01, $03, $03, $03, $03, $03, $03, $03, $00, $00
	db $00, $02, $00, $02, $01, $03, $03, $03, $03, $03, $03, $03, $00, $00
	db $00, $00, $00, $02, $02, $01, $03, $03, $03, $03, $03, $01, $00, $00
	db $00, $00, $00, $00, $02, $01, $03, $03, $03, $03, $03, $01, $02, $00
	db $00, $00, $00, $00, $00, $02, $01, $01, $01, $01, $01, $00, $02, $00
	db $00, $00, $00, $00, $00, $02, $01, $01, $01, $01, $01, $00, $00, $02
	db $00, $00, $00, $00, $02, $02, $02, $00, $00, $02, $02, $02, $00, $00
	db $00, $00, $00, $02, $02, $02, $02, $00, $00, $02, $02, $02, $00, $00
	db $00, $00, $01, $02, $02, $02, $00, $00, $00, $00, $02, $02, $01, $00
	db $00, $00, $01, $02, $02, $00, $00, $00, $00, $00, $02, $02, $01, $00
	db $ff


Layout_37ae:
	db $00, $00, $00, $00, $00, $00, $01, $02, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $01, $01, $02, $02, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $01, $01, $01, $01, $01, $02, $00, $00, $00, $00
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $02, $02, $00, $00, $00
	db $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $00, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $00
	db $00, $01, $01, $02, $02, $03, $02, $02, $03, $02, $02, $02, $02, $00
	db $00, $00, $00, $02, $02, $03, $02, $02, $03, $02, $02, $00, $00, $00
	db $00, $00, $00, $01, $03, $00, $03, $03, $00, $03, $02, $00, $00, $00
	db $00, $00, $00, $01, $03, $00, $03, $03, $00, $03, $02, $00, $00, $00
	db $00, $00, $00, $01, $01, $03, $01, $01, $03, $01, $02, $00, $00, $00
	db $00, $00, $01, $01, $01, $03, $01, $01, $03, $01, $02, $02, $00, $00
	db $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00
	db $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $00
	db $00, $01, $02, $02, $01, $02, $02, $02, $01, $01, $02, $01, $02, $00
	db $00, $01, $02, $00, $01, $02, $02, $02, $01, $01, $02, $01, $02, $00
	db $00, $01, $02, $00, $01, $02, $00, $00, $01, $02, $00, $01, $02, $00
	db $00, $01, $02, $00, $01, $02, $00, $00, $01, $02, $00, $01, $02, $00
	db $00, $00, $01, $00, $00, $01, $01, $00, $01, $02, $00, $01, $02, $00
	db $00, $00, $01, $01, $00, $00, $00, $01, $01, $00, $01, $01, $00, $00
	db $ff


Layout_38c7:
	db $00, $00, $00, $02, $01, $00, $00, $00, $01, $02, $00, $00, $00, $00
	db $00, $00, $03, $02, $00, $00, $00, $00, $00, $02, $03, $00, $00, $00
	db $00, $01, $03, $03, $02, $00, $00, $01, $02, $01, $03, $00, $00, $00
	db $00, $01, $03, $03, $02, $00, $00, $00, $02, $01, $03, $00, $00, $00
	db $00, $00, $03, $03, $02, $01, $00, $00, $02, $03, $03, $01, $00, $00
	db $00, $00, $03, $03, $02, $00, $00, $00, $02, $03, $03, $01, $00, $00
	db $00, $01, $03, $01, $03, $02, $00, $02, $03, $03, $01, $00, $00, $00
	db $00, $01, $03, $01, $03, $02, $00, $02, $03, $03, $01, $00, $00, $00
	db $00, $00, $03, $03, $03, $02, $01, $02, $01, $03, $03, $00, $00, $00
	db $00, $00, $00, $03, $03, $02, $00, $02, $01, $03, $00, $00, $00, $00
	db $00, $00, $00, $03, $01, $03, $02, $03, $03, $03, $01, $00, $00, $00
	db $00, $00, $00, $00, $01, $03, $02, $03, $03, $00, $01, $00, $00, $00
	db $00, $00, $00, $00, $00, $03, $01, $03, $00, $00, $00, $00, $00, $00
	db $00, $02, $02, $00, $00, $00, $01, $00, $00, $00, $02, $02, $00, $00
	db $00, $02, $02, $02, $00, $00, $01, $00, $00, $02, $02, $02, $02, $00
	db $00, $02, $02, $02, $02, $00, $01, $00, $02, $02, $02, $02, $02, $00
	db $00, $02, $02, $02, $02, $00, $01, $00, $02, $02, $02, $02, $02, $00
	db $00, $00, $02, $02, $02, $02, $01, $02, $02, $02, $02, $02, $00, $00
	db $00, $00, $00, $02, $02, $02, $01, $02, $02, $02, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $02, $01, $02, $00, $00, $00, $00, $00, $00
	db $ff


Layout_39e0:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $03, $03, $03, $03, $03, $03, $00, $03, $00
	db $00, $00, $00, $00, $03, $03, $03, $03, $03, $03, $03, $00, $03, $00
	db $00, $00, $00, $03, $01, $03, $03, $01, $01, $01, $03, $02, $01, $00
	db $00, $00, $03, $03, $01, $03, $03, $01, $01, $01, $03, $02, $01, $00
	db $00, $00, $03, $01, $01, $03, $01, $03, $03, $03, $03, $01, $03, $00
	db $00, $03, $03, $01, $01, $03, $01, $03, $03, $03, $03, $01, $03, $00
	db $00, $03, $01, $03, $01, $03, $03, $03, $03, $03, $03, $02, $03, $00
	db $00, $03, $01, $03, $01, $03, $03, $03, $03, $03, $03, $02, $03, $00
	db $00, $03, $03, $01, $03, $03, $03, $03, $02, $02, $03, $02, $03, $00
	db $00, $03, $03, $01, $03, $03, $03, $03, $02, $02, $03, $02, $03, $00
	db $00, $03, $03, $03, $03, $01, $01, $03, $01, $03, $03, $02, $03, $00
	db $00, $03, $03, $03, $03, $01, $01, $03, $01, $03, $03, $02, $03, $00
	db $00, $03, $03, $03, $01, $01, $01, $01, $01, $03, $03, $02, $03, $00
	db $00, $00, $03, $03, $01, $01, $01, $01, $01, $03, $03, $02, $03, $00
	db $00, $00, $03, $03, $03, $01, $01, $03, $03, $03, $03, $02, $03, $00
	db $00, $00, $00, $03, $03, $01, $01, $03, $03, $03, $03, $02, $03, $00
	db $00, $00, $00, $03, $03, $03, $03, $03, $03, $03, $03, $00, $03, $00
	db $00, $00, $00, $00, $03, $03, $03, $03, $03, $03, $03, $00, $03, $00
	db $ff


Layout_3af9:
	db $00, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $00, $00
	db $00, $00, $03, $03, $03, $02, $02, $02, $02, $03, $03, $03, $00, $00
	db $00, $00, $00, $03, $03, $02, $02, $02, $02, $03, $03, $00, $00, $00
	db $00, $00, $00, $01, $01, $03, $02, $02, $03, $01, $01, $00, $00, $00
	db $00, $00, $02, $01, $01, $03, $02, $02, $03, $01, $01, $02, $00, $00
	db $00, $00, $02, $01, $01, $03, $01, $01, $03, $01, $01, $02, $00, $00
	db $00, $02, $02, $01, $01, $03, $01, $01, $03, $01, $01, $02, $02, $00
	db $00, $02, $02, $02, $01, $01, $02, $02, $01, $01, $02, $02, $02, $00
	db $00, $02, $02, $02, $01, $01, $02, $02, $01, $01, $02, $02, $02, $00
	db $00, $02, $02, $02, $02, $03, $03, $03, $03, $02, $02, $02, $02, $00
	db $00, $02, $02, $02, $02, $03, $03, $03, $03, $02, $02, $02, $02, $00
	db $00, $02, $02, $01, $03, $02, $02, $02, $02, $03, $01, $02, $02, $00
	db $00, $00, $02, $01, $03, $02, $02, $02, $02, $03, $01, $02, $00, $00
	db $00, $00, $00, $02, $02, $01, $01, $01, $01, $02, $02, $00, $00, $00
	db $00, $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00
	db $00, $00, $00, $03, $03, $01, $01, $01, $01, $03, $03, $00, $00, $00
	db $00, $00, $00, $03, $03, $01, $01, $01, $01, $03, $03, $00, $00, $00
	db $00, $00, $03, $03, $00, $01, $01, $01, $01, $00, $03, $03, $00, $00
	db $00, $00, $03, $03, $00, $00, $01, $01, $00, $00, $03, $03, $00, $00
	db $ff


Layout_3c12:
	db $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $03, $03, $03, $03, $00, $00, $00, $01, $01, $00, $00
	db $00, $00, $03, $03, $03, $03, $03, $03, $00, $00, $01, $01, $01, $00
	db $00, $03, $01, $03, $01, $01, $03, $03, $03, $01, $01, $01, $01, $00
	db $00, $03, $01, $03, $01, $01, $03, $03, $03, $01, $01, $01, $01, $00
	db $00, $01, $03, $01, $03, $01, $01, $03, $03, $01, $01, $01, $01, $00
	db $00, $01, $03, $01, $03, $01, $01, $03, $03, $01, $01, $01, $01, $00
	db $00, $01, $03, $01, $03, $01, $01, $03, $01, $01, $01, $01, $01, $00
	db $00, $01, $03, $01, $03, $01, $01, $03, $01, $01, $01, $01, $00, $00
	db $00, $03, $01, $03, $01, $01, $03, $03, $01, $01, $01, $00, $00, $00
	db $00, $03, $01, $03, $01, $01, $03, $03, $01, $01, $01, $00, $00, $00
	db $02, $02, $02, $02, $03, $03, $03, $03, $01, $03, $03, $00, $01, $00
	db $00, $02, $02, $02, $03, $03, $03, $03, $01, $03, $03, $03, $01, $00
	db $00, $00, $03, $03, $02, $01, $01, $03, $03, $03, $03, $03, $01, $00
	db $00, $00, $00, $03, $02, $01, $01, $03, $03, $03, $03, $03, $01, $00
	db $00, $02, $02, $02, $01, $01, $01, $01, $01, $03, $03, $01, $01, $00
	db $00, $00, $02, $02, $01, $01, $01, $01, $01, $03, $00, $01, $00, $00
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $00, $01, $00, $00
	db $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00
	db $ff


Layout_3d2b:
	db $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $03, $02, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $03, $01, $02, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $03, $01, $02, $01, $02, $00, $00, $03, $00, $00, $00, $00, $00
	db $02, $01, $01, $02, $02, $02, $00, $03, $03, $03, $01, $00, $00, $00
	db $02, $01, $01, $02, $02, $02, $03, $03, $03, $03, $01, $00, $00, $00
	db $03, $03, $03, $03, $02, $01, $03, $03, $01, $03, $03, $03, $00, $00
	db $00, $00, $00, $03, $02, $01, $03, $03, $01, $03, $03, $03, $00, $00
	db $00, $00, $02, $03, $02, $01, $03, $03, $03, $03, $03, $01, $03, $00
	db $00, $02, $00, $03, $02, $01, $03, $03, $03, $03, $03, $01, $03, $00
	db $00, $00, $03, $03, $03, $01, $01, $01, $03, $01, $03, $03, $03, $01
	db $00, $03, $03, $00, $03, $01, $01, $01, $03, $01, $03, $03, $03, $01
	db $00, $00, $00, $00, $02, $02, $02, $01, $03, $03, $03, $01, $03, $00
	db $00, $00, $01, $02, $02, $02, $02, $01, $03, $03, $03, $01, $03, $00
	db $00, $00, $00, $02, $02, $02, $02, $01, $01, $01, $01, $01, $01, $01
	db $00, $00, $01, $02, $02, $02, $02, $01, $01, $01, $01, $01, $01, $01
	db $00, $00, $00, $02, $02, $00, $03, $03, $03, $03, $02, $02, $03, $02
	db $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $00, $02
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $02, $02, $02, $00
	db $ff


UnusedLayout_3e44:
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
