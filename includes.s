INCLUDE "include/hardware.inc"
INCLUDE "include/constants.s"
INCLUDE "include/structs.s"
INCLUDE "include/macros.s"

newcharmap cm

charmap "!", $1f
charmap " ", $3e
charmap "0", $80
charmap "A", $8a
charmap "B", $8b
charmap "E", $8e
charmap "G", $90
charmap "I", $92
charmap "M", $96
charmap "N", $97
charmap "O", $98
charmap "P", $99
charmap "R", $9b
charmap "S", $9c
charmap "T", $9d
charmap "U", $9e
charmap "V", $9f
charmap "Y", $a2
charmap ".", $b7
charmap "<mushroom>", $bc
charmap "<fireflower>", $bf
charmap "<star>", $c9

setcharmap cm