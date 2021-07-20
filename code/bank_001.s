; Disassembly of "OR"
; This file was created with:
; mgbdis v1.4 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

INCLUDE "includes.s"

SECTION "ROM Bank $001", ROMX[$4000], BANK[$1]

UnusedLayout_3e44_cont:
	db                                                   $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	db $ff


ScrollXSetups::
	dw .setup0
	dw .setup1
	dw .setup2
	dw .setup3
	dw .setup4
	dw .setup5
	dw .setup6
	dw .setup7
	dw .setup8
	dw .setup9
	dw .setupA
	dw .setupB

.setup0:
	db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04

.setup1:
	db $00, $00, $04, $04, $00, $00, $84, $84, $00, $00, $04, $04, $04, $04, $00, $00, $00, $00, $00, $00

.setup2:
	db $00, $00, $08, $08, $08, $08, $04, $04, $04, $04, $04, $04, $02, $02, $02, $02, $02, $02, $02, $02

.setup3:
	db $00, $00, $84, $84, $04, $04, $84, $84, $04, $04, $84, $84, $04, $04, $84, $84, $00, $00, $00, $00

.setup4:
	db $00, $00, $8f, $8f, $8f, $8f, $8f, $04, $04, $04, $04, $04, $0f, $0f, $0f, $0f, $0f, $0f, $00, $00

.setup5:
	db $00, $00, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $00, $00, $84, $84

.setup6:
	db $00, $00, $84, $84, $84, $84, $84, $84, $84, $84, $04, $04, $84, $84, $84, $84, $84, $84, $84, $84

.setup7:
	db $00, $00, $00, $00, $00, $00, $84, $84, $84, $84, $84, $84, $04, $04, $04, $04, $04, $04, $00, $00

.setup8:
	db $09, $09, $89, $89, $09, $09, $89, $89, $09, $09, $89, $89, $09, $09, $89, $89, $09, $09, $81, $81

.setup9:
	db $01, $01, $01, $01, $81, $01, $81, $01, $81, $01, $81, $01, $81, $01, $81, $01, $81, $01, $81, $01

.setupA:
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

.setupB:
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

.unusedSetupC:
	db $01, $81, $01, $81, $01, $81, $01, $81, $01, $81, $01, $81, $01, $81, $01, $81, $01, $81, $01, $81

.unusedSetupD:
	db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $13, $14

.unusedSetupE:
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

.unusedSetupF:
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	

DecompressedLayout_TitleScreen::
	db $98, $00, $14, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	db $aa, $aa, $aa, $aa, $aa, $aa, $aa, $98, $20, $14, $ac, $ac, $a9, $a9, $a9, $a9
	db $a9, $a9, $a9, $a9, $a9, $a9, $a9, $a9, $a9, $a9, $a9, $ac, $ac, $a9, $98, $40
	db $10, $ff, $ff, $ff, $ab, $ff, $a8, $ab, $a8, $a8, $ff, $ab, $a8, $a8, $ff, $a8
	db $ab, $98, $61, $02, $0e, $01, $98, $71, $02, $9d, $96, $98, $81, $11, $02, $03
	db $08, $ff, $08, $ff, $00, $15, $08, $08, $08, $08, $08, $0e, $01, $08, $08, $98
	db $a1, $11, $02, $03, $09, $ff, $09, $ff, $02, $16, $09, $09, $09, $09, $09, $02
	db $03, $09, $09, $98, $c1, $11, $02, $06, $09, $ff, $09, $ff, $02, $17, $04, $07
	db $09, $09, $09, $02, $06, $04, $07, $98, $e1, $11, $02, $03, $0a, $0b, $0a, $0b
	db $02, $0b, $ff, $09, $02, $a7, $06, $02, $03, $ff, $09, $99, $01, $11, $13, $14
	db $0c, $0d, $0c, $0d, $10, $0d, $08, $09, $0f, $12, $11, $13, $14, $08, $09, $99
	db $29, $02, $04, $05, $99, $30, $02, $04, $05, $99, $63, $09, $9d, $98, $99, $ff
	db $9c, $8c, $98, $9b, $8e, $99, $c3, $0e, $99, $9e, $9c, $91, $ff, $9c, $9d, $8a
	db $9b, $9d, $ff, $94, $8e, $a2, $9a, $04, $0c, $1e, $81, $89, $88, $89, $ff, $18
	db $19, $1a, $1b, $1c, $1d, $00


DecompressedLayout_NicePlay:
	db $98, $43, $0a, $97, $92, $8c, $8e, $ff, $99, $95, $8a, $a2, $1f, $98, $84, $07
	db $44, $45, $ff, $ff, $ff, $44, $45, $98, $a3, $09, $44, $46, $20, $21, $22, $23
	db $24, $44, $45, $98, $c2, $0b, $44, $45, $25, $26, $27, $28, $29, $2a, $2b, $44
	db $45, $98, $e2, $0b, $44, $45, $2c, $2d, $2e, $2f, $30, $31, $32, $44, $45, $99
	db $02, $0b, $44, $45, $33, $a5, $34, $35, $a5, $36, $37, $44, $45, $99, $22, $0b
	db $44, $45, $38, $39, $3a, $3b, $3c, $3d, $3e, $44, $45, $99, $43, $09, $44, $45
	db $3f, $40, $41, $42, $43, $44, $45, $99, $63, $09, $47, $48, $49, $4a, $4b, $4c
	db $4d, $4e, $4f, $99, $83, $09, $50, $51, $52, $53, $54, $55, $56, $57, $58, $00


UnusedLayout_4333:
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
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00
	db $ff


AnimateMarioRunningAndJumpingIntoPaddle::
; Display paddle and start song
	call UpdatePaddleOam                                            ; $43dc
	call StartSong2                                                 ; $43df

; Set initial mario coords, relative to the paddle
	ldh  a, [hPaddleX]                                              ; $43e2
	add  $50                                                        ; $43e4
	ld   [wMarioX], a                                               ; $43e6

	ldh  a, [hPaddleY]                                              ; $43e9
	sub  $10                                                        ; $43eb
	ld   [wMarioY], a                                               ; $43ed

; Animate Mario after 3 frames
	ld   a, $03                                                     ; $43f0
	ld   [wTimeUntilMarioAnimated], a                               ; $43f2

.moveMarioLeft:
; Animate Mario and update oam every frame
	call AnimateMarioMovingLeft                                     ; $43f5
	call UpdateMarioOam                                             ; $43f8

; Move Mario left until a certain point is reached
	ld   a, [wMarioX]                                               ; $43fb
	dec  a                                                          ; $43fe
	ld   [wMarioX], a                                               ; $43ff

	cp   $44                                                        ; $4402
	jr   nz, .moveMarioLeft                                         ; $4404

; After that point is reached, have Mario stand still
	ld   a, ANIM_MARIO_STILL                                        ; $4406
	ld   [wMarioAnimIdx], a                                         ; $4408
	call UpdateMarioOam                                             ; $440b

; Play sound effect and open paddle
	call StartSquareEffect9                                         ; $440e
	call AnimateOpeningPaddle                                       ; $4411

; Mario's sprite from here shows him jumping
	ld   a, ANIM_MARIO_JUMPING_HAPPY                                ; $4414
	ld   [wMarioAnimIdx], a                                         ; $4416

; Clear jump vars
	xor  a                                                          ; $4419
	ld   [wMarioJumpYdiffIdx], a                                    ; $441a
	ld   [wMarioIsMovingRight], a                                   ; $441d

; Until entire table of jump vals is done, process jump movement
.loopJump:
	call UpdateMarioOam                                             ; $4420
	call ProcessMarioJumping                                        ; $4423

	ld   a, [wMarioJumpYdiffIdx]                                    ; $4426
	cp   $18                                                        ; $4429
	jr   c, .loopJump                                               ; $442b

; Move Mario down until in paddle
.moveMarioDown:
	call UpdateMarioOam                                             ; $442d

	ld   a, [wMarioY]                                               ; $4430
	inc  a                                                          ; $4433
	inc  a                                                          ; $4434
	inc  a                                                          ; $4435
	inc  a                                                          ; $4436
	ld   [wMarioY], a                                               ; $4437
	
	cp   $88                                                        ; $443a
	jr   c, .moveMarioDown                                          ; $443c

; Hide Mario, wait, then animate closing paddle
	call ClearAnimatedOam                                           ; $443e

	ld   a, $10                                                     ; $4441
	call WaitForAVBlankIntsHandled                                  ; $4443

	call AnimateClosingPaddle                                       ; $4446
	call UpdatePaddleOam                                            ; $4449
	ret                                                             ; $444c


AnimateMarioFallingOffScreen::
; Lengthen paddle, play sound, then open paddle
	call ProcessPaddleLengthening                                   ; $444d
	call UpdatePaddleOam                                            ; $4450
	call StartSquareEffectA                                         ; $4453
	call AnimateOpeningPaddle                                       ; $4456

; Start Mario at paddle's height, with X centered on paddle
	ld   a, $88                                                     ; $4459
	ld   [wMarioY], a                                               ; $445b

	ldh  a, [hPaddleX]                                              ; $445e
	add  $04                                                        ; $4460
	ld   [wMarioX], a                                               ; $4462

; If paddle is on the right half of the screen, mario jumps left, facing left
	ld   b, $00                                                     ; $4465
	ld   c, ANIM_MARIO_JUMPING_LEFT_SAD                             ; $4467
	cp   $4c                                                        ; $4469
	jr   nc, :+                                                     ; $446b

; Else mario jumps right, facing right
	ld   b, $01                                                     ; $446d
	ld   c, ANIM_MARIO_JUMPING_RIGHT_SAD                            ; $446f

:	ld   a, b                                                       ; $4471
	ld   [wMarioIsMovingRight], a                                   ; $4472
	ld   a, c                                                       ; $4475
	ld   [wMarioAnimIdx], a                                         ; $4476

; Init idx into jump table
	xor  a                                                          ; $4479
	ld   [wMarioJumpYdiffIdx], a                                    ; $447a

.loopJump:
; Loop through table values to animate/move Mario
	call UpdateMarioOam                                             ; $447d
	call ProcessMarioJumping                                        ; $4480

; Exit when jump is finished
	ld   a, [wMarioJumpYdiffIdx]                                    ; $4483
	cp   $18                                                        ; $4486
	jr   c, .loopJump                                               ; $4488

; Add to Mario's Y to have him fall off screen
.loopFall:
	call UpdateMarioOam                                             ; $448a
	ld   a, [wMarioY]                                               ; $448d
	inc  a                                                          ; $4490
	inc  a                                                          ; $4491
	inc  a                                                          ; $4492
	inc  a                                                          ; $4493
	ld   [wMarioY], a                                               ; $4494
	cp   $a0                                                        ; $4497
	jr   c, .loopFall                                               ; $4499

; Then clear Mario's oam, and wait
	call ClearAnimatedOam                                           ; $449b
	
	ld   a, $40                                                     ; $449e
	call WaitForAVBlankIntsHandled                                  ; $44a0
	ret                                                             ; $44a3


AnimateMarioMovingLeft:
; Dec counter, returning if non-0
	ld   a, [wTimeUntilMarioAnimated]                               ; $44a4
	dec  a                                                          ; $44a7
	ld   [wTimeUntilMarioAnimated], a                               ; $44a8
	ret  nz                                                         ; $44ab

; Inc animation, looping 3->0
	ld   a, [wMarioAnimIdx]                                         ; $44ac
	inc  a                                                          ; $44af
	cp   ANIM_MARIO_RUNNING_END+1                                   ; $44b0
	jr   c, :+                                                      ; $44b2
	lda  ANIM_MARIO_RUNNING_START                                   ; $44b4
:	ld   [wMarioAnimIdx], a                                         ; $44b5

; Animate Mario again after 5 frames
	ld   a, $05                                                     ; $44b8
	ld   [wTimeUntilMarioAnimated], a                               ; $44ba
	ret                                                             ; $44bd


UpdateMarioOam:
; Get params to update Mario's oam, then wait for vblank
	ld   a, [wMarioX]                                               ; $44be
	ld   b, a                                                       ; $44c1
	ld   a, [wMarioY]                                               ; $44c2
	ld   c, a                                                       ; $44c5
	ld   a, [wMarioAnimIdx]                                         ; $44c6
	call UpdateAnimatedOam                                          ; $44c9

	jp   WaitForVBlankIntHandled                                    ; $44cc


ProcessMarioJumping:
; Get, then inc table idx
	ld   a, [wMarioJumpYdiffIdx]                                    ; $44cf
	ld   c, a                                                       ; $44d2

	inc  a                                                          ; $44d3
	ld   [wMarioJumpYdiffIdx], a                                    ; $44d4

; Get idxed y diff value from table
	ld   b, $00                                                     ; $44d7
	ld   hl, .jumpYvals                                             ; $44d9
	add  hl, bc                                                     ; $44dc

; Add value to Mario's Y
	ld   a, [hl]                                                    ; $44dd
	ld   b, a                                                       ; $44de
	ld   a, [wMarioY]                                               ; $44df
	add  b                                                          ; $44e2
	ld   [wMarioY], a                                               ; $44e3

; Convert bool to -1, 1
	ld   a, [wMarioIsMovingRight]                                   ; $44e6
	sla  a                                                          ; $44e9
	dec  a                                                          ; $44eb
	ld   b, a                                                       ; $44ec

; Add onto Mario's X
	ld   a, [wMarioX]                                               ; $44ed
	add  b                                                          ; $44f0
	ld   [wMarioX], a                                               ; $44f1
	ret                                                             ; $44f4

.jumpYvals:
	db $fd, $fd, $fd, $fe, $fe, $fe, $ff, $ff
	db $ff, $00, $ff, $00, $00, $01, $00, $01
	db $01, $01, $02, $02, $02, $03, $03, $03


AnimateOpeningPaddle:
	call UpdatePaddleOam                                            ; $450d

; For idxes 0, 1, then 2, update paddle tile idxes, with 8 frames between each
	xor  a                                                          ; $4510

.loop:
	push af                                                         ; $4511
	call UpdatePaddlesTileIdxes                                     ; $4512

	ld   a, $08                                                     ; $4515
	call WaitForAVBlankIntsHandled                                  ; $4517

	pop  af                                                         ; $451a
	inc  a                                                          ; $451b
	cp   $03                                                        ; $451c
	jr   c, .loop                                                   ; $451e

	ret                                                             ; $4520


AnimateClosingPaddle:

; For idxes 2, 1, then 0, update paddle tile idxes, with 12 frames between each
	ld   a, $02                                                     ; $4521

.loop:
	push af                                                         ; $4523
	call UpdatePaddlesTileIdxes                                     ; $4524

	ld   a, $0c                                                     ; $4527
	call WaitForAVBlankIntsHandled                                  ; $4529
	
	pop  af                                                         ; $452c
	dec  a                                                          ; $452d
	cp   $ff                                                        ; $452e
	jr   nz, .loop                                                  ; $4530

	ret                                                             ; $4532


; A - paddle anim idx
UpdatePaddlesTileIdxes:
; Unnecessary get HL pointing to A's value
	ld   b, $00                                                     ; $4533
	ld   c, a                                                       ; $4535
	ld   hl, .paddleAnimIdxes                                       ; $4536
	add  hl, bc                                                     ; $4539

; Value is triple idx into the tile idxes table
	ld   b, [hl]                                                    ; $453a
	ld   e, $03                                                     ; $453b
	call BCequBtimesE                                               ; $453d
	ld   hl, .paddleAnimTileIdxes                                   ; $4540
	add  hl, bc                                                     ; $4543

; The 3 values are the tile idxes for the 3 paddle tiles
	ld   a, [hl+]                                                   ; $4544
	ld   [wOam+OSLOT_PADDLE+OAM_SIZEOF*0+OAM_TILE], a               ; $4545
	ld   a, [hl+]                                                   ; $4548
	ld   [wOam+OSLOT_PADDLE+OAM_SIZEOF*1+OAM_TILE], a               ; $4549
	ld   a, [hl]                                                    ; $454c
	ld   [wOam+OSLOT_PADDLE+OAM_SIZEOF*2+OAM_TILE], a               ; $454d
	ret                                                             ; $4550

.paddleAnimIdxes:
	db $00, $01, $02

.paddleAnimTileIdxes:
	db $00, $04, $00
	db $00, $03, $00
	db $02, $03, $02
	

AnimateBallExploding::
; Play noise, and have explosion where ball was, and Y at the very bottom
	call PlayNoiseEffect1                                           ; $455d

	ldh  a, [hBallX]                                                ; $4560
	sub  $08                                                        ; $4562
	ld   [wMarioX], a                                               ; $4564

	ld   a, $90                                                     ; $4567
	ld   [wMarioY], a                                               ; $4569

; Start from 1st idx into below table
	xor  a                                                          ; $456c
	ld   [wNonMarioAnimIdx], a                                      ; $456d

.loopAnimate:
	push bc                                                         ; $4570

; Get explosion coords in B, C
	ld   a, [wMarioX]                                               ; $4571
	ld   b, a                                                       ; $4574
	ld   a, [wMarioY]                                               ; $4575
	ld   c, a                                                       ; $4578

; HL = anim idxed into table, get value in it
	ld   a, [wNonMarioAnimIdx]                                      ; $4579
	ld   d, $00                                                     ; $457c
	ld   e, a                                                       ; $457e
	ld   hl, .explosionAnimIdxes                                    ; $457f
	add  hl, de                                                     ; $4582
	ld   a, [hl]                                                    ; $4583

; Update explosion oam with above params, then wait til next frame
	call UpdateAnimatedOam                                          ; $4584
	call WaitForVBlankIntHandled                                    ; $4587
	pop  bc                                                         ; $458a

; Exit once all anims done
	ld   a, [wNonMarioAnimIdx]                                      ; $458b
	inc  a                                                          ; $458e
	ld   [wNonMarioAnimIdx], a                                      ; $458f

	cp   .animEnd-.explosionAnimIdxes                               ; $4592
	jr   c, .loopAnimate                                            ; $4594

; Finally clear explosion oam
	jp   ClearAnimatedOam                                           ; $4596

.explosionAnimIdxes:
	db $07, $07, $07, $07, $07, $07, $07, $07
	db $08, $08, $08, $08, $08, $08, $08, $08
	db $08, $08, $08, $08, $09, $09, $09, $09
	db $09, $09, $09, $09, $09, $09, $09, $09
	db $09, $09, $09, $09
.animEnd:


AnimateBigMarioBlinking::
; Start with 1st idx into the below table
	xor  a                                                          ; $45bd
	ld   [wNonMarioAnimIdx], a                                      ; $45be

.loopBlinking:
	push bc                                                         ; $45c1

; Coords are fixed
	ld   b, $38                                                     ; $45c2
	ld   c, $48                                                     ; $45c4

; HL = anim idx into table, get value from it
	ld   a, [wNonMarioAnimIdx]                                      ; $45c6
	ld   d, $00                                                     ; $45c9
	ld   e, a                                                       ; $45cb
	ld   hl, .blinkingAnimIdxes                                     ; $45cc
	add  hl, de                                                     ; $45cf
	ld   a, [hl]                                                    ; $45d0

; Update Mario blinking using above params, then wait til next frame
	call UpdateAnimatedOam                                          ; $45d1
	call WaitForVBlankIntHandled                                    ; $45d4
	pop  bc                                                         ; $45d7

; Inc idx, ending once full animation done
	ld   a, [wNonMarioAnimIdx]                                      ; $45d8
	inc  a                                                          ; $45db
	ld   [wNonMarioAnimIdx], a                                      ; $45dc

	cp   .endAnimidx-.blinkingAnimIdxes                             ; $45df
	jr   c, .loopBlinking                                           ; $45e1

; Finally clear blinking animation
	jp   ClearAnimatedOam                                           ; $45e3

.blinkingAnimIdxes:
	db $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a
	db $0b, $0b, $0b, $0b, $0b, $0b, $0c, $0c
	db $0c, $0c, $0c, $0c, $0b, $0b, $0b, $0b
	db $0b, $0b, $0b, $0b, $0a
.endAnimidx:


InitInGameScreen::
; Init funcs for pre-in-game
	call TurnOffLCDandWaitForVBlankIntHandled                       ; $4603
	call PreserveAndClearIE                                         ; $4606
	call ClearScreen0                                               ; $4609
	call ClearScreen1                                               ; $460c
	call ClearShadowOam                                             ; $460f
	call InitSound                                                  ; $4612

; Window displays from column 15
	ld   a, 15*8+7                                                  ; $4615
	ldh  [rWX], a                                                   ; $4617
	ld   a, $00                                                     ; $4619
	ldh  [rWY], a                                                   ; $461b

; Allow window display on screen 1
	ldh  a, [hLCDC]                                                 ; $461d
	or   LCDCF_WIN9C00|LCDCF_WINON                                  ; $461f
	ldh  [hLCDC], a                                                 ; $4621

; Clear idx so we update the 1st brick row, starting at $08
	xor  a                                                          ; $4623
	ldh  a, [hBrickRowIdxToSetLYCfor]                               ; $4624

	ld   a, $08                                                     ; $4626
	ldh  [rLYC], a                                                  ; $4628
	ld   a, STATF_LYC|STATF_LYCF                                    ; $462a
	ldh  [rSTAT], a                                                 ; $462c

; Now allow lcd and serial interrupts
	ldh  a, [hIE]                                                   ; $462e
	or   IEF_LCDC                                                   ; $4630
	or   IEF_SERIAL                                                 ; $4632
	ldh  [hIE], a                                                   ; $4634

; Set standard palettes and load layout
	ld   a, %11100100                                               ; $4636
	call SetPalettes                                                ; $4638

	ld   de, DecompressedLayout_InGame                              ; $463b
	call DecompressData                                             ; $463e

; If demo, nice play layout never shows
	ldh  a, [hGameState]                                            ; $4641
	cp   GS_DEMO_INIT                                               ; $4643
	jr   z, .end                                                    ; $4645

; Skip nice play check if no displayed stage
	ld   a, [wDisplayedStage]                                       ; $4647
	cp   $00                                                        ; $464a
	jr   z, .end                                                    ; $464c

; Curr stage == 0, is the nice play layout
	ld   a, [wCurrStage]                                            ; $464e
	cp   $00                                                        ; $4651
	jr   nz, .end                                                   ; $4653

; Decompress the layout onto the screen, with it initially hidden
	ld   de, DecompressedLayout_NicePlay                            ; $4655
	call DecompressData                                             ; $4658

	ld   a, %00000000                                               ; $465b
	call SetPalettes                                                ; $465d

.end:
; Load last of display, the left column, restore interrupts and turn on lcd
	call LoadInGameLeftColumnOam                                    ; $4660
	call RestoreIE                                                  ; $4663
	jp   TurnOnLCD                                                  ; $4666


AddStageAndNumOam::
; Set y coords of Stage xx text
	ld   a, $70                                                     ; $4669
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_Y], a    ; $466b
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_Y], a    ; $466e
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_Y], a    ; $4671
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_Y], a    ; $4674
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_Y], a    ; $4677
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+5*OAM_SIZEOF+OAM_Y], a    ; $467a
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+6*OAM_SIZEOF+OAM_Y], a    ; $467d
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+7*OAM_SIZEOF+OAM_Y], a    ; $4680

; Set x coords of Stage xx text
	ld   a, $30                                                     ; $4683
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_X], a    ; $4685
	ld   a, $38                                                     ; $4688
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_X], a    ; $468a
	ld   a, $40                                                     ; $468d
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_X], a    ; $468f
	ld   a, $48                                                     ; $4692
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_X], a    ; $4694
	ld   a, $50                                                     ; $4697
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_X], a    ; $4699
	ld   a, $58                                                     ; $469c
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+5*OAM_SIZEOF+OAM_X], a    ; $469e
	ld   a, $60                                                     ; $46a1
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+6*OAM_SIZEOF+OAM_X], a    ; $46a3
	ld   a, $68                                                     ; $46a6
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+7*OAM_SIZEOF+OAM_X], a    ; $46a8

; No attrs
	ld   a, $00                                                     ; $46ab
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_ATTR], a ; $46ad
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_ATTR], a ; $46b0
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_ATTR], a ; $46b3
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_ATTR], a ; $46b6
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_ATTR], a ; $46b9
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+5*OAM_SIZEOF+OAM_ATTR], a ; $46bc
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+6*OAM_SIZEOF+OAM_ATTR], a ; $46bf
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+7*OAM_SIZEOF+OAM_ATTR], a ; $46c2

; Set tile idxes of Stage + space tile
	ld   a, "S"                                                     ; $46c5
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_TILE], a ; $46c7
	ld   a, "T"                                                     ; $46ca
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_TILE], a ; $46cc
	ld   a, "A"                                                     ; $46cf
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_TILE], a ; $46d1
	ld   a, "G"                                                     ; $46d4
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_TILE], a ; $46d6
	ld   a, "E"                                                     ; $46d9
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_TILE], a ; $46db
	ld   a, " "                                                     ; $46de
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+5*OAM_SIZEOF+OAM_TILE], a ; $46e0

; Finally set tile idx of stage number
	ld   a, [wDisplayedStage]                                       ; $46e3
	call CBAequAinBCDform                                           ; $46e6
	push af                                                         ; $46e9
	ld   a, b                                                       ; $46ea
	add  "0"                                                        ; $46eb
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+6*OAM_SIZEOF+OAM_TILE], a ; $46ed
	pop  af                                                         ; $46f0
	add  "0"                                                        ; $46f1
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+7*OAM_SIZEOF+OAM_TILE], a ; $46f3
	ret                                                             ; $46f6


AddBonusTextOam::
; Standard flashed text y coords
	ld   a, $70                                                     ; $46f7
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_Y], a    ; $46f9
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_Y], a    ; $46fc
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_Y], a    ; $46ff
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_Y], a    ; $4702
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_Y], a    ; $4705

; Standard flashed text x coords
	ld   a, $38                                                     ; $4708
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_X], a    ; $470a
	ld   a, $40                                                     ; $470d
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_X], a    ; $470f
	ld   a, $48                                                     ; $4712
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_X], a    ; $4714
	ld   a, $50                                                     ; $4717
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_X], a    ; $4719
	ld   a, $58                                                     ; $471c
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_X], a    ; $471e

; No attrs - wrong idxes
	ld   a, $00                                                     ; $4721
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_ATTR], a ; $4723
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+5*OAM_SIZEOF+OAM_ATTR], a ; $4726
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+6*OAM_SIZEOF+OAM_ATTR], a ; $4729
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+7*OAM_SIZEOF+OAM_ATTR], a ; $472c
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_ATTR], a ; $472f

; Finally the bonus text
	ld   a, "B"                                                     ; $4732
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_TILE], a ; $4734
	ld   a, "O"                                                     ; $4737
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_TILE], a ; $4739
	ld   a, "N"                                                     ; $473c
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_TILE], a ; $473e
	ld   a, "U"                                                     ; $4741
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_TILE], a ; $4743
	ld   a, "S"                                                     ; $4746
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_TILE], a ; $4748
	ret                                                             ; $474b


AddPauseTextOam::
; Standard flashed text y coords
	ld   a, $70                                                     ; $474c
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_Y], a    ; $474e
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_Y], a    ; $4751
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_Y], a    ; $4754
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_Y], a    ; $4757
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_Y], a    ; $475a

; Standard flashed text x coords
	ld   a, $38                                                     ; $475d
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_X], a    ; $475f
	ld   a, $40                                                     ; $4762
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_X], a    ; $4764
	ld   a, $48                                                     ; $4767
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_X], a    ; $4769
	ld   a, $50                                                     ; $476c
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_X], a    ; $476e
	ld   a, $58                                                     ; $4771
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_X], a    ; $4773

; No attrs - wrong idxes
	ld   a, $00                                                     ; $4776
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_ATTR], a ; $4778
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+5*OAM_SIZEOF+OAM_ATTR], a ; $477b
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+6*OAM_SIZEOF+OAM_ATTR], a ; $477e
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+7*OAM_SIZEOF+OAM_ATTR], a ; $4781
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_ATTR], a ; $4784

; Finally the pause text
	ld   a, "P"                                                     ; $4787
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+0*OAM_SIZEOF+OAM_TILE], a ; $4789
	ld   a, "A"                                                     ; $478c
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+1*OAM_SIZEOF+OAM_TILE], a ; $478e
	ld   a, "U"                                                     ; $4791
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+2*OAM_SIZEOF+OAM_TILE], a ; $4793
	ld   a, "S"                                                     ; $4796
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+3*OAM_SIZEOF+OAM_TILE], a ; $4798
	ld   a, "E"                                                     ; $479b
	ld   [wOam+OSLOT_FLASHED_IN_GAME_TEXT+4*OAM_SIZEOF+OAM_TILE], a ; $479d
	ret                                                             ; $47a0


DisplayCurrStage::
	call WaitUntilNoCompressedLevelChanges                          ; $47a1

; Store dest addr
	ld   hl, wCompressedLevelChanges                                ; $47a4
	ld   a, HIGH(_SCRN1+$162)                                       ; $47a7
	ld   [hl+], a                                                   ; $47a9
	ld   a, LOW(_SCRN1+$162)                                        ; $47aa
	ld   [hl+], a                                                   ; $47ac

; Copy 2 bytes with compression type 0 (simple copy)
	ld   a, $02                                                     ; $47ad
	ld   [hl+], a                                                   ; $47af

; Get 2 bytes, BA, as curr stage
	ld   a, [wDisplayedStage]                                       ; $47b0
	call CBAequAinBCDform                                           ; $47b3

; 10s is copied 1st
	push af                                                         ; $47b6
	ld   a, b                                                       ; $47b7
	add  "0"                                                        ; $47b8
	ld   [hl+], a                                                   ; $47ba
	pop  af                                                         ; $47bb

; Then 1s
	add  "0"                                                        ; $47bc
	ld   [hl+], a                                                   ; $47be

; Null temrinator
	xor  a                                                          ; $47bf
	ld   [hl+], a                                                   ; $47c0

; Set that there are pending level changes and wait for it to be processed
	inc  a                                                          ; $47c1
	ldh  [hPendingCompressedLevelChanges], a                        ; $47c2
	jp   WaitForVBlankIntHandled                                    ; $47c4


DisplayLivesLeft::
	call WaitUntilNoCompressedLevelChanges                          ; $47c7

; Store dest addr
	ld   hl, wCompressedLevelChanges                                ; $47ca
	ld   a, HIGH(_SCRN1+$204)                                       ; $47cd
	ld   [hl+], a                                                   ; $47cf
	ld   a, LOW(_SCRN1+$204)                                        ; $47d0
	ld   [hl+], a                                                   ; $47d2

; Copy 1 byte with compression type 0 (simple copy)
	ld   a, $01                                                     ; $47d3
	ld   [hl+], a                                                   ; $47d5

; Store lives left as byte to copy
	ld   a, [wLivesLeft]                                            ; $47d6
	add  "0"                                                        ; $47d9
	ld   [hl+], a                                                   ; $47db

; Null terminator
	xor  a                                                          ; $47dc
	ld   [hl+], a                                                   ; $47dd

; Set that there are pending level changes and wait for it to be processed
	inc  a                                                          ; $47de
	ldh  [hPendingCompressedLevelChanges], a                        ; $47df
	jp   WaitForVBlankIntHandled                                    ; $47e1


AddTimeOam::
; Wait until pending changes done
	call WaitUntilNoCompressedLevelChanges                          ; $47e4
	ld   hl, wCompressedLevelChanges                                ; $47e7

; Set address into compressed struct
	ld   a, HIGH(_SCRN1+$1a1)                                       ; $47ea
	ld   [hl+], a                                                   ; $47ec
	ld   a, LOW(_SCRN1+$1a1)                                        ; $47ed
	ld   [hl+], a                                                   ; $47ef

; Set to simple copy 4 bytes
	ld   a, $04                                                     ; $47f0
	ld   [hl+], a                                                   ; $47f2

; Set the 4 bytes
	ld   a, "T"                                                     ; $47f3
	ld   [hl+], a                                                   ; $47f5
	ld   a, "I"                                                     ; $47f6
	ld   [hl+], a                                                   ; $47f8
	ld   a, "M"                                                     ; $47f9
	ld   [hl+], a                                                   ; $47fb
	ld   a, "E"                                                     ; $47fc
	ld   [hl+], a                                                   ; $47fe

.compressionEnd:
; Null terminator
	xor  a                                                          ; $47ff
	ld   [hl+], a                                                   ; $4800

; Set that there are now pending changes
	inc  a                                                          ; $4801
	ldh  [hPendingCompressedLevelChanges], a                        ; $4802
	jp   WaitForVBlankIntHandled                                    ; $4804


ClearTimeOam::
; Wait until pending changes done
	call WaitUntilNoCompressedLevelChanges                          ; $4807
	ld   hl, wCompressedLevelChanges                                ; $480a

; Set address into compressed struct
	ld   a, HIGH(_SCRN1+$1a1)                                       ; $480d
	ld   [hl+], a                                                   ; $480f
	ld   a, LOW(_SCRN1+$1a1)                                        ; $4810
	ld   [hl+], a                                                   ; $4812

; Set to simple copy 4 bytes
	ld   a, $04                                                     ; $4813
	ld   [hl+], a                                                   ; $4815

; Set the 4 blank tiles
	ld   a, TILE_BLANK                                              ; $4816
	ld   [hl+], a                                                   ; $4818
	ld   [hl+], a                                                   ; $4819
	ld   [hl+], a                                                   ; $481a
	ld   [hl+], a                                                   ; $481b

	jr   AddTimeOam.compressionEnd                                  ; $481c


AddInGameTopAndCurrScoreOam::
; Get curr score as BCD
	ld   hl, wOam+OSLOT_CURR_SCORE                                  ; $481e
	ldh  a, [hCurrScore]                                            ; $4821
	ld   b, a                                                       ; $4823
	ldh  a, [hCurrScore+1]                                          ; $4824
	call SaveAB_BCDdigits                                           ; $4826

; Populate Y, then X
	ld   a, $40                                                     ; $4829
	ld   [hl+], a                                                   ; $482b
	ld   a, $88                                                     ; $482c
	ld   [hl+], a                                                   ; $482e

; Based on 10k, set tile idx
	ld   b, TILE_BLANK                                              ; $482f
	ldh  a, [hBCD_10kDigit]                                         ; $4831
	cp   $00                                                        ; $4833
	jr   z, .set10kTileIdx                                          ; $4835

	ld   b, "<fireflower>"                                          ; $4837
	cp   $01                                                        ; $4839
	jr   z, .set10kTileIdx                                          ; $483b

	ld   b, "<mushroom>"                                            ; $483d
	cp   $02                                                        ; $483f
	jr   z, .set10kTileIdx                                          ; $4841

	ld   b, "<star>"                                                ; $4843

.set10kTileIdx:
	ld   a, b                                                       ; $4845
	ld   [hl+], a                                                   ; $4846

; No attrs
	ld   a, $00                                                     ; $4847
	ld   [hl+], a                                                   ; $4849

; Add oam for 1s to 1000s
	ld   a, $38                                                     ; $484a
	ld   [hl+], a                                                   ; $484c
	ld   a, $88                                                     ; $484d
	ld   [hl+], a                                                   ; $484f
	ldh  a, [hBCD_1kDigit]                                          ; $4850
	add  "0"                                                        ; $4852
	ld   [hl+], a                                                   ; $4854
	ld   a, $00                                                     ; $4855
	ld   [hl+], a                                                   ; $4857

	ld   a, $38                                                     ; $4858
	ld   [hl+], a                                                   ; $485a
	ld   a, $90                                                     ; $485b
	ld   [hl+], a                                                   ; $485d
	ldh  a, [hBCD_100Digit]                                         ; $485e
	add  "0"                                                        ; $4860
	ld   [hl+], a                                                   ; $4862
	ld   a, $00                                                     ; $4863
	ld   [hl+], a                                                   ; $4865

	ld   a, $38                                                     ; $4866
	ld   [hl+], a                                                   ; $4868
	ld   a, $98                                                     ; $4869
	ld   [hl+], a                                                   ; $486b
	ldh  a, [hBCD_10Digit]                                          ; $486c
	add  "0"                                                        ; $486e
	ld   [hl+], a                                                   ; $4870
	ld   a, $00                                                     ; $4871
	ld   [hl+], a                                                   ; $4873

	ld   a, $38                                                     ; $4874
	ld   [hl+], a                                                   ; $4876
	ld   a, $a0                                                     ; $4877
	ld   [hl+], a                                                   ; $4879
	ldh  a, [hBCD_1Digit]                                           ; $487a
	add  "0"                                                        ; $487c
	ld   [hl+], a                                                   ; $487e
	ld   a, $00                                                     ; $487f
	ld   [hl+], a                                                   ; $4881

; Repeat above with top score
	ldh  a, [hTopScore]                                             ; $4882
	ld   b, a                                                       ; $4884
	ldh  a, [hTopScore+1]                                           ; $4885
	call SaveAB_BCDdigits                                           ; $4887

; Y then X of 10k symbol
	ld   a, $28                                                     ; $488a
	ld   [hl+], a                                                   ; $488c
	ld   a, $88                                                     ; $488d
	ld   [hl+], a                                                   ; $488f

; 10k symbol branch for top score
	ld   b, TILE_BLANK                                              ; $4890
	ldh  a, [hBCD_10kDigit]                                         ; $4892
	cp   $00                                                        ; $4894
	jr   z, set10kTileIdx_2                                         ; $4896

	ld   b, "<fireflower>"                                          ; $4898
	cp   $01                                                        ; $489a
	jr   z, set10kTileIdx_2                                         ; $489c

	ld   b, "<mushroom>"                                            ; $489e
	cp   $02                                                        ; $48a0
	jr   z, set10kTileIdx_2                                         ; $48a2

	ld   b, "<star>"                                                ; $48a4

set10kTileIdx_2:
	ld   a, b                                                       ; $48a6
	ld   [hl+], a                                                   ; $48a7

; No attrs
	ld   a, $00                                                     ; $48a8
	ld   [hl+], a                                                   ; $48aa

; Add oam for top score 1s to 1000s
	ld   a, $20                                                     ; $48ab
	ld   [hl+], a                                                   ; $48ad
	ld   a, $88                                                     ; $48ae
	ld   [hl+], a                                                   ; $48b0
	ldh  a, [hBCD_1kDigit]                                          ; $48b1
	add  "0"                                                        ; $48b3
	ld   [hl+], a                                                   ; $48b5
	ld   a, $00                                                     ; $48b6
	ld   [hl+], a                                                   ; $48b8

	ld   a, $20                                                     ; $48b9
	ld   [hl+], a                                                   ; $48bb
	ld   a, $90                                                     ; $48bc
	ld   [hl+], a                                                   ; $48be
	ldh  a, [hBCD_100Digit]                                         ; $48bf
	add  "0"                                                        ; $48c1
	ld   [hl+], a                                                   ; $48c3
	ld   a, $00                                                     ; $48c4
	ld   [hl+], a                                                   ; $48c6

	ld   a, $20                                                     ; $48c7
	ld   [hl+], a                                                   ; $48c9
	ld   a, $98                                                     ; $48ca
	ld   [hl+], a                                                   ; $48cc
	ldh  a, [hBCD_10Digit]                                          ; $48cd
	add  "0"                                                        ; $48cf
	ld   [hl+], a                                                   ; $48d1
	ld   a, $00                                                     ; $48d2
	ld   [hl+], a                                                   ; $48d4

	ld   a, $20                                                     ; $48d5
	ld   [hl+], a                                                   ; $48d7
	ld   a, $a0                                                     ; $48d8
	ld   [hl+], a                                                   ; $48da
	ldh  a, [hBCD_1Digit]                                           ; $48db
	add  "0"                                                        ; $48dd
	ld   [hl+], a                                                   ; $48df
	ld   a, $00                                                     ; $48e0
	ld   [hl+], a                                                   ; $48e2

	ret                                                             ; $48e3


AddTitleScreenTopScoreOam::
; Save bcd parts of top score in hram
	ldh  a, [hTopScore]                                             ; $48e4
	ld   b, a                                                       ; $48e6
	ldh  a, [hTopScore+1]                                           ; $48e7
	call SaveAB_BCDdigits                                           ; $48e9

; Start with 10k digit, placing it below the other digits
	ld   hl, wOam+OSLOT_TOP_SCORE                                   ; $48ec
	ld   a, $70                                                     ; $48ef
	ld   [hl+], a                                                   ; $48f1
	ld   a, $70                                                     ; $48f2
	ld   [hl+], a                                                   ; $48f4

; By default, if no 10k digit, use a blank tile
	ld   b, TILE_BLANK                                              ; $48f5
	ldh  a, [hBCD_10kDigit]                                         ; $48f7
	cp   $00                                                        ; $48f9
	jr   z, .set10kTileIdx                                          ; $48fb

; Else use fire flower for 10k+, mushroom for 20k+, and star for 30k+
	ld   b, "<fireflower>"                                          ; $48fd
	cp   $01                                                        ; $48ff
	jr   z, .set10kTileIdx                                          ; $4901

	ld   b, "<mushroom>"                                            ; $4903
	cp   $02                                                        ; $4905
	jr   z, .set10kTileIdx                                          ; $4907

	ld   b, "<star>"                                                ; $4909

.set10kTileIdx:
	ld   a, b                                                       ; $490b
	ld   [hl+], a                                                   ; $490c

; With no attrs
	ld   a, $00                                                     ; $490d
	ld   [hl+], a                                                   ; $490f

; Set the 1s to 1000s digits
	ld   a, $68                                                     ; $4910
	ld   [hl+], a                                                   ; $4912
	ld   a, $70                                                     ; $4913
	ld   [hl+], a                                                   ; $4915
	ldh  a, [hBCD_1kDigit]                                          ; $4916
	add  "0"                                                        ; $4918
	ld   [hl+], a                                                   ; $491a
	ld   a, $00                                                     ; $491b
	ld   [hl+], a                                                   ; $491d

	ld   a, $68                                                     ; $491e
	ld   [hl+], a                                                   ; $4920
	ld   a, $78                                                     ; $4921
	ld   [hl+], a                                                   ; $4923
	ldh  a, [hBCD_100Digit]                                         ; $4924
	add  "0"                                                        ; $4926
	ld   [hl+], a                                                   ; $4928
	ld   a, $00                                                     ; $4929
	ld   [hl+], a                                                   ; $492b

	ld   a, $68                                                     ; $492c
	ld   [hl+], a                                                   ; $492e
	ld   a, $80                                                     ; $492f
	ld   [hl+], a                                                   ; $4931
	ldh  a, [hBCD_10Digit]                                          ; $4932
	add  "0"                                                        ; $4934
	ld   [hl+], a                                                   ; $4936
	ld   a, $00                                                     ; $4937
	ld   [hl+], a                                                   ; $4939

	ld   a, $68                                                     ; $493a
	ld   [hl+], a                                                   ; $493c
	ld   a, $88                                                     ; $493d
	ld   [hl+], a                                                   ; $493f
	ldh  a, [hBCD_1Digit]                                           ; $4940
	add  "0"                                                        ; $4942
	ld   [hl+], a                                                   ; $4944
	ld   a, $00                                                     ; $4945
	ld   [hl+], a                                                   ; $4947

	ret                                                             ; $4948


; BC - non-BCD curr extra pts displayed
AddBonusStageExtraPtsOam::
	ld   hl, wOam+OSLOT_BONUS_STAGE_EXTRA_PTS                       ; $4949

; Split extra points into its 4 digits
	ld   a, b                                                       ; $494c
	ld   b, c                                                       ; $494d
	call SaveAB_BCDdigits                                           ; $494e

; Display 1ks
	ld   a, $78                                                     ; $4951
	ld   [hl+], a                                                   ; $4953
	ld   a, $30                                                     ; $4954
	ld   [hl+], a                                                   ; $4956
	ldh  a, [hBCD_1kDigit]                                          ; $4957
	add  "0"                                                        ; $4959
	ld   [hl+], a                                                   ; $495b
	ld   a, $00                                                     ; $495c
	ld   [hl+], a                                                   ; $495e

; Display 100s
	ld   a, $78                                                     ; $495f
	ld   [hl+], a                                                   ; $4961
	ld   a, $38                                                     ; $4962
	ld   [hl+], a                                                   ; $4964
	ldh  a, [hBCD_100Digit]                                         ; $4965
	add  "0"                                                        ; $4967
	ld   [hl+], a                                                   ; $4969
	ld   a, $00                                                     ; $496a
	ld   [hl+], a                                                   ; $496c

; Display 10s
	ld   a, $78                                                     ; $496d
	ld   [hl+], a                                                   ; $496f
	ld   a, $40                                                     ; $4970
	ld   [hl+], a                                                   ; $4972
	ldh  a, [hBCD_10Digit]                                          ; $4973
	add  "0"                                                        ; $4975
	ld   [hl+], a                                                   ; $4977
	ld   a, $00                                                     ; $4978
	ld   [hl+], a                                                   ; $497a

; Display 1s
	ld   a, $78                                                     ; $497b
	ld   [hl+], a                                                   ; $497d
	ld   a, $48                                                     ; $497e
	ld   [hl+], a                                                   ; $4980
	ldh  a, [hBCD_1Digit]                                           ; $4981
	add  "0"                                                        ; $4983
	ld   [hl+], a                                                   ; $4985
	ld   a, $00                                                     ; $4986
	ld   [hl+], a                                                   ; $4988

	ret                                                             ; $4989


AddGameOverOam::
; Set Y values
	ld   a, $50                                                     ; $498a
	ld   [wOam+OSLOT_GAME_OVER+0*OAM_SIZEOF+OAM_Y], a               ; $498c
	ld   [wOam+OSLOT_GAME_OVER+1*OAM_SIZEOF+OAM_Y], a               ; $498f
	ld   [wOam+OSLOT_GAME_OVER+2*OAM_SIZEOF+OAM_Y], a               ; $4992
	ld   [wOam+OSLOT_GAME_OVER+3*OAM_SIZEOF+OAM_Y], a               ; $4995
	ld   [wOam+OSLOT_GAME_OVER+4*OAM_SIZEOF+OAM_Y], a               ; $4998
	ld   [wOam+OSLOT_GAME_OVER+5*OAM_SIZEOF+OAM_Y], a               ; $499b
	ld   [wOam+OSLOT_GAME_OVER+6*OAM_SIZEOF+OAM_Y], a               ; $499e
	ld   [wOam+OSLOT_GAME_OVER+7*OAM_SIZEOF+OAM_Y], a               ; $49a1

; X values, with a tile between Game and Over
	ld   a, $38                                                     ; $49a4
	ld   [wOam+OSLOT_GAME_OVER+0*OAM_SIZEOF+OAM_X], a               ; $49a6
	ld   a, $40                                                     ; $49a9
	ld   [wOam+OSLOT_GAME_OVER+1*OAM_SIZEOF+OAM_X], a               ; $49ab
	ld   a, $48                                                     ; $49ae
	ld   [wOam+OSLOT_GAME_OVER+2*OAM_SIZEOF+OAM_X], a               ; $49b0
	ld   a, $50                                                     ; $49b3
	ld   [wOam+OSLOT_GAME_OVER+3*OAM_SIZEOF+OAM_X], a               ; $49b5
	ld   a, $60                                                     ; $49b8
	ld   [wOam+OSLOT_GAME_OVER+4*OAM_SIZEOF+OAM_X], a               ; $49ba
	ld   a, $68                                                     ; $49bd
	ld   [wOam+OSLOT_GAME_OVER+5*OAM_SIZEOF+OAM_X], a               ; $49bf
	ld   a, $70                                                     ; $49c2
	ld   [wOam+OSLOT_GAME_OVER+6*OAM_SIZEOF+OAM_X], a               ; $49c4
	ld   a, $78                                                     ; $49c7
	ld   [wOam+OSLOT_GAME_OVER+7*OAM_SIZEOF+OAM_X], a               ; $49c9

; No attrs
	ld   a, $00                                                     ; $49cc
	ld   [wOam+OSLOT_GAME_OVER+0*OAM_SIZEOF+OAM_ATTR], a            ; $49ce
	ld   [wOam+OSLOT_GAME_OVER+1*OAM_SIZEOF+OAM_ATTR], a            ; $49d1
	ld   [wOam+OSLOT_GAME_OVER+2*OAM_SIZEOF+OAM_ATTR], a            ; $49d4
	ld   [wOam+OSLOT_GAME_OVER+3*OAM_SIZEOF+OAM_ATTR], a            ; $49d7
	ld   [wOam+OSLOT_GAME_OVER+4*OAM_SIZEOF+OAM_ATTR], a            ; $49da
	ld   [wOam+OSLOT_GAME_OVER+5*OAM_SIZEOF+OAM_ATTR], a            ; $49dd
	ld   [wOam+OSLOT_GAME_OVER+6*OAM_SIZEOF+OAM_ATTR], a            ; $49e0
	ld   [wOam+OSLOT_GAME_OVER+7*OAM_SIZEOF+OAM_ATTR], a            ; $49e3

; Game over tiles
	ld   a, "G"                                                     ; $49e6
	ld   [wOam+OSLOT_GAME_OVER+0*OAM_SIZEOF+OAM_TILE], a            ; $49e8
	ld   a, "A"                                                     ; $49eb
	ld   [wOam+OSLOT_GAME_OVER+1*OAM_SIZEOF+OAM_TILE], a            ; $49ed
	ld   a, "M"                                                     ; $49f0
	ld   [wOam+OSLOT_GAME_OVER+2*OAM_SIZEOF+OAM_TILE], a            ; $49f2
	ld   a, "E"                                                     ; $49f5
	ld   [wOam+OSLOT_GAME_OVER+3*OAM_SIZEOF+OAM_TILE], a            ; $49f7
	ld   a, "O"                                                     ; $49fa
	ld   [wOam+OSLOT_GAME_OVER+4*OAM_SIZEOF+OAM_TILE], a            ; $49fc
	ld   a, "V"                                                     ; $49ff
	ld   [wOam+OSLOT_GAME_OVER+5*OAM_SIZEOF+OAM_TILE], a            ; $4a01
	ld   a, "E"                                                     ; $4a04
	ld   [wOam+OSLOT_GAME_OVER+6*OAM_SIZEOF+OAM_TILE], a            ; $4a06
	ld   a, "R"                                                     ; $4a09
	ld   [wOam+OSLOT_GAME_OVER+7*OAM_SIZEOF+OAM_TILE], a            ; $4a0b
	ret                                                             ; $4a0e


LoadInGameLeftColumnOam::
	ld   hl, wOam+OSLOT_IN_GAME_LEFT_COLUMNS                        ; $4a0f

; E = current Y
	ld   e, $18                                                     ; $4a12

; Loaded for all rows, except its top-left corner
	ld   d, SCRN_Y_B-1                                              ; $4a14

.nextColumnTile:
	ld   a, e                                                       ; $4a16
	ld   [hl+], a                                                   ; $4a17
	ld   a, $08                                                     ; $4a18
	ld   [hl+], a                                                   ; $4a1a
	ld   a, TILE_COLUMN                                             ; $4a1b
	ld   [hl+], a                                                   ; $4a1d
	ld   a, $00                                                     ; $4a1e
	ld   [hl+], a                                                   ; $4a20

; Add 8 to current Y for next column
	ld   a, e                                                       ; $4a21
	add  $08                                                        ; $4a22
	ld   e, a                                                       ; $4a24

	dec  d                                                          ; $4a25
	jr   nz, .nextColumnTile                                        ; $4a26

	ret                                                             ; $4a28


Stub_4a29::
	ret                                                             ; $4a29

UnusedAddBallSpeedOam:
; Display at the bottom of the screen
	ld   hl, wOam+OSLOT_BALL_SPEED                                  ; $4a2a
	ld   a, $98                                                     ; $4a2d
	ld   [hl+], a                                                   ; $4a2f

	ld   a, $10                                                     ; $4a30
	ld   [hl+], a                                                   ; $4a32

; Display speed as 1 digit, no attrs
	ldh  a, [hBallSpeed]                                            ; $4a33
	add  "0"                                                        ; $4a35
	ld   [hl+], a                                                   ; $4a37

	ld   a, $00                                                     ; $4a38
	ld   [hl+], a                                                   ; $4a3a
	ret                                                             ; $4a3b


DecompressedLayout_InGame:
	db $9c, $00, $01, $be, $9c, $20, $d8, $b4, $98, $00, $01, $bd, $98, $01, $54, $b5
	db $9c, $21, $03, $9d, $98, $99, $9c, $81, $04, $b8, $b9, $ba, $bb, $9d, $41, $04
	db $c0, $c1, $c2, $c3, $9e, $02, $02, $b1, $b2, $00


; A - animation idx
; B - x offset
; C - y offset
; Includes Mario running and jumping into paddle,
; Mario jumping out of paddle and exploding,
; And blinking mario's eyes
UpdateAnimatedOam:
; HL = anim double idx into table
	sla  a                                                          ; $4a66
	ld   e, a                                                       ; $4a68
	ld   d, $00                                                     ; $4a69
	ld   hl, .animPtrs                                              ; $4a6b
	add  hl, de                                                     ; $4a6e

; Get big-endian DE from pointer as src of $10 bytes of oam data
	ld   d, [hl]                                                    ; $4a6f
	inc  hl                                                         ; $4a70
	ld   e, [hl]                                                    ; $4a71

; Loop through 4 objs, 4 bytes each
	ld   hl, wOam+OSLOT_MARIO                                       ; $4a72
	ld   a, $04                                                     ; $4a75

.nextTile:
; 1st byte is base Y
	push af                                                         ; $4a77
	ld   a, [de]                                                    ; $4a78
	add  c                                                          ; $4a79
	ld   [hl+], a                                                   ; $4a7a
	inc  de                                                         ; $4a7b

; 2nd byte is base X
	ld   a, [de]                                                    ; $4a7c
	add  b                                                          ; $4a7d
	ld   [hl+], a                                                   ; $4a7e
	inc  de                                                         ; $4a7f

; 3rd byte is tile idx
	ld   a, [de]                                                    ; $4a80
	ld   [hl+], a                                                   ; $4a81
	inc  de                                                         ; $4a82

; 4th byte is tile attr
	ld   a, [de]                                                    ; $4a83
	ld   [hl+], a                                                   ; $4a84
	inc  de                                                         ; $4a85

; To next tile
	pop  af                                                         ; $4a86
	dec  a                                                          ; $4a87
	jr   nz, .nextTile                                              ; $4a88

	ret                                                             ; $4a8a

.animPtrs:
	dwbe .anim0
	dwbe .anim1
	dwbe .anim2
	dwbe .anim3
	dwbe .anim4
	dwbe .anim5
	dwbe .anim6
	dwbe .anim7
	dwbe .anim8
	dwbe .anim9
	dwbe .animA
	dwbe .animB
	dwbe .animC

.anim0:
	db $00, $00, $06, $80
	db $00, $08, $07, $80
	db $08, $00, $08, $80
	db $08, $08, $09, $80

.anim1:
	db $00, $00, $0a, $80
	db $00, $08, $0b, $80
	db $08, $00, $0c, $80
	db $08, $08, $0d, $80

.anim2:
	db $00, $00, $0e, $80
	db $00, $08, $0f, $80
	db $08, $00, $10, $80
	db $08, $08, $11, $80

.anim3:
	db $00, $00, $12, $80
	db $00, $08, $13, $80
	db $08, $00, $14, $80
	db $08, $08, $15, $80

.anim4:
	db $00, $00, $16, $80
	db $00, $08, $17, $80
	db $08, $00, $18, $80
	db $08, $08, $19, $80

.anim5:
	db $00, $00, $1a, $80
	db $00, $08, $17, $80
	db $08, $00, $18, $80
	db $08, $08, $19, $80

.anim6:
	db $00, $00, $17, $a0
	db $00, $08, $1a, $a0
	db $08, $00, $19, $a0
	db $08, $08, $18, $a0

.anim7:
	db $00, $00, $ff, $00
	db $00, $08, $ff, $00
	db $08, $00, $1b, $00
	db $08, $08, $1b, $20

.anim8:
	db $00, $00, $1c, $00
	db $00, $08, $1c, $20
	db $08, $00, $1d, $00
	db $08, $08, $1d, $20

.anim9:
	db $00, $00, $1e, $00
	db $00, $08, $1e, $20
	db $08, $00, $1f, $00
	db $08, $08, $1f, $20

.animA:
	db $00, $00, $ff, $00
	db $00, $08, $ff, $00
	db $08, $00, $ff, $00
	db $08, $08, $ff, $00

.animB:
	db $00, $00, $21, $00
	db $00, $08, $22, $00
	db $08, $00, $23, $00
	db $08, $08, $24, $00

.animC:
	db $00, $00, $21, $00
	db $00, $08, $22, $00
	db $08, $00, $25, $00
	db $08, $08, $26, $00


Gfx_TileData::
	INCBIN "build/tileData.2bpp"

	
InitAudioControlRegs::
; Enable all
	ld   a, $80                                                     ; $6375
	ldh  [rAUDENA], a                                               ; $6377

; Max vol, without setting Vin bits
	ld   a, $77                                                     ; $6379
	ldh  [rAUDVOL], a                                               ; $637b

; Output all aud channels to both terminals
	ld   a, $ff                                                     ; $637d
	ldh  [rAUDTERM], a                                              ; $637f
	ret                                                             ; $6381


AllowSoundsToStart::
	xor  a                                                          ; $6382
	ld   [wSoundsDontStart], a                                      ; $6383
	ret                                                             ; $6386


PreventSoundsFromStarting::
	ld   a, $01                                                     ; $6387
	ld   [wSoundsDontStart], a                                      ; $6389
	ret                                                             ; $638c


PlaySquareEffectBasedOnPieceHit::
; Get idx to table based on piece hit
	ldh  a, [hTileHitByBall]                                        ; $638d
	dec  a                                                          ; $638f
	ld   b, a                                                       ; $6390
	ld   e, $06                                                     ; $6391
	call BCequBtimesE                                               ; $6393
	ld   hl, BricksMetadata                                         ; $6396
	add  hl, bc                                                     ; $6399

; Get last byte in table entry
	ld   b, $00                                                     ; $639a
	ld   c, $05                                                     ; $639c
	add  hl, bc                                                     ; $639e

; Value determines square effect played
	ld   a, [hl]                                                    ; $639f
	cp   $00                                                        ; $63a0
	jr   z, StartSquareEffect3                                      ; $63a2

	cp   $01                                                        ; $63a4
	jr   z, StartSquareEffect2                                      ; $63a6

	cp   $02                                                        ; $63a8
	jr   z, StartSquareEffect5                                      ; $63aa

	jr   StartSquareEffect6                                         ; $63ac

	
StartSquareEffect1::
	ld   a, $01                                                     ; $63ae
	jr   SetSquareEffectToStart                                     ; $63b0

StartSquareEffect2:
	ld   a, $02                                                     ; $63b2
	jr   SetSquareEffectToStart                                     ; $63b4

StartSquareEffect3:
	ld   a, $03                                                     ; $63b6
	jr   SetSquareEffectToStart                                     ; $63b8

StartSquareEffect4::
	ld   a, $04                                                     ; $63ba
	jr   SetSquareEffectToStart                                     ; $63bc

StartSquareEffect5:
	ld   a, $05                                                     ; $63be
	jr   SetSquareEffectToStart                                     ; $63c0

StartSquareEffect6:
	ld   a, $06                                                     ; $63c2
	jr   SetSquareEffectToStart                                     ; $63c4

StartSquareEffect7::
	ld   a, $07                                                     ; $63c6
	jr   SetSquareEffectToStart                                     ; $63c8

StartSquareEffect8::
	ld   a, $08                                                     ; $63ca
	jr   SetSquareEffectToStart                                     ; $63cc

StartSquareEffect9:
	ld   a, $09                                                     ; $63ce
	jr   SetSquareEffectToStart                                     ; $63d0

StartSquareEffectA:
	ld   a, $0a                                                     ; $63d2
	jr   SetSquareEffectToStart                                     ; $63d4

StartSquareEffectB::
	ld   a, $0b                                                     ; $63d6
	jr   SetSquareEffectToStart                                     ; $63d8

StartSquareEffectC::
	ld   a, $0c                                                     ; $63da

SetSquareEffectToStart:
	ld   [wSquareEffectToPlay], a                                   ; $63dc
	ret                                                             ; $63df


PlayNoiseEffect1:
	ld   a, $01                                                     ; $63e0
	jr   :+                                                         ; $63e2

:	ld   [wNoiseEffectToPlay], a                                    ; $63e4
	ret                                                             ; $63e7


StartSong1::
	ld   a, $01                                                     ; $63e8
	jr   SetSongToStart                                             ; $63ea

StartSong2:
	ld   a, $02                                                     ; $63ec
	jr   SetSongToStart                                             ; $63ee

StartSong3::
	ld   a, $03                                                     ; $63f0
	jr   SetSongToStart                                             ; $63f2

StartSong4::
	ld   a, $04                                                     ; $63f4
	jr   SetSongToStart                                             ; $63f6

StartSong5::
	ld   a, $05                                                     ; $63f8
	jr   SetSongToStart                                             ; $63fa

StartSong6::
	ld   a, $06                                                     ; $63fc
	jr   SetSongToStart                                             ; $63fe

StartSong7::
	ld   a, $07                                                     ; $6400
	jr   SetSongToStart                                             ; $6402

StartSong8::
	ld   a, $08                                                     ; $6404
	jr   SetSongToStart                                             ; $6406

StartSong9::
	ld   a, $09                                                     ; $6408
	jr   SetSongToStart                                             ; $640a

StartSongA::
	ld   a, $0a                                                     ; $640c
	jr   SetSongToStart                                             ; $640e

StartSongB::
	ld   a, $0b                                                     ; $6410
	jr   SetSongToStart                                             ; $6412

StartSongC::
	ld   a, $0c                                                     ; $6414

SetSongToStart:
	ld   [wSongToStart], a                                          ; $6416
	ret                                                             ; $6419


	ds $6800-@, $ff

_UpdateSound:
; Prevent starting sounds if flag set
	call ProcessStoppingSounds                                      ; $6800

; Update effects and music, then process alternating aud term
	call UpdateSq1Effect                                            ; $6803
	call UpdateNoiseEffect                                          ; $6806
	call UpdateMusic                                                ; $6809

	call ProcessAlternatingAudTermWithoutNoise                      ; $680c

; Clear that we've processed any pending songs/effects to play
	xor  a                                                          ; $680f
	ld   [wSquareEffectToPlay], a                                   ; $6810
	ld   [wNoiseEffectToPlay], a                                    ; $6813
	ld   [wSongToStart], a                                          ; $6816
	ret                                                             ; $6819


UnusedPlaySq1SoundFromBtnPressed:
	ldh  a, [hUnusedButtonsPressed]                                 ; $681a
	bit  0, a                                                       ; $681c
	jp   nz, .effect1                                               ; $681e

	bit  1, a                                                       ; $6821
	jp   nz, .effect2                                               ; $6823

	bit  3, a                                                       ; $6826
	jp   nz, .effect3                                               ; $6828

	bit  2, a                                                       ; $682b
	jp   nz, .effect4                                               ; $682d

	bit  4, a                                                       ; $6830
	jp   nz, .effect5                                               ; $6832

	bit  5, a                                                       ; $6835
	jp   nz, .effect6                                               ; $6837

	bit  6, a                                                       ; $683a
	jp   nz, .effect7                                               ; $683c

	bit  7, a                                                       ; $683f
	jp   nz, .effect8                                               ; $6841

	jp   .stub                                                      ; $6844


.effect1:
	ld   a, $01                                                     ; $6847
	ld   [wSquareEffectToPlay], a                                   ; $6849
	ret                                                             ; $684c

.effect2:
	ld   a, $02                                                     ; $684d
	ld   [wSquareEffectToPlay], a                                   ; $684f
	ret                                                             ; $6852

.effect3:
	ld   a, $03                                                     ; $6853
	ld   [wSquareEffectToPlay], a                                   ; $6855
	ret                                                             ; $6858

.effect4:
	ld   a, $04                                                     ; $6859
	ld   [wSquareEffectToPlay], a                                   ; $685b
	ret                                                             ; $685e

.effect5:
	ld   a, $05                                                     ; $685f
	ld   [wSquareEffectToPlay], a                                   ; $6861
	ret                                                             ; $6864

.effect6:
	ld   a, $06                                                     ; $6865
	ld   [wSquareEffectToPlay], a                                   ; $6867
	ret                                                             ; $686a

.effect7:
	ld   a, $07                                                     ; $686b
	ld   [wSquareEffectToPlay], a                                   ; $686d
	ret                                                             ; $6870

.effect8:
	ld   a, $08                                                     ; $6871
	ld   [wSquareEffectToPlay], a                                   ; $6873
	ret                                                             ; $6876

.stub:
	ret                                                             ; $6877


UnusedPlaySongAndSq1SoundFromBtnPressed:
	ldh  a, [hUnusedButtonsPressed]                                 ; $6878
	bit  0, a                                                       ; $687a
	jp   nz, .songAndEffect1                                        ; $687c

	bit  1, a                                                       ; $687f
	jp   nz, .songAndEffect2                                        ; $6881

	bit  3, a                                                       ; $6884
	jp   nz, .songAndEffect3                                        ; $6886

	bit  2, a                                                       ; $6889
	jp   nz, .songAndEffect4                                        ; $688b

	bit  4, a                                                       ; $688e
	jp   nz, .songAndEffect5                                        ; $6890

	bit  5, a                                                       ; $6893
	jp   nz, .songAndEffect6                                        ; $6895

	bit  6, a                                                       ; $6898
	jp   nz, .songAndEffect7                                        ; $689a

	bit  7, a                                                       ; $689d
	jp   nz, .songAndEffect8                                        ; $689f

	jp   .stub                                                      ; $68a2


.songAndEffect1:
	ld   a, $01                                                     ; $68a5
	ld   [wSquareEffectToPlay], a                                   ; $68a7
	ld   [wSongToStart], a                                          ; $68aa
	ret                                                             ; $68ad

.songAndEffect2:
	ld   a, $02                                                     ; $68ae
	ld   [wSquareEffectToPlay], a                                   ; $68b0
	ld   [wSongToStart], a                                          ; $68b3
	ret                                                             ; $68b6

.songAndEffect3:
	ld   a, $03                                                     ; $68b7
	ld   [wSquareEffectToPlay], a                                   ; $68b9
	ld   [wSongToStart], a                                          ; $68bc
	ret                                                             ; $68bf

.songAndEffect4:
	ld   a, $04                                                     ; $68c0
	ld   [wSquareEffectToPlay], a                                   ; $68c2
	ld   [wSongToStart], a                                          ; $68c5
	ret                                                             ; $68c8

.songAndEffect5:
	ld   a, $05                                                     ; $68c9
	ld   [wSquareEffectToPlay], a                                   ; $68cb
	ld   [wSongToStart], a                                          ; $68ce
	ret                                                             ; $68d1

.songAndEffect6:
	ld   a, $06                                                     ; $68d2
	ld   [wSquareEffectToPlay], a                                   ; $68d4
	ld   [wSongToStart], a                                          ; $68d7
	ret                                                             ; $68da

.songAndEffect7:
	ld   a, $07                                                     ; $68db
	ld   [wSquareEffectToPlay], a                                   ; $68dd
	ld   [wSongToStart], a                                          ; $68e0
	ret                                                             ; $68e3

.songAndEffect8:
	ld   a, $08                                                     ; $68e4
	ld   [wSquareEffectToPlay], a                                   ; $68e6
	ld   [wSongToStart], a                                          ; $68e9
	ret                                                             ; $68ec


.stub:
	ret                                                             ; $68ed


UnusedPlayNoiseEffectFromBtnPressed:
	ldh  a, [hUnusedButtonsPressed]                                 ; $68ee
	bit  0, a                                                       ; $68f0
	jp   nz, .noiseEffect1                                          ; $68f2

	bit  1, a                                                       ; $68f5
	jp   nz, .noiseEffect2                                          ; $68f7

	bit  3, a                                                       ; $68fa
	jp   nz, .noiseEffect3                                          ; $68fc

	bit  2, a                                                       ; $68ff
	jp   nz, .noiseEffect4                                          ; $6901

	bit  4, a                                                       ; $6904
	jp   nz, .noiseEffect5                                          ; $6906

	bit  5, a                                                       ; $6909
	jp   nz, .noiseEffect6                                          ; $690b

	bit  6, a                                                       ; $690e
	jp   nz, .noiseEffect7                                          ; $6910

	bit  7, a                                                       ; $6913
	jp   nz, .noiseEffect8                                          ; $6915

	jp   UnusedPlaySq1SoundFromBtnPressed.stub                      ; $6918

.noiseEffect1:
	ld   a, $01                                                     ; $691b
	ld   [wNoiseEffectToPlay], a                                    ; $691d
	ret                                                             ; $6920

.noiseEffect2:
	ld   a, $02                                                     ; $6921
	ld   [wNoiseEffectToPlay], a                                    ; $6923
	ret                                                             ; $6926

.noiseEffect3:
	ld   a, $03                                                     ; $6927
	ld   [wNoiseEffectToPlay], a                                    ; $6929
	ret                                                             ; $692c

.noiseEffect4:
	ld   a, $04                                                     ; $692d
	ld   [wNoiseEffectToPlay], a                                    ; $692f
	ret                                                             ; $6932

.noiseEffect5:
	ld   a, $05                                                     ; $6933
	ld   [wNoiseEffectToPlay], a                                    ; $6935
	ret                                                             ; $6938

.noiseEffect6:
	ld   a, $06                                                     ; $6939
	ld   [wNoiseEffectToPlay], a                                    ; $693b
	ret                                                             ; $693e

.noiseEffect7:
	ld   a, $07                                                     ; $693f
	ld   [wNoiseEffectToPlay], a                                    ; $6941
	ret                                                             ; $6944

.noiseEffect8:
	ld   a, $08                                                     ; $6945
	ld   [wNoiseEffectToPlay], a                                    ; $6947
	ret                                                             ; $694a


; unused
	ret                                                             ; $694b


UnusedPlaySongFromBtnPressed:
	ldh  a, [hUnusedButtonsPressed]                                 ; $694c
	bit  0, a                                                       ; $694e
	jp   nz, .playSong1                                             ; $6950

	bit  1, a                                                       ; $6953
	jp   nz, .playSong2                                             ; $6955

	bit  3, a                                                       ; $6958
	jp   nz, .playSong3                                             ; $695a

	bit  2, a                                                       ; $695d
	jp   nz, .playSong4                                             ; $695f

	bit  4, a                                                       ; $6962
	jp   nz, .playSong5                                             ; $6964

	bit  5, a                                                       ; $6967
	jp   nz, .playSong6                                             ; $6969

	bit  6, a                                                       ; $696c
	jp   nz, .playSong7                                             ; $696e

	bit  7, a                                                       ; $6971
	jp   nz, .playSong8                                             ; $6973

	jp   .stub                                                      ; $6976

.playSong1:
	ld   a, $01                                                     ; $6979
	ld   [wSongToStart], a                                          ; $697b
	ret                                                             ; $697e

.playSong2:
	ld   a, $02                                                     ; $697f
	ld   [wSongToStart], a                                          ; $6981
	ret                                                             ; $6984

.playSong3:
	ld   a, $03                                                     ; $6985
	ld   [wSongToStart], a                                          ; $6987
	ret                                                             ; $698a

.playSong4:
	ld   a, $04                                                     ; $698b
	ld   [wSongToStart], a                                          ; $698d
	ret                                                             ; $6990

.playSong5:
	ld   a, $05                                                     ; $6991
	ld   [wSongToStart], a                                          ; $6993
	ret                                                             ; $6996

.playSong6:
	ld   a, $06                                                     ; $6997
	ld   [wSongToStart], a                                          ; $6999
	ret                                                             ; $699c

.playSong7:
	ld   a, $07                                                     ; $699d
	ld   [wSongToStart], a                                          ; $699f
	ret                                                             ; $69a2

.playSong8:
	ld   a, $08                                                     ; $69a3
	ld   [wSongToStart], a                                          ; $69a5
	ret                                                             ; $69a8

.stub:
	ret                                                             ; $69a9


UnusedPollInput:
	push af                                                         ; $69aa
	push bc                                                         ; $69ab
	ld   a, $10                                                     ; $69ac
	ldh  [rP1], a                                                   ; $69ae
	ldh  a, [rP1]                                                   ; $69b0
	ldh  a, [rP1]                                                   ; $69b2
	ldh  a, [rP1]                                                   ; $69b4
	ldh  a, [rP1]                                                   ; $69b6
	ldh  a, [rP1]                                                   ; $69b8
	ldh  a, [rP1]                                                   ; $69ba
	cpl                                                             ; $69bc
	and  $0f                                                        ; $69bd
	ld   b, a                                                       ; $69bf
	ld   a, $20                                                     ; $69c0
	ldh  [rP1], a                                                   ; $69c2
	ldh  a, [rP1]                                                   ; $69c4
	ldh  a, [rP1]                                                   ; $69c6
	ldh  a, [rP1]                                                   ; $69c8
	ldh  a, [rP1]                                                   ; $69ca
	ldh  a, [rP1]                                                   ; $69cc
	ldh  a, [rP1]                                                   ; $69ce
	cpl                                                             ; $69d0
	and  $0f                                                        ; $69d1
	swap a                                                          ; $69d3
	or   b                                                          ; $69d5
	ld   c, a                                                       ; $69d6
	ldh  a, [hUnusedButtonsHeld]                                    ; $69d7
	xor  c                                                          ; $69d9
	and  c                                                          ; $69da
	ldh  [hUnusedButtonsPressed], a                                 ; $69db
	ld   a, c                                                       ; $69dd
	ldh  [hUnusedButtonsHeld], a                                    ; $69de
	ld   a, $30                                                     ; $69e0
	ldh  [rP1], a                                                   ; $69e2
	pop  bc                                                         ; $69e4
	pop  af                                                         ; $69e5
	ret                                                             ; $69e6


ProcessStoppingSounds:
; If flag == 1, prevent
	ld   a, [wSoundsDontStart]                                      ; $69e7
	cp   $01                                                        ; $69ea
	jp   z, .stopAllSounds                                          ; $69ec

	ret                                                             ; $69ef

.stopAllSounds:
	xor  a                                                          ; $69f0
	ld   [wSquareEffectToPlay], a                                   ; $69f1
	ld   [wNoiseEffectToPlay], a                                    ; $69f4
	ld   [wSongToStart], a                                          ; $69f7
	ret                                                             ; $69fa


UpdateSq1Effect:
; Don't start new effects if square effect 1 is being played
	ld   a, [wSquareEffectBeingPlayed]                              ; $69fb
	cp   $01                                                        ; $69fe
	jp   z, ContinueSquareEffect1                                   ; $6a00

; Branch based on new effect to play
	ld   a, [wSquareEffectToPlay]                                   ; $6a03
	cp   $04                                                        ; $6a06
	jp   z, .startSquareEffect4                                     ; $6a08

	cp   $02                                                        ; $6a0b
	jp   z, .startSquareEffect2                                     ; $6a0d

	cp   $03                                                        ; $6a10
	jp   z, .startSquareEffect3                                     ; $6a12

	cp   $01                                                        ; $6a15
	jp   z, .startSquareEffect1                                     ; $6a17

	cp   $05                                                        ; $6a1a
	jp   z, .startSquareEffect5                                     ; $6a1c

	cp   $06                                                        ; $6a1f
	jp   z, .startSquareEffect6                                     ; $6a21

	cp   $07                                                        ; $6a24
	jp   z, .startSquareEffect7                                     ; $6a26

	cp   $08                                                        ; $6a29
	jp   z, .startSquareEffect8                                     ; $6a2b

	cp   $09                                                        ; $6a2e
	jp   z, .startSquareEffect9                                     ; $6a30

	cp   $0a                                                        ; $6a33
	jp   z, .startSquareEffectA                                     ; $6a35

	cp   $0b                                                        ; $6a38
	jp   z, .startSquareEffectB                                     ; $6a3a

	cp   $0c                                                        ; $6a3d
	jp   z, .startSquareEffectC                                     ; $6a3f

; If no new effects, continue the current one
	ld   a, [wSquareEffectBeingPlayed]                              ; $6a42
	cp   $02                                                        ; $6a45
	jp   z, ContinueSquareEffect2                                   ; $6a47

	cp   $03                                                        ; $6a4a
	jp   z, ContinueSquareEffect3                                   ; $6a4c

	cp   $04                                                        ; $6a4f
	jp   z, ContinueSquareEffect4                                   ; $6a51

	cp   $05                                                        ; $6a54
	jp   z, ContinueSquareEffect5                                   ; $6a56

	cp   $06                                                        ; $6a59
	jp   z, ContinueSquareEffect6                                   ; $6a5b

	cp   $07                                                        ; $6a5e
	jp   z, ContinueSquareEffect7                                   ; $6a60

	cp   $08                                                        ; $6a63
	jp   z, ContinueSquareEffect8                                   ; $6a65

	cp   $09                                                        ; $6a68
	jp   z, ContinueSquareEffect9                                   ; $6a6a

	cp   $0a                                                        ; $6a6d
	jp   z, ContinueSquareEffectA                                   ; $6a6f

	cp   $0b                                                        ; $6a72
	jp   z, ContinueSquareEffectB                                   ; $6a74

	cp   $0c                                                        ; $6a77
	jp   z, ContinueSquareEffectC                                   ; $6a79

	ret                                                             ; $6a7c

; For each effect, generally set a val to have the effect continue,
; Set the number of steps it goes through (changing regs on some steps)
; And copy initial regs
.startSquareEffect1:
	ld   a, $01                                                     ; $6a7d
	ld   [wSquareEffectBeingPlayed], a                              ; $6a7f

	ld   a, $07                                                     ; $6a82
	ld   [wCurrSquareEffectStep], a                                 ; $6a84

	ld   hl, SquareEffect1Regs_0                                    ; $6a87
	ld   c, $10                                                     ; $6a8a
	call Copy5bytesToAudRegs                                        ; $6a8c
	ret                                                             ; $6a8f

.startSquareEffect2:
; Return if paddle is currently changing
	ld   a, [wPlayingShortenedPaddleSqEffect]                       ; $6a90
	cp   $01                                                        ; $6a93
	jp   z, :+                                                      ; $6a95

	ld   a, $02                                                     ; $6a98
	ld   [wSquareEffectBeingPlayed], a                              ; $6a9a

	ld   a, $05                                                     ; $6a9d
	ld   [wCurrSquareEffectStep], a                                 ; $6a9f

	ld   hl, SquareEffect2Regs_0                                    ; $6aa2
	ld   c, $10                                                     ; $6aa5
	call Copy5bytesToAudRegs                                        ; $6aa7

:	ret                                                             ; $6aaa

.startSquareEffect3:
; Return if paddle is currently changing
	ld   a, [wPlayingShortenedPaddleSqEffect]                       ; $6aab
	cp   $01                                                        ; $6aae
	jp   z, :+                                                      ; $6ab0

	ld   a, $03                                                     ; $6ab3
	ld   [wSquareEffectBeingPlayed], a                              ; $6ab5

	ld   a, $05                                                     ; $6ab8
	ld   [wCurrSquareEffectStep], a                                 ; $6aba

	ld   hl, SquareEffect3Regs_0                                    ; $6abd
	ld   c, $10                                                     ; $6ac0
	call Copy5bytesToAudRegs                                        ; $6ac2

:	ret                                                             ; $6ac5

.startSquareEffect4:
; Return if paddle is currently changing
	ld   a, [wPlayingShortenedPaddleSqEffect]                       ; $6ac6
	cp   $01                                                        ; $6ac9
	jp   z, :+                                                      ; $6acb

	ld   a, $04                                                     ; $6ace
	ld   [wSquareEffectBeingPlayed], a                              ; $6ad0

	ld   a, $04                                                     ; $6ad3
	ld   [wCurrSquareEffectStep], a                                 ; $6ad5

	ld   hl, SquareEffect4Regs_0                                    ; $6ad8
	ld   c, $10                                                     ; $6adb
	call Copy5bytesToAudRegs                                        ; $6add

:	ret                                                             ; $6ae0

.startSquareEffect5:
; Return if paddle is currently changing
	ld   a, [wPlayingShortenedPaddleSqEffect]                       ; $6ae1
	cp   $01                                                        ; $6ae4
	jp   z, :+                                                      ; $6ae6

	ld   a, $05                                                     ; $6ae9
	ld   [wSquareEffectBeingPlayed], a                              ; $6aeb

	ld   a, $05                                                     ; $6aee
	ld   [wCurrSquareEffectStep], a                                 ; $6af0

	ld   hl, SquareEffect5Regs_0                                    ; $6af3
	ld   c, $10                                                     ; $6af6
	call Copy5bytesToAudRegs                                        ; $6af8

:	ret                                                             ; $6afb

.startSquareEffect6:
; Return if paddle is currently changing
	ld   a, [wPlayingShortenedPaddleSqEffect]                       ; $6afc
	cp   $01                                                        ; $6aff
	jp   z, :+                                                      ; $6b01

	ld   a, $06                                                     ; $6b04
	ld   [wSquareEffectBeingPlayed], a                              ; $6b06

	ld   a, $05                                                     ; $6b09
	ld   [wCurrSquareEffectStep], a                                 ; $6b0b

	ld   hl, SquareEffect6Regs_0                                    ; $6b0e
	ld   c, $10                                                     ; $6b11
	call Copy5bytesToAudRegs                                        ; $6b13

:	ret                                                             ; $6b16

.startSquareEffect7:
	ld   a, $07                                                     ; $6b17
	ld   [wSquareEffectBeingPlayed], a                              ; $6b19

	ld   a, $04                                                     ; $6b1c
	ld   [wCurrSquareEffectStep], a                                 ; $6b1e

	ld   hl, SquareEffect7Regs_0                                    ; $6b21
	ld   c, $10                                                     ; $6b24
	call Copy5bytesToAudRegs                                        ; $6b26
	ret                                                             ; $6b29

.startSquareEffect8:
	ld   a, $08                                                     ; $6b2a
	ld   [wSquareEffectBeingPlayed], a                              ; $6b2c

	ld   a, $05                                                     ; $6b2f
	ld   [wCurrSquareEffectStep], a                                 ; $6b31
	
	ld   hl, SquareEffect8Regs_0                                    ; $6b34
	ld   c, $10                                                     ; $6b37
	call Copy5bytesToAudRegs                                        ; $6b39
	ret                                                             ; $6b3c

; For the rest of the square effects, they are sweeping effects
; Set the sound played to continue them, and set the initial params for the sweep
.startSquareEffect9:
	ld   a, $09                                                     ; $6b3d
	ld   [wSquareEffectBeingPlayed], a                              ; $6b3f

	ld   a, $63                                                     ; $6b42
	ld   [wSweepingSqEffectFreqLo1], a                              ; $6b44
	ld   a, $0a                                                     ; $6b47
	ld   [wSweepingSqEffectFreqLo2], a                              ; $6b49
	ld   a, $87                                                     ; $6b4c
	ld   [wSweepingSqEffectFreqHi1], a                              ; $6b4e
	ld   a, $ff                                                     ; $6b51
	ld   [wSweepingSqEffectDirection], a                            ; $6b53
	ret                                                             ; $6b56

.startSquareEffectA:
	ld   a, $0a                                                     ; $6b57
	ld   [wSquareEffectBeingPlayed], a                              ; $6b59

	ld   a, $0b                                                     ; $6b5c
	ld   [wSweepingSqEffectFreqLo1], a                              ; $6b5e
	ld   a, $ac                                                     ; $6b61
	ld   [wSweepingSqEffectFreqLo2], a                              ; $6b63
	ld   a, $86                                                     ; $6b66
	ld   [wSweepingSqEffectFreqHi1], a                              ; $6b68
	ld   a, $87                                                     ; $6b6b
	ld   [wSweepingSqEffectFreqHi2], a                              ; $6b6d
	ld   a, $ff                                                     ; $6b70
	ld   [wSweepingSqEffectDirection], a                            ; $6b72
	ret                                                             ; $6b75

.startSquareEffectB:
	ld   a, $0b                                                     ; $6b76
	ld   [wSquareEffectBeingPlayed], a                              ; $6b78

	ld   a, $a5                                                     ; $6b7b
	ld   [wSweepingSqEffectFreqLo2], a                              ; $6b7d
	ld   a, $87                                                     ; $6b80
	ld   [wSweepingSqEffectFreqHi2], a                              ; $6b82
	ld   a, $01                                                     ; $6b85
	ld   [wPlayingShortenedPaddleSqEffect], a                       ; $6b87
	ret                                                             ; $6b8a

.startSquareEffectC:
; Return if paddle is currently changing
	ld   a, [wPlayingShortenedPaddleSqEffect]                       ; $6b8b
	cp   $01                                                        ; $6b8e
	jp   z, :+                                                      ; $6b90

	ld   a, $0c                                                     ; $6b93
	ld   [wSquareEffectBeingPlayed], a                              ; $6b95
	ld   a, $ff                                                     ; $6b98
	ld   [wSweepingSqEffectFreqLo1], a                              ; $6b9a
	ld   a, $0a                                                     ; $6b9d
	ld   [wSweepingSqEffectFreqLo2], a                              ; $6b9f
	ld   a, $85                                                     ; $6ba2
	ld   [wSweepingSqEffectFreqHi1], a                              ; $6ba4
	ld   a, $ff                                                     ; $6ba7
	ld   [wSweepingSqEffectDirection], a                            ; $6ba9

:	ret                                                             ; $6bac


ContinueSquareEffect1:
; Inc frame counter before processing another step, returning if not 7
	ld   a, [wFrameCounterForSquareEffectStep]                      ; $6bad
	inc  a                                                          ; $6bb0
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6bb1

	cp   $07                                                        ; $6bb4
	jp   nz, Stub_6f9c                                              ; $6bb6

; Then clear for next step
	xor  a                                                          ; $6bb9
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6bba

; Go to new step, then jup to relevant handler
	ld   a, [wCurrSquareEffectStep]                                 ; $6bbd
	dec  a                                                          ; $6bc0
	ld   [wCurrSquareEffectStep], a                                 ; $6bc1

	cp   $06                                                        ; $6bc4
	jp   z, .step6                                                  ; $6bc6

	cp   $05                                                        ; $6bc9
	jp   z, .step5                                                  ; $6bcb

	cp   $04                                                        ; $6bce
	jp   z, .step4                                                  ; $6bd0

	cp   $03                                                        ; $6bd3
	jp   z, .step3                                                  ; $6bd5

	cp   $02                                                        ; $6bd8
	jp   z, .step2                                                  ; $6bda

; Finally stop the effect
	cp   $01                                                        ; $6bdd
	xor  a                                                          ; $6bdf
	ld   [wSquareEffectBeingPlayed], a                              ; $6be0
	jp   StopSquareEffect                                           ; $6be3

.step6:
	ld   hl, SquareEffect1Regs_1                                    ; $6be6
	ld   c, $10                                                     ; $6be9
	call Copy5bytesToAudRegs                                        ; $6beb
	ret                                                             ; $6bee

.step5:
	ld   hl, SquareEffect1Regs_2                                    ; $6bef
	ld   c, $10                                                     ; $6bf2
	call Copy5bytesToAudRegs                                        ; $6bf4
	ret                                                             ; $6bf7

.step4:
	ld   hl, SquareEffect1Regs_3                                    ; $6bf8
	ld   c, $10                                                     ; $6bfb
	call Copy5bytesToAudRegs                                        ; $6bfd
	ret                                                             ; $6c00

.step3:
	ld   hl, SquareEffect1Regs_4                                    ; $6c01
	ld   c, $10                                                     ; $6c04
	call Copy5bytesToAudRegs                                        ; $6c06
	ret                                                             ; $6c09

.step2:
	ld   hl, SquareEffect1Regs_5                                    ; $6c0a
	ld   c, $10                                                     ; $6c0d
	call Copy5bytesToAudRegs                                        ; $6c0f
	xor  a                                                          ; $6c12
	ld   [wPlayingShortenedPaddleSqEffect], a                       ; $6c13
	ret                                                             ; $6c16


ContinueSquareEffect2:
; Inc frame counter before processing another step, returning if not 7
	ld   a, [wFrameCounterForSquareEffectStep]                      ; $6c17
	inc  a                                                          ; $6c1a
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6c1b

	cp   $05                                                        ; $6c1e
	jp   nz, Stub_6f9c                                              ; $6c20

; Then clear for next step
	xor  a                                                          ; $6c23
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6c24

; Go to new step, then jup to relevant handler
	ld   a, [wCurrSquareEffectStep]                                 ; $6c27
	dec  a                                                          ; $6c2a
	ld   [wCurrSquareEffectStep], a                                 ; $6c2b

	cp   $04                                                        ; $6c2e
	jp   z, .step4                                                  ; $6c30

	cp   $03                                                        ; $6c33
	jp   z, .step3                                                  ; $6c35

	cp   $02                                                        ; $6c38
	jp   z, .step2                                                  ; $6c3a

; Finally stop the effect
	cp   $01                                                        ; $6c3d
	jp   StopSquareEffect                                           ; $6c3f

.step4:
	ld   hl, SquareEffect2Regs_0                                    ; $6c42
	ld   c, $10                                                     ; $6c45
	call Copy5bytesToAudRegs                                        ; $6c47
	ret                                                             ; $6c4a

.step3:
	ld   hl, SquareEffect2Regs_1                                    ; $6c4b
	ld   c, $10                                                     ; $6c4e
	call Copy5bytesToAudRegs                                        ; $6c50
	ret                                                             ; $6c53

.step2:
	ld   hl, SquareEffect2Regs_2                                    ; $6c54
	ld   c, $10                                                     ; $6c57
	call Copy5bytesToAudRegs                                        ; $6c59
	ret                                                             ; $6c5c


ContinueSquareEffect3:
; Inc frame counter before processing another step, returning if not 7
	ld   a, [wFrameCounterForSquareEffectStep]                      ; $6c5d
	inc  a                                                          ; $6c60
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6c61

	cp   $03                                                        ; $6c64
	jp   nz, Stub_6f9c                                              ; $6c66

; Then clear for next step
	xor  a                                                          ; $6c69
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6c6a

; Go to new step, then jup to relevant handler
	ld   a, [wCurrSquareEffectStep]                                 ; $6c6d
	dec  a                                                          ; $6c70
	ld   [wCurrSquareEffectStep], a                                 ; $6c71

	cp   $04                                                        ; $6c74
	jp   z, .step4                                                  ; $6c76

	cp   $03                                                        ; $6c79
	jp   z, .step3                                                  ; $6c7b

	cp   $02                                                        ; $6c7e
	jp   z, .step2                                                  ; $6c80

; Finally stop the effect
	cp   $01                                                        ; $6c83
	jp   StopSquareEffect                                           ; $6c85

.step4:
	ld   hl, SquareEffect3Regs_1                                    ; $6c88
	ld   c, $10                                                     ; $6c8b
	call Copy5bytesToAudRegs                                        ; $6c8d
	ret                                                             ; $6c90

.step3:
	ld   hl, SquareEffect3Regs_2                                    ; $6c91
	ld   c, $10                                                     ; $6c94
	call Copy5bytesToAudRegs                                        ; $6c96
	ret                                                             ; $6c99

.step2:
	ld   hl, SquareEffect3Regs_3                                    ; $6c9a
	ld   c, $10                                                     ; $6c9d
	call Copy5bytesToAudRegs                                        ; $6c9f
	ret                                                             ; $6ca2


ContinueSquareEffect4:
; Inc frame counter before processing another step, returning if not 7
	ld   a, [wFrameCounterForSquareEffectStep]                      ; $6ca3
	inc  a                                                          ; $6ca6
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6ca7

	cp   $05                                                        ; $6caa
	jp   nz, Stub_6f9c                                              ; $6cac

; Then clear for next step
	xor  a                                                          ; $6caf
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6cb0

; Go to new step, then jup to relevant handler
	ld   a, [wCurrSquareEffectStep]                                 ; $6cb3
	dec  a                                                          ; $6cb6
	ld   [wCurrSquareEffectStep], a                                 ; $6cb7

	cp   $04                                                        ; $6cba
	jp   z, .step4                                                  ; $6cbc

	cp   $03                                                        ; $6cbf
	jp   z, .step3                                                  ; $6cc1

	cp   $02                                                        ; $6cc4
	jp   z, .step2                                                  ; $6cc6

; Finally stop the effect
	cp   $01                                                        ; $6cc9
	jp   StopSquareEffect                                           ; $6ccb

.step4:
	ld   hl, SquareEffect4Regs_0                                    ; $6cce
	ld   c, $10                                                     ; $6cd1
	call Copy5bytesToAudRegs                                        ; $6cd3
	ret                                                             ; $6cd6

.step3:
	ld   hl, SquareEffect4Regs_1                                    ; $6cd7
	ld   c, $10                                                     ; $6cda
	call Copy5bytesToAudRegs                                        ; $6cdc
	ret                                                             ; $6cdf

.step2:
	ld   hl, SquareEffect4Regs_2                                    ; $6ce0
	ld   c, $10                                                     ; $6ce3
	call Copy5bytesToAudRegs                                        ; $6ce5
	ret                                                             ; $6ce8


ContinueSquareEffect5:
; Inc frame counter before processing another step, returning if not 7
	ld   a, [wFrameCounterForSquareEffectStep]                      ; $6ce9
	inc  a                                                          ; $6cec
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6ced

	cp   $05                                                        ; $6cf0
	jp   nz, Stub_6f9c                                              ; $6cf2

; Then clear for next step
	xor  a                                                          ; $6cf5
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6cf6

; Go to new step, then jup to relevant handler
	ld   a, [wCurrSquareEffectStep]                                 ; $6cf9
	dec  a                                                          ; $6cfc
	ld   [wCurrSquareEffectStep], a                                 ; $6cfd

	cp   $04                                                        ; $6d00
	jp   z, .step4                                                  ; $6d02

	cp   $03                                                        ; $6d05
	jp   z, .step3                                                  ; $6d07

	cp   $02                                                        ; $6d0a
	jp   z, .step2                                                  ; $6d0c

; Finally stop the effect
	cp   $01                                                        ; $6d0f
	jp   StopSquareEffect                                           ; $6d11

.step4:
	ld   hl, SquareEffect5Regs_0                                    ; $6d14
	ld   c, $10                                                     ; $6d17
	call Copy5bytesToAudRegs                                        ; $6d19
	ret                                                             ; $6d1c

.step3:
	ld   hl, SquareEffect5Regs_1                                    ; $6d1d
	ld   c, $10                                                     ; $6d20
	call Copy5bytesToAudRegs                                        ; $6d22
	ret                                                             ; $6d25

.step2:
	ld   hl, SquareEffect5Regs_2                                    ; $6d26
	ld   c, $10                                                     ; $6d29
	call Copy5bytesToAudRegs                                        ; $6d2b
	ret                                                             ; $6d2e


ContinueSquareEffect6:
; Inc frame counter before processing another step, returning if not 7
	ld   a, [wFrameCounterForSquareEffectStep]                      ; $6d2f
	inc  a                                                          ; $6d32
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6d33

	cp   $05                                                        ; $6d36
	jp   nz, Stub_6f9c                                              ; $6d38

; Then clear for next step
	xor  a                                                          ; $6d3b
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6d3c

; Go to new step, then jup to relevant handler
	ld   a, [wCurrSquareEffectStep]                                 ; $6d3f
	dec  a                                                          ; $6d42
	ld   [wCurrSquareEffectStep], a                                 ; $6d43

	cp   $04                                                        ; $6d46
	jp   z, .step4                                                  ; $6d48

	cp   $03                                                        ; $6d4b
	jp   z, .step3                                                  ; $6d4d

	cp   $02                                                        ; $6d50
	jp   z, .step2                                                  ; $6d52

; Finally stop the effect
	cp   $01                                                        ; $6d55
	jp   StopSquareEffect                                           ; $6d57

.step4:
	ld   hl, SquareEffect6Regs_0                                    ; $6d5a
	ld   c, $10                                                     ; $6d5d
	call Copy5bytesToAudRegs                                        ; $6d5f
	ret                                                             ; $6d62

.step3:
	ld   hl, SquareEffect6Regs_1                                    ; $6d63
	ld   c, $10                                                     ; $6d66
	call Copy5bytesToAudRegs                                        ; $6d68
	ret                                                             ; $6d6b

.step2:
	ld   hl, SquareEffect6Regs_2                                    ; $6d6c
	ld   c, $10                                                     ; $6d6f
	call Copy5bytesToAudRegs                                        ; $6d71
	ret                                                             ; $6d74


ContinueSquareEffect7:
; Inc frame counter before processing another step, returning if not 7
	ld   a, [wFrameCounterForSquareEffectStep]                      ; $6d75
	inc  a                                                          ; $6d78
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6d79

	cp   $05                                                        ; $6d7c
	jp   nz, Stub_6f9c                                              ; $6d7e

; Then clear for next step
	xor  a                                                          ; $6d81
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6d82

; Go to new step, then jup to relevant handler
	ld   a, [wCurrSquareEffectStep]                                 ; $6d85
	dec  a                                                          ; $6d88
	ld   [wCurrSquareEffectStep], a                                 ; $6d89

	cp   $03                                                        ; $6d8c
	jp   z, .step3                                                  ; $6d8e

	cp   $02                                                        ; $6d91
	jp   z, .step2                                                  ; $6d93

; Finally stop the effect
	cp   $01                                                        ; $6d96
	jp   StopSquareEffect                                           ; $6d98

.step3:
	ld   hl, SquareEffect7Regs_1                                    ; $6d9b
	ld   c, $10                                                     ; $6d9e
	call Copy5bytesToAudRegs                                        ; $6da0
	ret                                                             ; $6da3

.step2:
	ld   hl, SquareEffect7Regs_2                                    ; $6da4
	ld   c, $10                                                     ; $6da7
	call Copy5bytesToAudRegs                                        ; $6da9
	ret                                                             ; $6dac


ContinueSquareEffect8:
; Inc frame counter before processing another step, returning if not 7
	ld   a, [wFrameCounterForSquareEffectStep]                      ; $6dad
	inc  a                                                          ; $6db0
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6db1

	cp   $02                                                        ; $6db4
	jp   nz, Stub_6f9c                                              ; $6db6

; Then clear for next step
	xor  a                                                          ; $6db9
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6dba

; Go to new step, then jup to relevant handler
	ld   a, [wCurrSquareEffectStep]                                 ; $6dbd
	dec  a                                                          ; $6dc0
	ld   [wCurrSquareEffectStep], a                                 ; $6dc1

	cp   $04                                                        ; $6dc4
	jp   z, .step4                                                  ; $6dc6

	cp   $03                                                        ; $6dc9
	jp   z, .step3                                                  ; $6dcb

	cp   $02                                                        ; $6dce
	jp   z, .step2                                                  ; $6dd0

; Finally stop the effect
	cp   $01                                                        ; $6dd3
	jp   StopSquareEffect                                           ; $6dd5

.step4:
	ld   hl, SquareEffect8Regs_1                                    ; $6dd8
	ld   c, $10                                                     ; $6ddb
	call Copy5bytesToAudRegs                                        ; $6ddd
	ret                                                             ; $6de0

.step3:
	ld   hl, SquareEffect8Regs_2                                    ; $6de1
	ld   c, $10                                                     ; $6de4
	call Copy5bytesToAudRegs                                        ; $6de6
	ret                                                             ; $6de9

.step2:
	ld   hl, SquareEffect8Regs_3                                    ; $6dea
	ld   c, $10                                                     ; $6ded
	call Copy5bytesToAudRegs                                        ; $6def
	ret                                                             ; $6df2


ContinueSquareEffect9:
; Set how much frequency loops up or down
	ld   a, $05                                                     ; $6df3
	ld   [wSweepingSqEffectLoopVal1], a                             ; $6df5
	ld   a, $04                                                     ; $6df8
	ld   [wSweepingSqEffectLoopVal2], a                             ; $6dfa

; Set unchanging vals for other regs
	ld   a, $00                                                     ; $6dfd
	ldh  [rAUD1SWEEP], a                                            ; $6dff
	ld   a, $bf                                                     ; $6e01
	ldh  [rAUD1LEN], a                                              ; $6e03
	ld   a, $40                                                     ; $6e05
	ldh  [rAUD1ENV], a                                              ; $6e07

; With this starting at $ff, starting sweeping up
	ld   a, [wSweepingSqEffectDirection]                            ; $6e09
	cp   $00                                                        ; $6e0c
	jp   z, .loopDown                                               ; $6e0e

.loopUp:
; Inc freq lo, flipping direction when $63 is reached again
	ld   a, [wSweepingSqEffectFreqLo1]                              ; $6e11
	inc  a                                                          ; $6e14
	cp   $63                                                        ; $6e15
	jp   z, .startLoopDown                                          ; $6e17

	ld   [wSweepingSqEffectFreqLo1], a                              ; $6e1a

; Repeat inc 5 times..
	ld   a, [wSweepingSqEffectLoopVal1]                             ; $6e1d
	dec  a                                                          ; $6e20
	ld   [wSweepingSqEffectLoopVal1], a                             ; $6e21

	cp   $00                                                        ; $6e24
	jp   nz, .loopUp                                                ; $6e26

; Then set frequency
	ld   a, [wSweepingSqEffectFreqLo1]                              ; $6e29
	ldh  [rAUD1LOW], a                                              ; $6e2c
	ld   a, [wSweepingSqEffectFreqHi1]                              ; $6e2e
	ldh  [rAUD1HIGH], a                                             ; $6e31
	ret                                                             ; $6e33

.startLoopDown:
	ld   a, $00                                                     ; $6e34
	ld   [wSweepingSqEffectDirection], a                            ; $6e36
	ret                                                             ; $6e39

.loopDown:
; Dec freq lo, finishing when we loop around to $10
	ld   a, [wSweepingSqEffectFreqLo2]                              ; $6e3a
	dec  a                                                          ; $6e3d
	cp   $10                                                        ; $6e3e
	jp   z, .done                                                   ; $6e40

	ld   [wSweepingSqEffectFreqLo2], a                              ; $6e43

; Repeat dec 4 times...
	ld   a, [wSweepingSqEffectLoopVal2]                             ; $6e46
	dec  a                                                          ; $6e49
	ld   [wSweepingSqEffectLoopVal2], a                             ; $6e4a

	cp   $00                                                        ; $6e4d
	jp   nz, .loopDown                                              ; $6e4f

; Then set frequency
	ld   a, [wSweepingSqEffectFreqLo2]                              ; $6e52
	ldh  [rAUD1LOW], a                                              ; $6e55
	ld   a, [wSweepingSqEffectFreqHi1]                              ; $6e57
	ldh  [rAUD1HIGH], a                                             ; $6e5a
	ret                                                             ; $6e5c

.done:
	xor  a                                                          ; $6e5d
	ld   [wSquareEffectBeingPlayed], a                              ; $6e5e
	ldh  [rAUD1ENV], a                                              ; $6e61
	jp   StopSquareEffect                                           ; $6e63


ContinueSquareEffectA:
; Set how much frequency loops up or down
	ld   a, $09                                                     ; $6e66
	ld   [wSweepingSqEffectLoopVal1], a                             ; $6e68
	ld   a, $04                                                     ; $6e6b
	ld   [wSweepingSqEffectLoopVal2], a                             ; $6e6d

; Set unchanging vals for other regs
	ld   a, $00                                                     ; $6e70
	ldh  [rAUD1SWEEP], a                                            ; $6e72
	ld   a, $bf                                                     ; $6e74
	ldh  [rAUD1LEN], a                                              ; $6e76
	ld   a, $90                                                     ; $6e78
	ldh  [rAUD1ENV], a                                              ; $6e7a

; With this starting at $ff, starting sweeping up
	ld   a, [wSweepingSqEffectDirection]                            ; $6e7c
	cp   $00                                                        ; $6e7f
	jp   z, .loopDown                                               ; $6e81

.loopUp:
; Inc freq lo, flipping direction when $89 is reached
	ld   a, [wSweepingSqEffectFreqLo1]                              ; $6e84
	inc  a                                                          ; $6e87
	cp   $89                                                        ; $6e88
	jp   z, .startLoopDown                                          ; $6e8a

	ld   [wSweepingSqEffectFreqLo1], a                              ; $6e8d

; Repeat inc 5 times..
	ld   a, [wSweepingSqEffectLoopVal1]                             ; $6e90
	dec  a                                                          ; $6e93
	ld   [wSweepingSqEffectLoopVal1], a                             ; $6e94

	cp   $00                                                        ; $6e97
	jp   nz, .loopUp                                                ; $6e99

; Then set frequency
	ld   a, [wSweepingSqEffectFreqLo1]                              ; $6e9c
	ldh  [rAUD1LOW], a                                              ; $6e9f
	ld   a, [wSweepingSqEffectFreqHi1]                              ; $6ea1
	ldh  [rAUD1HIGH], a                                             ; $6ea4
	ret                                                             ; $6ea6

.startLoopDown:
	ld   a, $00                                                     ; $6ea7
	ld   [wSweepingSqEffectDirection], a                            ; $6ea9
	ret                                                             ; $6eac

.loopDown:
; Dec freq lo, finishing when we loop to $1e
	ld   a, [wSweepingSqEffectFreqLo2]                              ; $6ead
	dec  a                                                          ; $6eb0
	cp   $1e                                                        ; $6eb1
	jp   z, .done                                                   ; $6eb3

	ld   [wSweepingSqEffectFreqLo2], a                              ; $6eb6

; Repeat dec 4 times...
	ld   a, [wSweepingSqEffectLoopVal2]                             ; $6eb9
	dec  a                                                          ; $6ebc
	ld   [wSweepingSqEffectLoopVal2], a                             ; $6ebd

	cp   $00                                                        ; $6ec0
	jp   nz, .loopDown                                              ; $6ec2

; Then set frequency
	ld   a, [wSweepingSqEffectFreqLo2]                              ; $6ec5
	ldh  [rAUD1LOW], a                                              ; $6ec8
	ld   a, [wSweepingSqEffectFreqHi2]                              ; $6eca
	ldh  [rAUD1HIGH], a                                             ; $6ecd
	ret                                                             ; $6ecf

.done:
	xor  a                                                          ; $6ed0
	ld   [wSquareEffectBeingPlayed], a                              ; $6ed1
	ldh  [rAUD1ENV], a                                              ; $6ed4
	ret                                                             ; $6ed6


ContinueSquareEffectB:
; Set how much frequency loops down
	ld   a, $08                                                     ; $6ed7
	ld   [wSweepingSqEffectLoopVal2], a                             ; $6ed9

; Set unchanging vals for other regs
	ld   a, $00                                                     ; $6edc
	ldh  [rAUD1SWEEP], a                                            ; $6ede
	ld   a, $bf                                                     ; $6ee0
	ldh  [rAUD1LEN], a                                              ; $6ee2
	ld   a, $90                                                     ; $6ee4
	ldh  [rAUD1ENV], a                                              ; $6ee6

.loop:
; Dec freq lo, finishing when we loop to $06
	ld   a, [wSweepingSqEffectFreqLo2]                              ; $6ee8
	dec  a                                                          ; $6eeb
	cp   $06                                                        ; $6eec
	jp   z, .done                                                   ; $6eee

	ld   [wSweepingSqEffectFreqLo2], a                              ; $6ef1

; Repeat dec 8 times...
	ld   a, [wSweepingSqEffectLoopVal2]                             ; $6ef4
	dec  a                                                          ; $6ef7
	ld   [wSweepingSqEffectLoopVal2], a                             ; $6ef8

	cp   $00                                                        ; $6efb
	jp   nz, .loop                                                  ; $6efd

; Then set frequency
	ld   a, [wSweepingSqEffectFreqLo2]                              ; $6f00
	ldh  [rAUD1LOW], a                                              ; $6f03
	ld   a, [wSweepingSqEffectFreqHi2]                              ; $6f05
	ldh  [rAUD1HIGH], a                                             ; $6f08
	ret                                                             ; $6f0a

.done:
	xor  a                                                          ; $6f0b
	ld   [wSquareEffectBeingPlayed], a                              ; $6f0c
	ldh  [rAUD1ENV], a                                              ; $6f0f
	ld   [wPlayingShortenedPaddleSqEffect], a                       ; $6f11
	jp   StopSquareEffect                                           ; $6f14


UnusedStub_6f17:
	ret                                                             ; $6f17


ContinueSquareEffectC:
; Set how much frequency loops up or down
	ld   a, $28                                                     ; $6f18
	ld   [wSweepingSqEffectLoopVal1], a                             ; $6f1a
	ld   a, $28                                                     ; $6f1d
	ld   [wSweepingSqEffectLoopVal2], a                             ; $6f1f

; Set unchanging vals for other regs
	ld   a, $00                                                     ; $6f22
	ldh  [rAUD1SWEEP], a                                            ; $6f24
	ld   a, $bf                                                     ; $6f26
	ldh  [rAUD1LEN], a                                              ; $6f28
	ld   a, $40                                                     ; $6f2a
	ldh  [rAUD1ENV], a                                              ; $6f2c

; With this starting at $ff, starting sweeping down
	ld   a, [wSweepingSqEffectDirection]                            ; $6f2e
	cp   $00                                                        ; $6f31
	jp   z, .loopUp                                                 ; $6f33

.loopDown:
; Dec freq lo, flipping direction when $10 is reached
	ld   a, [wSweepingSqEffectFreqLo1]                              ; $6f36
	dec  a                                                          ; $6f39
	cp   $10                                                        ; $6f3a
	jp   z, .startLoopUp                                            ; $6f3c

	ld   [wSweepingSqEffectFreqLo1], a                              ; $6f3f

; Repeat dec $28 times...
	ld   a, [wSweepingSqEffectLoopVal1]                             ; $6f42
	dec  a                                                          ; $6f45
	ld   [wSweepingSqEffectLoopVal1], a                             ; $6f46

	cp   $00                                                        ; $6f49
	jp   nz, .loopDown                                              ; $6f4b

; Then set frequency
	ld   a, [wSweepingSqEffectFreqLo1]                              ; $6f4e
	ldh  [rAUD1LOW], a                                              ; $6f51
	ld   a, [wSweepingSqEffectFreqHi1]                              ; $6f53
	ldh  [rAUD1HIGH], a                                             ; $6f56
	ret                                                             ; $6f58

.startLoopUp:
	ld   a, $00                                                     ; $6f59
	ld   [wSweepingSqEffectDirection], a                            ; $6f5b
	ret                                                             ; $6f5e

.loopUp:
; Inc freq lo, finishing when $63 is reached
	ld   a, [wSweepingSqEffectFreqLo2]                              ; $6f5f
	inc  a                                                          ; $6f62
	cp   $63                                                        ; $6f63
	jp   z, .done                                                   ; $6f65

	ld   [wSweepingSqEffectFreqLo2], a                              ; $6f68

; Repeat inc $28 times...
	ld   a, [wSweepingSqEffectLoopVal2]                             ; $6f6b
	dec  a                                                          ; $6f6e
	ld   [wSweepingSqEffectLoopVal2], a                             ; $6f6f

	cp   $00                                                        ; $6f72
	jp   nz, .loopUp                                                ; $6f74

; Then set frequency
	ld   a, [wSweepingSqEffectFreqLo2]                              ; $6f77
	ldh  [rAUD1LOW], a                                              ; $6f7a
	ld   a, [wSweepingSqEffectFreqHi1]                              ; $6f7c
	ldh  [rAUD1HIGH], a                                             ; $6f7f
	ret                                                             ; $6f81

.done:
	xor  a                                                          ; $6f82
	ld   [wSquareEffectBeingPlayed], a                              ; $6f83
	ldh  [rAUD1ENV], a                                              ; $6f86
	jp   StopSquareEffect                                           ; $6f88


UnusedClear_dff4h:
	call Clear_dff4h                                                ; $6f8b
	ret                                                             ; $6f8e


StopSquareEffect:
	xor  a                                                          ; $6f8f
	ld   [wSquareEffectBeingPlayed], a                              ; $6f90
	ldh  [rAUD1ENV], a                                              ; $6f93
	ld   [wFrameCounterForSquareEffectStep], a                      ; $6f95
	ld   [wCurrSquareEffectStep], a                                 ; $6f98
	ret                                                             ; $6f9b


Stub_6f9c:
	ret                                                             ; $6f9c


; C - 1st aud reg low byte
; HL - src of 5 bytes
Copy5bytesToAudRegs:
	ld   a, [hl+]                                                   ; $6f9d
	ldh  [c], a                                                     ; $6f9e
	inc  c                                                          ; $6f9f

	ld   a, [hl+]                                                   ; $6fa0
	ldh  [c], a                                                     ; $6fa1
	inc  c                                                          ; $6fa2

	ld   a, [hl+]                                                   ; $6fa3
	ldh  [c], a                                                     ; $6fa4
	inc  c                                                          ; $6fa5

	ld   a, [hl+]                                                   ; $6fa6
	ldh  [c], a                                                     ; $6fa7
	inc  c                                                          ; $6fa8

	ld   a, [hl]                                                    ; $6fa9
	ldh  [c], a                                                     ; $6faa
	ret                                                             ; $6fab


SquareEffect4Regs_0:
	db $00, $81, $72, $4b, $c7


SquareEffect4Regs_1:
	db $00, $81, $15, $4b, $c7


SquareEffect4Regs_2:
	db $00, $81, $17, $4b, $c7


SquareEffect2Regs_0:
	db $00, $81, $72, $7b, $c7


SquareEffect2Regs_1:
	db $00, $81, $15, $7b, $c7


SquareEffect2Regs_2:
	db $00, $81, $17, $7b, $c7


SquareEffect3Regs_0:
	db $00, $81, $c2, $ac, $c7


SquareEffect3Regs_1:
	db $00, $81, $c2, $be, $c7


SquareEffect3Regs_2:
	db $00, $81, $95, $be, $c7


SquareEffect3Regs_3:
	db $00, $81, $48, $be, $c7


SquareEffect1Regs_0:
	db $00, $71, $f2, $59, $87


SquareEffect1Regs_1:
	db $00, $7f, $f2, $83, $87


SquareEffect1Regs_2:
	db $00, $bf, $f2, $9d, $87


SquareEffect1Regs_3:
	db $00, $bf, $f2, $83, $87


SquareEffect1Regs_4:
	db $00, $bf, $f2, $90, $87


SquareEffect1Regs_5:
	db $00, $bf, $f2, $ac, $87


SquareEffect5Regs_0:
	db $00, $81, $72, $97, $c7


SquareEffect5Regs_1:
	db $00, $81, $15, $97, $c7


SquareEffect5Regs_2:
	db $00, $81, $17, $97, $c7


SquareEffect6Regs_0:
	db $00, $81, $72, $a7, $c7


SquareEffect6Regs_1:
	db $00, $81, $15, $a7, $c7


SquareEffect6Regs_2:
	db $00, $81, $17, $a7, $c7


SquareEffect7Regs_0:
	db $1a, $81, $f0, $9d, $c7


SquareEffect7Regs_1:
	db $19, $83, $72, $9e, $c7


SquareEffect7Regs_2:
	db $12, $43, $3a, $9f, $c7


SquareEffect8Regs_0:
	db $00, $81, $72, $7f, $c7


SquareEffect8Regs_1:
	db $00, $81, $15, $7f, $c7


SquareEffect8Regs_2:
	db $00, $81, $72, $7f, $c7


SquareEffect8Regs_3:
	db $00, $81, $17, $7f, $c7


UnusedSquareEffectRegs_703d:
	db $1a, $81, $f0, $e9, $c7
	

UnusedSquareEffectRegs_7042:
	db $19, $83, $72, $e9, $c7
	

UnusedSquareEffectRegs_7047:
	db $12, $43, $3a, $e9, $c7


NoiseRegs_704c:
	db $00, $f7, $57, $80


UpdateNoiseEffect:
; Check if effect to play is the only effect
	ld   a, [wNoiseEffectToPlay]                                    ; $7050
	cp   $01                                                        ; $7053
	jp   z, .startNoiseEffect1                                      ; $7055

; Else just handle aud term
	call ProcessAlternatingAudTermWithNoise                         ; $7058
	ret                                                             ; $705b

.startNoiseEffect1:
; Set vars for below copy
	ld   hl, NoiseRegs_704c                                         ; $705c
	ld   c, LOW(rAUD4LEN)                                           ; $705f

; Set counter until alternating aud term is done
	ld   a, $49                                                     ; $7061
	ld   [wAlternatingAudTermWithNoiseCounter], a                   ; $7063

; Set bits such that we alternate aud term every 4 frames
	ld   a, $0f                                                     ; $7066
	ld   [wBitsSetIfAudTermWithNoiseOnSO1], a                       ; $7068

; Clear flag so other alternating aud term flag is not processed
	xor  a                                                          ; $706b
	ld   [wIsAlternatingAudTerm], a                                 ; $706c

	call Copy4bytesToAudRegs                                        ; $706f
	ret                                                             ; $7072


; C - 1st aud reg low byte
; HL - src of 4 bytes
Copy4bytesToAudRegs:
	ld   a, [hl+]                                                   ; $7073
	ldh  [c], a                                                     ; $7074
	inc  c                                                          ; $7075

	ld   a, [hl+]                                                   ; $7076
	ldh  [c], a                                                     ; $7077
	inc  c                                                          ; $7078

	ld   a, [hl+]                                                   ; $7079
	ldh  [c], a                                                     ; $707a
	inc  c                                                          ; $707b
	
	ld   a, [hl+]                                                   ; $707c
	ldh  [c], a                                                     ; $707d
	ret                                                             ; $707e


ProcessAlternatingAudTermWithNoise:
; If counter == 0, do nothing, else dec it
	ld   a, [wAlternatingAudTermWithNoiseCounter]                   ; $707f
	cp   $00                                                        ; $7082
	jp   z, .done                                                   ; $7084

	dec  a                                                          ; $7087
	ld   [wAlternatingAudTermWithNoiseCounter], a                   ; $7088

; If counter is now 0, output to both terms
	cp   $00                                                        ; $708b
	jp   z, .outputAllToBothTerms                                   ; $708d

; Check bit set on this var to determine which term to output to
	ld   a, [wBitsSetIfAudTermWithNoiseOnSO1]                       ; $7090
	rlc  a                                                          ; $7093
	ld   [wBitsSetIfAudTermWithNoiseOnSO1], a                       ; $7095

	jp   nc, .outputAllToSO2                                        ; $7098

; Only SO1 active
	ld   a, $0f                                                     ; $709b
	ldh  [rAUDTERM], a                                              ; $709d
	ret                                                             ; $709f

.outputAllToSO2:
	ld   a, $f0                                                     ; $70a0
	ldh  [rAUDTERM], a                                              ; $70a2
	ret                                                             ; $70a4

.outputAllToBothTerms:
	ld   a, $ff                                                     ; $70a5
	ldh  [rAUDTERM], a                                              ; $70a7

.done:
	xor  a                                                          ; $70a9
	ld   [wAlternatingAudTermWithNoiseCounter], a                   ; $70aa
	ret                                                             ; $70ad


UpdateMusic:
; If song to start is non-0, set some data for it
	ld   a, [wSongToStart]                                          ; $70ae
	cp   $01                                                        ; $70b1
	jp   z, .song1                                                  ; $70b3

	cp   $02                                                        ; $70b6
	jp   z, .song2                                                  ; $70b8

	cp   $03                                                        ; $70bb
	jp   z, .song3                                                  ; $70bd

	cp   $04                                                        ; $70c0
	jp   z, .song4                                                  ; $70c2

	cp   $05                                                        ; $70c5
	jp   z, .song5                                                  ; $70c7

	cp   $06                                                        ; $70ca
	jp   z, .song6                                                  ; $70cc

	cp   $07                                                        ; $70cf
	jp   z, .song7                                                  ; $70d1

	cp   $08                                                        ; $70d4
	jp   z, .song8                                                  ; $70d6

	cp   $09                                                        ; $70d9
	jp   z, .song9                                                  ; $70db

	cp   $0a                                                        ; $70de
	jp   z, .songA                                                  ; $70e0

	cp   $0b                                                        ; $70e3
	jp   z, .songB                                                  ; $70e5

	cp   $0c                                                        ; $70e8
	jp   z, .songC                                                  ; $70ea

; While there is a song to loop to, update the 2 song channels
	ld   a, [wSongToLoopTo]                                         ; $70ed
	cp   $00                                                        ; $70f0
	jp   nz, UpdateSq2andWav                                        ; $70f2

; If there isn't, but wav can be updated, process that
	ld   a, [wCurrSongUsesWavChannel]                               ; $70f5
	cp   $00                                                        ; $70f8
	jp   nz, StartProcessingWavChannel                              ; $70fa

	ret                                                             ; $70fd

.song1:
; Set up to loop to this song
	ld   a, $01                                                     ; $70fe
	ld   [wSongToLoopTo], a                                         ; $7100
	ld   [wCurrSongUsesWavChannel], a                               ; $7103

; Process sound data bytes immediately
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $7106
	ld   [wCounterUntilReadingNewWavByte], a                        ; $7109

; Set up alternating aud term
	ld   [wUnusedVar_dff8], a                                       ; $710c
	ld   [wIsAlternatingAudTerm], a                                 ; $710f
	ld   [wUnusedVar_dfd6], a                                       ; $7112
	ld   [wAlternatingAudTermMainlyOnSO2], a                        ; $7115
	ld   a, $60                                                     ; $7118
	ld   [wCurrAlternatingAudTermCounter], a                        ; $711a
	ld   [wBaseAlternatingAudTermCounter], a                        ; $711d

; Set sq2 and wav source address, then start processing them
	ld   hl, Song1_Sq2Data                                          ; $7120
	ld   a, h                                                       ; $7123
	ld   [wSq2DataAddress], a                                       ; $7124
	ld   a, l                                                       ; $7127
	ld   [wSq2DataAddress+1], a                                     ; $7128

	ld   hl, Song1_WavData                                          ; $712b
	ld   a, h                                                       ; $712e
	ld   [wWavDataAddress], a                                       ; $712f
	ld   a, l                                                       ; $7132
	ld   [wWavDataAddress+1], a                                     ; $7133

	call UpdateSq2andWav                                            ; $7136
	ret                                                             ; $7139

.song2:
; No alternating aud term
	ld   a, $ff                                                     ; $713a
	ldh  [rAUDTERM], a                                              ; $713c
	xor  a                                                          ; $713e
	ld   [wIsAlternatingAudTerm], a                                 ; $713f

; Set up to loop to this song
	ld   a, $02                                                     ; $7142
	ld   [wSongToLoopTo], a                                         ; $7144
	ld   [wCurrSongUsesWavChannel], a                               ; $7147

; Process sound data bytes immediately
	ld   a, $01                                                     ; $714a
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $714c
	ld   [wCounterUntilReadingNewWavByte], a                        ; $714f
	ld   [wUnusedVar_dff8], a                                       ; $7152

; Set sq2 and wav source address, then start processing them
	ld   hl, Song2_Sq2Data                                          ; $7155
	ld   a, h                                                       ; $7158
	ld   [wSq2DataAddress], a                                       ; $7159
	ld   a, l                                                       ; $715c
	ld   [wSq2DataAddress+1], a                                     ; $715d

	ld   hl, Song2_WavData                                          ; $7160
	ld   a, h                                                       ; $7163
	ld   [wWavDataAddress], a                                       ; $7164
	ld   a, l                                                       ; $7167
	ld   [wWavDataAddress+1], a                                     ; $7168

	call UpdateSq2andWav                                            ; $716b
	ret                                                             ; $716e

.song3:
; Set up to loop to this song
	ld   a, $03                                                     ; $716f
	ld   [wSongToLoopTo], a                                         ; $7171
	ld   [wCurrSongUsesWavChannel], a                               ; $7174

; Process sound data bytes immediately
	ld   a, $01                                                     ; $7177
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $7179
	ld   [wCounterUntilReadingNewWavByte], a                        ; $717c

; Set up alternating aud term
	ld   [wUnusedVar_dff8], a                                       ; $717f
	ld   [wIsAlternatingAudTerm], a                                 ; $7182
	ld   [wUnusedVar_dfd6], a                                       ; $7185
	ld   [wAlternatingAudTermMainlyOnSO2], a                        ; $7188

	ld   a, $60                                                     ; $718b
	ld   [wCurrAlternatingAudTermCounter], a                        ; $718d
	ld   [wBaseAlternatingAudTermCounter], a                        ; $7190

; Set sq2 and wav source address, then start processing them
	ld   hl, Song3_Sq2Data                                          ; $7193
	ld   a, h                                                       ; $7196
	ld   [wSq2DataAddress], a                                       ; $7197
	ld   a, l                                                       ; $719a
	ld   [wSq2DataAddress+1], a                                     ; $719b

	ld   hl, Song3_WavData                                          ; $719e
	ld   a, h                                                       ; $71a1
	ld   [wWavDataAddress], a                                       ; $71a2
	ld   a, l                                                       ; $71a5
	ld   [wWavDataAddress+1], a                                     ; $71a6

	call UpdateSq2andWav                                            ; $71a9
	ret                                                             ; $71ac

.song4:
; No alternating aud term
	xor  a                                                          ; $71ad
	ld   [wIsAlternatingAudTerm], a                                 ; $71ae

; Set up to loop to this song
	ld   a, $04                                                     ; $71b1
	ld   [wSongToLoopTo], a                                         ; $71b3
	ld   [wCurrSongUsesWavChannel], a                               ; $71b6

; Process sound data bytes immediately
	ld   a, $01                                                     ; $71b9
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $71bb
	ld   [wCounterUntilReadingNewWavByte], a                        ; $71be
	ld   [wUnusedVar_dff8], a                                       ; $71c1

; Set sq2 and wav source address, then start processing them
	ld   hl, Song4_Sq2Data                                          ; $71c4
	ld   a, h                                                       ; $71c7
	ld   [wSq2DataAddress], a                                       ; $71c8
	ld   a, l                                                       ; $71cb
	ld   [wSq2DataAddress+1], a                                     ; $71cc

	ld   hl, Song4_WavData                                          ; $71cf
	ld   a, h                                                       ; $71d2
	ld   [wWavDataAddress], a                                       ; $71d3
	ld   a, l                                                       ; $71d6
	ld   [wWavDataAddress+1], a                                     ; $71d7

	call UpdateSq2andWav                                            ; $71da
	ret                                                             ; $71dd

.song5:
; No alternating aud term
	ld   a, $ff                                                     ; $71de
	ldh  [rAUDTERM], a                                              ; $71e0
	xor  a                                                          ; $71e2
	ld   [wIsAlternatingAudTerm], a                                 ; $71e3

; Set up to loop to this song
	ld   a, $05                                                     ; $71e6
	ld   [wSongToLoopTo], a                                         ; $71e8
	ld   [wCurrSongUsesWavChannel], a                               ; $71eb

; Process sound data bytes immediately
	ld   a, $01                                                     ; $71ee
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $71f0
	ld   [wCounterUntilReadingNewWavByte], a                        ; $71f3
	ld   [wUnusedVar_dff8], a                                       ; $71f6

; Set sq2 and wav source address, then start processing them
	ld   hl, Song5_Sq2Data                                          ; $71f9
	ld   a, h                                                       ; $71fc
	ld   [wSq2DataAddress], a                                       ; $71fd
	ld   a, l                                                       ; $7200
	ld   [wSq2DataAddress+1], a                                     ; $7201

	ld   hl, Song5_WavData                                          ; $7204
	ld   a, h                                                       ; $7207
	ld   [wWavDataAddress], a                                       ; $7208
	ld   a, l                                                       ; $720b
	ld   [wWavDataAddress+1], a                                     ; $720c

	call UpdateSq2andWav                                            ; $720f
	ret                                                             ; $7212

.song6:
; Set up to loop to this song
	ld   a, $06                                                     ; $7213
	ld   [wSongToLoopTo], a                                         ; $7215
	ld   [wCurrSongUsesWavChannel], a                               ; $7218

; Process sound data bytes immediately
	ld   a, $01                                                     ; $721b
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $721d
	ld   [wCounterUntilReadingNewWavByte], a                        ; $7220

; Set up alternating aud term
	ld   [wUnusedVar_dff8], a                                       ; $7223
	ld   [wIsAlternatingAudTerm], a                                 ; $7226
	ld   [wUnusedVar_dfd6], a                                       ; $7229
	ld   [wAlternatingAudTermMainlyOnSO2], a                        ; $722c
	ld   a, $28                                                     ; $722f
	ld   [wCurrAlternatingAudTermCounter], a                        ; $7231
	ld   [wBaseAlternatingAudTermCounter], a                        ; $7234

; Set sq2 and wav source address, then start processing them
	ld   hl, Song6_Sq2Data                                          ; $7237
	ld   a, h                                                       ; $723a
	ld   [wSq2DataAddress], a                                       ; $723b
	ld   a, l                                                       ; $723e
	ld   [wSq2DataAddress+1], a                                     ; $723f

	ld   hl, Song6_WavData                                          ; $7242
	ld   a, h                                                       ; $7245
	ld   [wWavDataAddress], a                                       ; $7246
	ld   a, l                                                       ; $7249
	ld   [wWavDataAddress+1], a                                     ; $724a

	call UpdateSq2andWav                                            ; $724d
	ret                                                             ; $7250

.song7:
; Set up to loop to this song
	ld   a, $07                                                     ; $7251
	ld   [wSongToLoopTo], a                                         ; $7253
	ld   [wCurrSongUsesWavChannel], a                               ; $7256

; Process sound data bytes immediately
	ld   a, $01                                                     ; $7259
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $725b
	ld   [wCounterUntilReadingNewWavByte], a                        ; $725e

; Set up alternating aud term
	ld   [wUnusedVar_dff8], a                                       ; $7261
	ld   [wIsAlternatingAudTerm], a                                 ; $7264
	ld   [wUnusedVar_dfd6], a                                       ; $7267
	ld   [wAlternatingAudTermMainlyOnSO2], a                        ; $726a
	ld   a, $20                                                     ; $726d
	ld   [wCurrAlternatingAudTermCounter], a                        ; $726f
	ld   [wBaseAlternatingAudTermCounter], a                        ; $7272

; Set sq2 and wav source address, then start processing them
	ld   hl, Song7_Sq2Data                                          ; $7275
	ld   a, h                                                       ; $7278
	ld   [wSq2DataAddress], a                                       ; $7279
	ld   a, l                                                       ; $727c
	ld   [wSq2DataAddress+1], a                                     ; $727d

	ld   hl, Song7_WavData                                          ; $7280
	ld   a, h                                                       ; $7283
	ld   [wWavDataAddress], a                                       ; $7284
	ld   a, l                                                       ; $7287
	ld   [wWavDataAddress+1], a                                     ; $7288

	call UpdateSq2andWav                                            ; $728b
	ret                                                             ; $728e

.song8:
; No alternating aud term
	xor  a                                                          ; $728f
	ld   [wIsAlternatingAudTerm], a                                 ; $7290

; Set up to loop to song 6
	ld   a, $06                                                     ; $7293
	ld   [wSongToLoopTo], a                                         ; $7295
	ld   [wCurrSongUsesWavChannel], a                               ; $7298

; Process sound data bytes immediately
	ld   a, $01                                                     ; $729b
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $729d
	ld   [wCounterUntilReadingNewWavByte], a                        ; $72a0
	ld   [wUnusedVar_dff8], a                                       ; $72a3

; Set sq2 and wav source address, then start processing them
	ld   hl, Song8_Sq2Data                                          ; $72a6
	ld   a, h                                                       ; $72a9
	ld   [wSq2DataAddress], a                                       ; $72aa
	ld   a, l                                                       ; $72ad
	ld   [wSq2DataAddress+1], a                                     ; $72ae

	ld   hl, Song8_WavData                                          ; $72b1
	ld   a, h                                                       ; $72b4
	ld   [wWavDataAddress], a                                       ; $72b5
	ld   a, l                                                       ; $72b8
	ld   [wWavDataAddress+1], a                                     ; $72b9

	call UpdateSq2andWav                                            ; $72bc
	ret                                                             ; $72bf

.song9:
; No alternating aud term
	xor  a                                                          ; $72c0
	ld   [wIsAlternatingAudTerm], a                                 ; $72c1
	ld   a, $ff                                                     ; $72c4
	ldh  [rAUDTERM], a                                              ; $72c6

; Set up to loop to song 6
	ld   a, $06                                                     ; $72c8
	ld   [wSongToLoopTo], a                                         ; $72ca
	ld   [wCurrSongUsesWavChannel], a                               ; $72cd

	ld   a, $01                                                     ; $72d0
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $72d2
	ld   [wCounterUntilReadingNewWavByte], a                        ; $72d5
	ld   [wUnusedVar_dff8], a                                       ; $72d8

; Set sq2 and wav source address, then start processing them
	ld   hl, Song9_Sq2Data                                          ; $72db
	ld   a, h                                                       ; $72de
	ld   [wSq2DataAddress], a                                       ; $72df
	ld   a, l                                                       ; $72e2
	ld   [wSq2DataAddress+1], a                                     ; $72e3

	ld   hl, Song9_WavData                                          ; $72e6
	ld   a, h                                                       ; $72e9
	ld   [wWavDataAddress], a                                       ; $72ea
	ld   a, l                                                       ; $72ed
	ld   [wWavDataAddress+1], a                                     ; $72ee

	call UpdateSq2andWav                                            ; $72f1
	ret                                                             ; $72f4

.songA:
; No alternating aud term
	xor  a                                                          ; $72f5
	ld   [wIsAlternatingAudTerm], a                                 ; $72f6
	ld   a, $ff                                                     ; $72f9
	ldh  [rAUDTERM], a                                              ; $72fb

; Set up to loop to song 6
	ld   a, $06                                                     ; $72fd
	ld   [wSongToLoopTo], a                                         ; $72ff
	ld   [wCurrSongUsesWavChannel], a                               ; $7302

; Process sound data bytes immediately
	ld   a, $01                                                     ; $7305
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $7307
	ld   [wCounterUntilReadingNewWavByte], a                        ; $730a
	ld   [wUnusedVar_dff8], a                                       ; $730d

; Set sq2 and wav source address, then start processing them
	ld   hl, SongA_Sq2Data                                          ; $7310
	ld   a, h                                                       ; $7313
	ld   [wSq2DataAddress], a                                       ; $7314
	ld   a, l                                                       ; $7317
	ld   [wSq2DataAddress+1], a                                     ; $7318

	ld   hl, SongA_WavData                                          ; $731b
	ld   a, h                                                       ; $731e
	ld   [wWavDataAddress], a                                       ; $731f
	ld   a, l                                                       ; $7322
	ld   [wWavDataAddress+1], a                                     ; $7323

	call UpdateSq2andWav                                            ; $7326
	ret                                                             ; $7329

.songB:
; No alternating aud term
	xor  a                                                          ; $732a
	ld   [wIsAlternatingAudTerm], a                                 ; $732b

; Set up to loop to song 6
	ld   a, $06                                                     ; $732e
	ld   [wSongToLoopTo], a                                         ; $7330
	ld   [wCurrSongUsesWavChannel], a                               ; $7333

; Process sound data bytes immediately
	ld   a, $01                                                     ; $7336
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $7338
	ld   [wCounterUntilReadingNewWavByte], a                        ; $733b
	ld   [wUnusedVar_dff8], a                                       ; $733e

; Set sq2 and wav source address, then start processing them
	ld   hl, SongB_Sq2Data                                          ; $7341
	ld   a, h                                                       ; $7344
	ld   [wSq2DataAddress], a                                       ; $7345
	ld   a, l                                                       ; $7348
	ld   [wSq2DataAddress+1], a                                     ; $7349

	ld   hl, SongB_WavData                                          ; $734c
	ld   a, h                                                       ; $734f
	ld   [wWavDataAddress], a                                       ; $7350
	ld   a, l                                                       ; $7353
	ld   [wWavDataAddress+1], a                                     ; $7354

	call UpdateSq2andWav                                            ; $7357
	ret                                                             ; $735a

.songC:
; No alternating aud term
	xor  a                                                          ; $735b
	ld   [wIsAlternatingAudTerm], a                                 ; $735c

; Set up to loop to song 6
	ld   a, $06                                                     ; $735f
	ld   [wSongToLoopTo], a                                         ; $7361
	ld   [wCurrSongUsesWavChannel], a                               ; $7364

; Process sound data bytes immediately
	ld   a, $01                                                     ; $7367
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $7369
	ld   [wCounterUntilReadingNewWavByte], a                        ; $736c
	ld   [wUnusedVar_dff8], a                                       ; $736f

; Set sq2 and wav source address, then start processing them
	ld   hl, SongC_Sq2Data                                          ; $7372
	ld   a, h                                                       ; $7375
	ld   [wSq2DataAddress], a                                       ; $7376
	ld   a, l                                                       ; $7379
	ld   [wSq2DataAddress+1], a                                     ; $737a

	ld   hl, SongC_WavData                                          ; $737d
	ld   a, h                                                       ; $7380
	ld   [wWavDataAddress], a                                       ; $7381
	ld   a, l                                                       ; $7384
	ld   [wWavDataAddress+1], a                                     ; $7385
	
	call UpdateSq2andWav                                            ; $7388
	ret                                                             ; $738b


UpdateSq2andWav:
; Dec counter until updating sq 2, returning if not 0
	ld   a, [wCounterUntilReadingNewSq2Byte]                        ; $738c
	dec  a                                                          ; $738f
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $7390

	cp   $00                                                        ; $7393
	jp   nz, StartProcessingWavChannel                              ; $7395

; HL = address of sq 2 data
	ld   a, [wSq2DataAddress]                                       ; $7398
	ld   h, a                                                       ; $739b
	ld   a, [wSq2DataAddress+1]                                     ; $739c
	ld   l, a                                                       ; $739f

Sq2ByteCont:
; Branch based on wav data byte
	ld   a, [hl+]                                                   ; $73a0
	bit  7, a                                                       ; $73a1
	jp   nz, SetSq2PerByteCounter                                   ; $73a3

	cp   $00                                                        ; $73a6
	jp   z, Sq2ByteEqu0_StopSq2                                     ; $73a8

	cp   $7f                                                        ; $73ab
	jp   z, StartSongToLoopTo                                       ; $73ad

; If not above, or 1, it is a new frequency idx
	cp   $01                                                        ; $73b0
	jp   nz, .setSq2Regs                                            ; $73b2

; If data byte == 1, mute wav, and skip setting regs
	call ClearSq2Env                                                ; $73b5
	jr   .sq2End                                                    ; $73b8

.setSq2Regs:
	ld   [wSq2FrequencyIdx], a                                      ; $73ba

; Max len with 50% pattern, max envelope with 2 sweeps
	ld   a, $bf                                                     ; $73bd
	ldh  [rAUD2LEN], a                                              ; $73bf
	ld   a, $f2                                                     ; $73c1
	ldh  [rAUD2ENV], a                                              ; $73c3

; Set sq 2 frequency from idx into hi/lo tables
	ld   a, [wSq2FrequencyIdx]                                      ; $73c5
	push hl                                                         ; $73c8
	
	ld   hl, FrequencyLo                                            ; $73c9
	ld   d, $00                                                     ; $73cc
	ld   e, a                                                       ; $73ce
	add  hl, de                                                     ; $73cf
	ld   a, [hl]                                                    ; $73d0
	ldh  [rAUD2LOW], a                                              ; $73d1

	ld   hl, FrequencyHi                                            ; $73d3
	add  hl, de                                                     ; $73d6
	ld   a, [hl]                                                    ; $73d7
	ldh  [rAUD2HIGH], a                                             ; $73d8
	pop  hl                                                         ; $73da

.sq2End:
; Save sq 2 data address
	xor  a                                                          ; $73db
	ld   a, h                                                       ; $73dc
	ld   [wSq2DataAddress], a                                       ; $73dd
	ld   a, l                                                       ; $73e0
	ld   [wSq2DataAddress+1], a                                     ; $73e1

; When counter to next byte == 0, reset it to the base counter
	ld   a, [wCounterUntilReadingNewSq2Byte]                        ; $73e4
	and  a                                                          ; $73e7
	jr   nz, StartProcessingWavChannel                              ; $73e8

	ld   a, [wBaseCounterPerSq2Byte]                                ; $73ea
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $73ed

StartProcessingWavChannel:
; Dec counter until updating wav, returning if not 0
	ld   a, [wCounterUntilReadingNewWavByte]                        ; $73f0
	dec  a                                                          ; $73f3
	ld   [wCounterUntilReadingNewWavByte], a                        ; $73f4

	cp   $00                                                        ; $73f7
	jp   nz, EndUpdateSq2AndWav                                     ; $73f9

; HL = address of wav data
	ld   a, [wWavDataAddress]                                       ; $73fc
	ld   h, a                                                       ; $73ff
	ld   a, [wWavDataAddress+1]                                     ; $7400
	ld   l, a                                                       ; $7403

WavByteCont:
; Branch based on wav data byte
	ld   a, [hl+]                                                   ; $7404
	bit  7, a                                                       ; $7405
	jp   nz, SetWavPerByteCounter                                   ; $7407

	cp   $00                                                        ; $740a
	jp   z, WavByteEqu0_StopWav                                     ; $740c

	cp   $7f                                                        ; $740f
	jp   z, StartSongToLoopTo                                       ; $7411

; If not above, or 1, it is a new frequency idx
	cp   $01                                                        ; $7414
	jp   nz, .setWavRegs                                            ; $7416

; If data byte == 1, mute wav, and skip setting regs
	call DisableWav                                                 ; $7419
	jr   .wavEnd                                                    ; $741c

.setWavRegs:
	ld   [wWavFrequencyIdx], a                                      ; $741e

; Restart wav channel
	push hl                                                         ; $7421
	ld   a, $00                                                     ; $7422
	ldh  [rAUD3ENA], a                                              ; $7424
	ld   a, $80                                                     ; $7426
	ldh  [rAUD3ENA], a                                              ; $7428

; Set max sound length, update wav ram, and set highest volume
	ld   a, $ff                                                     ; $742a
	ldh  [rAUD3LEN], a                                              ; $742c

	call UpdateWavRam                                               ; $742e

	ld   a, $20                                                     ; $7431
	ldh  [rAUD3LEVEL], a                                            ; $7433

; Set wav frequency from idx into hi/lo tables
	ld   a, [wWavFrequencyIdx]                                      ; $7435

	ld   hl, FrequencyLo                                            ; $7438
	ld   d, $00                                                     ; $743b
	ld   e, a                                                       ; $743d
	add  hl, de                                                     ; $743e
	ld   a, [hl]                                                    ; $743f
	ldh  [rAUD3LOW], a                                              ; $7440
	
	ld   hl, FrequencyHi                                            ; $7442
	add  hl, de                                                     ; $7445
	ld   a, [hl]                                                    ; $7446
	ldh  [rAUD3HIGH], a                                             ; $7447
	pop  hl                                                         ; $7449

.wavEnd:
; Save wav data address
	ld   a, h                                                       ; $744a
	ld   [wWavDataAddress], a                                       ; $744b
	ld   a, l                                                       ; $744e
	ld   [wWavDataAddress+1], a                                     ; $744f

; When counter to next byte == 0, reset it to the base counter
	ld   a, [wCounterUntilReadingNewWavByte]                        ; $7452
	and  a                                                          ; $7455
	jr   nz, EndUpdateSq2AndWav                                     ; $7456

	ld   a, [wBaseCounterPerWavByte]                                ; $7458
	ld   [wCounterUntilReadingNewWavByte], a                        ; $745b

EndUpdateSq2AndWav:
	ret                                                             ; $745e


UpdateWavRam:
	ld   hl, DefaultWavRam                                          ; $745f
	ld   c, LOW(_AUD3WAVERAM)                                       ; $7462

.loop:
; Set 1 byte of wav ram
	ld   a, [hl+]                                                   ; $7464
	ldh  [c], a                                                     ; $7465
	inc  c                                                          ; $7466

; Inc idx and exit once all bytes are done
	ld   a, [wWavRamIdxToSet]                                       ; $7467
	inc  a                                                          ; $746a
	ld   [wWavRamIdxToSet], a                                       ; $746b

	cp   $10                                                        ; $746e
	jp   nz, .loop                                                  ; $7470

; Clear idx for next time this is called
	xor  a                                                          ; $7473
	ld   [wWavRamIdxToSet], a                                       ; $7474
	ret                                                             ; $7477


SetSq2PerByteCounter:
	push hl                                                         ; $7478

; Value without bit 7 set, is the idx into the tempo table
	and  $7f                                                        ; $7479
	ld   hl, TempoTable                                             ; $747b
	ld   d, $00                                                     ; $747e
	ld   e, a                                                       ; $7480
	add  hl, de                                                     ; $7481

; Get value and set both base and curr counter
	ld   a, [hl]                                                    ; $7482
	ld   [wCounterUntilReadingNewSq2Byte], a                        ; $7483
	ld   [wBaseCounterPerSq2Byte], a                                ; $7486

	pop  hl                                                         ; $7489
	jp   Sq2ByteCont                                                ; $748a


SetWavPerByteCounter:
	push hl                                                         ; $748d

; Value without bit 7 set, is the idx into the tempo table
	and  $7f                                                        ; $748e
	ld   hl, TempoTable                                             ; $7490
	ld   d, $00                                                     ; $7493
	ld   e, a                                                       ; $7495
	add  hl, de                                                     ; $7496

; Get value and set both base and curr counter
	ld   a, [hl]                                                    ; $7497
	ld   [wCounterUntilReadingNewWavByte], a                        ; $7498
	ld   [wBaseCounterPerWavByte], a                                ; $749b
	
	pop  hl                                                         ; $749e
	jp   WavByteCont                                                ; $749f


StartSongToLoopTo:
	ld   a, [wSongToLoopTo]                                         ; $74a2
	ld   [wSongToStart], a                                          ; $74a5

	jp   UpdateMusic                                                ; $74a8


ProcessAlternatingAudTermWithoutNoise:
; Jump if flag != 1
	ld   a, [wIsAlternatingAudTerm]                                 ; $74ab
	cp   $01                                                        ; $74ae
	jp   nz, .done                                                  ; $74b0

; Branch based on main output term
	ld   a, [wAlternatingAudTermMainlyOnSO2]                        ; $74b3
	cp   $01                                                        ; $74b6
	jp   nz, .processMainlySO1                                      ; $74b8

; Dec counter, simply setting aud term if non-0
	ld   a, [wCurrAlternatingAudTermCounter]                        ; $74bb
	dec  a                                                          ; $74be
	ld   [wCurrAlternatingAudTermCounter], a                        ; $74bf

	cp   $00                                                        ; $74c2
	jp   z, .swapSO2toSO1                                           ; $74c4

; All but noise, and S01 square 2
	ld   a, $75                                                     ; $74c7
	ldh  [rAUDTERM], a                                              ; $74c9
	ret                                                             ; $74cb

.swapSO2toSO1:
; Once counter == 0, swap main aud term, and reset counter
	xor  a                                                          ; $74cc
	ld   [wAlternatingAudTermMainlyOnSO2], a                        ; $74cd

	ld   a, [wBaseAlternatingAudTermCounter]                        ; $74d0
	ld   [wCurrAlternatingAudTermCounter], a                        ; $74d3
	ret                                                             ; $74d6

.processMainlySO1:
; Dec counter, simply setting aud term if non-0
	ld   a, [wCurrAlternatingAudTermCounter]                        ; $74d7
	dec  a                                                          ; $74da
	ld   [wCurrAlternatingAudTermCounter], a                        ; $74db

	cp   $00                                                        ; $74de
	jp   z, .swapSO1toSO2                                           ; $74e0

; All but noise, and S02 square 2
	ld   a, $57                                                     ; $74e3
	ldh  [rAUDTERM], a                                              ; $74e5
	ret                                                             ; $74e7

.swapSO1toSO2:
; Once counter == 0, swap main aud term, and reset counter
	ld   a, $01                                                     ; $74e8
	ld   [wAlternatingAudTermMainlyOnSO2], a                        ; $74ea

	ld   a, [wBaseAlternatingAudTermCounter]                        ; $74ed
	ld   [wCurrAlternatingAudTermCounter], a                        ; $74f0
	ret                                                             ; $74f3

.done:
	xor  a                                                          ; $74f4
	ld   [wIsAlternatingAudTerm], a                                 ; $74f5
	ret                                                             ; $74f8


Sq2ByteEqu0_StopSq2:
	xor  a                                                          ; $74f9
	ld   [wSongToLoopTo], a                                         ; $74fa
	ld   [wIsAlternatingAudTerm], a                                 ; $74fd
	ldh  [rAUD1ENV], a                                              ; $7500
	ret                                                             ; $7502


WavByteEqu0_StopWav:
	xor  a                                                          ; $7503
	ld   [wCurrSongUsesWavChannel], a                               ; $7504
	ld   [wIsAlternatingAudTerm], a                                 ; $7507
	ldh  [rAUD3LEVEL], a                                            ; $750a
	ret                                                             ; $750c


_InitSound:
; Clear square effect/wav channel usage
	xor  a                                                          ; $750d
	ld   [wUnusedVar_dfe3], a                                       ; $750e
	ld   [wSongToLoopTo], a                                         ; $7511
	ld   [wCurrSongUsesWavChannel], a                               ; $7514

; Clear sq and wav output levels
	ldh  [rAUD1ENV], a                                              ; $7517
	ldh  [rAUD2ENV], a                                              ; $7519
	ldh  [rAUD3LEVEL], a                                            ; $751b
	ret                                                             ; $751d


ClearSq2Env:
	xor  a                                                          ; $751e
	ldh  [rAUD2ENV], a                                              ; $751f
	ret                                                             ; $7521


DisableWav:
	xor  a                                                          ; $7522
	ldh  [rAUD3ENA], a                                              ; $7523
	ret                                                             ; $7525


UnusedFuncSet_dff4h:
	ld   a, $01                                                     ; $7526
	ld   [wUnusedVar_dff4], a                                       ; $7528
	ret                                                             ; $752b


Clear_dff4h:
	xor  a                                                          ; $752c
	ld   [wUnusedVar_dff4], a                                       ; $752d
	ret                                                             ; $7530


FrequencyHi:
	db $00, $c0, $80, $80, $81, $81, $81, $82
	db $82, $82, $83, $83, $83, $83, $84, $84
	db $84, $84, $84, $85, $85, $85, $85, $85
	db $85, $85, $86, $86, $86, $86, $86, $86
	db $86, $86, $86, $86, $86, $86, $87, $87
	db $87, $87, $87, $87, $87, $87, $87, $87
	db $87, $87, $87, $87, $87, $87, $87, $87
	db $87, $87, $87, $87, $87, $87, $87, $87
	db $87, $87, $87


FrequencyLo:
	db $00, $00, $2c, $9d, $07, $6b, $c9, $23
	db $77, $c7, $12, $58, $9b, $da, $16, $4f
	db $83, $b5, $e5, $11, $3b, $63, $88, $ac
	db $ce, $ed, $0b, $27, $42, $5b, $72, $89
	db $9e, $b2, $c4, $d6, $e7, $f7, $06, $14
	db $21, $2d, $39, $44, $4f, $59, $62, $6b
	db $73, $7b, $83, $8a, $90, $97, $9d, $a2
	db $a7, $ac, $b1, $b6, $ba, $be, $c1, $c5
	db $c8, $cb, $ce


TempoTable:
	db $04, $08, $10, $20, $40, $0c, $18, $30
	db $05, $06, $0b, $0a, $05, $0a, $14, $28
	db $50, $0f, $1e, $3c, $07, $06, $02, $01
	db $03, $06, $0c, $18, $30, $09, $12, $24
	db $04, $04, $0b, $0a, $06, $0c, $18, $30
	db $60, $12, $24, $48


Song1_Sq2Data:
	db $99, $1e, $01, $9b, $1e, $99, $1e, $1f, $01, $20, $01, $9e, $21, $9a, $01, $27
	db $99, $25, $23, $01, $27, $99, $01, $27, $01, $27, $9a, $25, $23, $9a, $01, $28
	db $99, $25, $23, $01, $28, $99, $01, $28, $01, $28, $9a, $25, $23, $9a, $01, $27
	db $99, $25, $23, $01, $27, $99, $01, $9e, $27, $99, $25, $23, $25, $27, $9a, $01
	db $28, $99, $25, $23, $25, $27, $99, $01, $28, $9a, $01, $99, $2b, $2c, $9a, $28
	db $9a, $01, $27, $99, $25, $23, $25, $27, $99, $01, $9e, $27, $99, $2b, $9a, $2c
	db $99, $28, $99, $28, $01, $25, $23, $01, $20, $23, $01, $99, $28, $01, $00
	
	
Song1_WavData:
	db $99, $1e, $01, $9b, $1e, $99, $1e, $1f, $01, $20, $01, $9e, $21, $99, $23, $01
	db $2d, $01, $23, $01, $2f, $2d, $23, $2d, $2f, $2d, $23, $01, $2f, $01, $1c, $01
	db $2c, $01, $1c, $01, $2c, $01, $1c, $2c, $28, $2c, $1c, $01, $28, $01, $99, $23
	db $01, $2d, $01, $23, $01, $2f, $2d, $23, $2d, $2f, $01, $23, $01, $2f, $2d, $1c
	db $01, $2c, $01, $1c, $01, $28, $01, $1c, $2c, $28, $01, $1c, $01, $28, $01, $99
	db $23, $01, $2d, $01, $23, $01, $2f, $2d, $23, $2d, $2f, $01, $23, $2d, $2f, $01
	db $2c, $01, $28, $01, $1c, $01, $28, $01, $2c, $01, $20, $01, $1c, $01, $82, $01
	db $00


Song2_Sq2Data:
	db $81, $2a, $26, $21, $82, $2b, $28, $81, $21, $81, $2a, $26, $82, $21, $81, $28
	db $01, $28, $01, $87, $2a, $00


Song2_WavData:
	db $81, $1a, $21, $82, $26, $81, $1f, $23, $82, $26, $81, $21, $2a, $26, $2a, $25
	db $01, $25, $01, $83, $26, $01, $00


Song3_Sq2Data:
	db $9a, $01, $27, $99, $25, $23, $25, $27, $99, $01, $9e, $27, $99, $2b, $9a, $2c
	db $99, $28, $99, $28, $01, $25, $23, $01, $20, $23, $01, $99, $28, $01, $01, $01
	db $1c, $00


Song3_WavData:
	db $99, $23, $01, $2d, $01, $23, $01, $2f, $2d, $23, $2d, $2f, $01, $23, $2d, $2f
	db $01, $2c, $01, $28, $01, $1c, $01, $28, $01, $28, $01, $01, $01, $96, $01, $10
	db $00


Song4_Sq2Data:
	db $81, $2a, $2d, $32, $00


Song4_WavData:
	db $86, $01, $00 
	
	
Song5_Sq2Data:
	db $81, $1e, $1a, $15, $1f, $1c, $15, $21, $1e, $81, $26, $25, $23, $25, $01, $21
	db $23, $25, $87, $2a, $00


Song5_WavData:
	db $82, $1a, $81, $26, $86, $1a, $82, $26, $82, $21, $81, $2d, $86, $21, $82, $2d
	db $83, $26, $82, $01, $00
	
	
Song6_Sq2Data:
	db $8c, $2a, $26, $21, $01, $2b, $28, $21, $01, $2a, $26, $21, $01, $28, $25, $21
	db $01, $2a, $26, $21, $01, $2b, $28, $21, $01, $2a, $26, $21, $01, $28, $25, $21
	db $01, $8d, $1f, $23, $26, $8e, $1f, $8e, $23, $8d, $26, $8d, $21, $25, $28, $8e
	db $21, $8e, $26, $8d, $28, $7f


Song6_WavData:
	db $8c, $1a, $01, $1a, $01, $1f, $01, $1f, $01, $1a, $01, $1a, $01, $21, $01, $21
	db $01, $1a, $01, $1a, $01, $1f, $01, $1f, $01, $1a, $01, $1a, $01, $21, $01, $21
	db $01, $8d, $1f, $2b, $2b, $1f, $8c, $1f, $01, $2b, $01, $8d, $2b, $1f, $8d, $21
	db $2d, $2d, $21, $8c, $21, $01, $2d, $01, $8d, $2d, $21, $7f
	
	
Song7_Sq2Data:
	db $80, $2a, $26, $21, $01, $2b, $28, $21, $01, $2a, $26, $21, $01, $28, $25, $21
	db $01, $2a, $26, $21, $01, $2b, $28, $21, $01, $2a, $26, $21, $01, $28, $25, $21
	db $01, $81, $1f, $23, $26, $82, $1f, $82, $23, $81, $26, $81, $21, $25, $28, $82
	db $21, $82, $26, $81, $28, $7f


Song7_WavData:
	db $80, $1a, $01, $1a, $01, $1f, $01, $1f, $01, $1a, $01, $1a, $01, $21, $01, $21
	db $01, $1a, $01, $1a, $01, $1f, $01, $1f, $01, $1a, $01, $1a, $01, $21, $01, $21
	db $01, $81, $1f, $2b, $2b, $1f, $80, $1f, $01, $2b, $01, $81, $2b, $1f, $81, $21
	db $2d, $2d, $21, $80, $21, $01, $2d, $01, $81, $2d, $21, $7f
	
	
Song8_Sq2Data:
	db $91, $2a, $8c, $2a, $91, $28, $8c, $28, $91, $21, $8c, $21, $91, $2b, $8c, $2b
	db $93, $2d, $00


Song8_WavData:
	db $94, $21, $26, $95, $2a, $94, $21, $28, $95, $2b, $94, $21, $26, $95, $2a, $94
	db $21, $28, $95, $2b, $92, $2a, $92, $01, $00
	

Song9_Sq2Data:
	db $83, $26, $81, $01, $21, $23, $25, $82, $26, $81, $2a, $28, $01, $86, $25, $87
	db $26, $00


Song9_WavData:
	db $82, $1a, $81, $26, $1a, $01, $1a, $82, $26, $82, $21, $81, $23, $25, $01, $1a
	db $01, $1a, $87, $1a, $00


SongA_Sq2Data:
	db $83, $26, $81, $01, $21, $23, $25, $82, $26, $81, $2a, $28, $01, $86, $25, $81
	db $1f, $82, $23, $81, $26, $01, $2b, $01, $2b, $81, $21, $82, $25, $81, $28, $01
	db $2d, $01, $2d, $81, $1f, $82, $23, $81, $26, $01, $2b, $01, $2b, $81, $21, $82
	db $25, $81, $28, $01, $2d, $01, $2d, $83, $1e, $00


SongA_WavData:
	db $82, $1a, $81, $26, $1a, $01, $1a, $82, $26, $82, $21, $81, $23, $25, $01, $1a
	db $01, $1a, $82, $1f, $81, $2b, $1f, $01, $23, $01, $26, $82, $21, $81, $2d, $21
	db $01, $28, $01, $2d, $82, $1f, $81, $2b, $1f, $01, $23, $01, $26, $82, $21, $81
	db $2d, $21, $01, $28, $01, $2d, $83, $26, $00


SongB_Sq2Data:
	db $97, $14, $11, $0f, $17, $13, $11, $0f, $17, $00


SongB_WavData:
	db $96, $10, $10, $0e, $0e, $00


SongC_Sq2Data:
	db $a5, $2a, $26, $21, $2b, $28, $21, $2d, $2a, $a5, $2a, $26, $21, $2b, $28, $21
	db $2d, $2a, $a5, $1f, $23, $26, $a6, $2b, $2a, $a5, $28, $aa, $26, $a6, $25, $26
	db $a5, $28, $a5, $2a, $26, $21, $2b, $28, $21, $2d, $2a, $a5, $2a, $26, $21, $2b
	db $28, $21, $2d, $2a, $a5, $1f, $23, $26, $a6, $2b, $2a, $a5, $28, $aa, $26, $a6
	db $25, $26, $a5, $28, $a5, $1f, $23, $26, $a7, $2b, $a5, $01, $a5, $21, $25, $28
	db $a7, $2d, $a5, $01, $a5, $1f, $23, $26, $a7, $2b, $a5, $01, $a5, $21, $25, $28
	db $2d, $01, $aa, $2d, $a7, $2a, $a7, $01, $00
	
	
SongC_WavData:
	db $a4, $1a, $01, $1a, $01, $1a, $01, $1a, $01, $a4, $1a, $01, $1a, $01, $1a, $01
	db $1a, $01, $a4, $1a, $01, $1a, $01, $1a, $01, $1a, $01, $a4, $1a, $01, $1a, $01
	db $1a, $01, $1a, $01, $a4, $1f, $01, $1f, $01, $1f, $01, $1f, $01, $a4, $1f, $01
	db $1f, $01, $1f, $01, $1f, $01, $a4, $21, $01, $21, $01, $21, $01, $21, $01, $a4
	db $21, $01, $21, $01, $21, $01, $21, $01, $a4, $1a, $01, $1a, $01, $1a, $01, $1a
	db $01, $a4, $1a, $01, $1a, $01, $1a, $01, $1a, $01, $a4, $1a, $01, $1a, $01, $1a
	db $01, $1a, $01, $a4, $1a, $01, $1a, $01, $1a, $01, $1a, $01, $a4, $1f, $01, $1f
	db $01, $1f, $01, $1f, $01, $a4, $1f, $01, $1f, $01, $1f, $01, $1f, $01, $a4, $21
	db $01, $21, $01, $21, $01, $21, $01, $a4, $21, $01, $21, $01, $21, $01, $21, $01
	db $a4, $1f, $23, $26, $2b, $a4, $1f, $23, $26, $2b, $a4, $1f, $23, $26, $2b, $a4
	db $1f, $23, $26, $2b, $a4, $21, $25, $28, $2d, $a4, $21, $25, $28, $2d, $a4, $21
	db $25, $28, $2d, $a4, $21, $25, $28, $2d, $a4, $1f, $23, $26, $2b, $a4, $1f, $23
	db $26, $2b, $a4, $1f, $23, $26, $2b, $a4, $1f, $23, $26, $2b, $a4, $21, $25, $28
	db $2d, $a4, $21, $25, $28, $2d, $a4, $21, $25, $28, $2d, $a4, $21, $25, $28, $2d
	db $aa, $26, $a7, $01, $a5, $01, $00


DefaultWavRam:
	db $89, $ab, $bb, $bb, $bb, $bb, $98, $54
	db $21, $00, $00, $00, $00, $00, $00, $00


	ds $7ff0-@, $ff
	
UpdateSound::
	jp   _UpdateSound                                               ; $7ff0


InitSound::
	call _InitSound                                                 ; $7ff3
	ret                                                             ; $7ff6

	ds $8000-@, $ff
