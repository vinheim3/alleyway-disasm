SECTION "HRAM", HRAM[$ff80]

union

hOamDmaFunc:: ; $ff80
    ds $0c

nextu

hUnusedButtonsHeld:: ; $ff80
    db

hUnusedButtonsPressed:: ; $ff81
    db

endu

hButtonsNotHeld:: ; $ff8c
    db

hButtonsNotPressed:: ; $ff8d
    db

hButtonsHeld:: ; $ff8e
    db

hff8f:
    ds $90-$8f

hSerialCounterBeforeProcessingSB:: ; $ff90
    db

hSerialByteReceived:: ; $ff91
    db

hPreviousDoublePingedSBReceived:: ; $ff92
    db

; See exact algo in the serial handler
; If not connected, this is $ff, ie bit 7 set
hPrevAndCurrSBsCombined:: ; $ff93
    db

hff94:
    ds 5-4

hUnusedDecompressionNumCols:: ; $ff95
    db

union

hBCD_1Digit:: ; $ff96
    db

hBCD_10Digit:: ; $ff97
    db

nextu

hBCD_CalcValue:: ; $ff96
    dw

endu

hBCD_100Digit:: ; $ff98
    db
    
hBCD_1kDigit:: ; $ff99
    db

hBCD_10kDigit:: ; $ff9a
    db

hUnusedVar_ff9b:: ; $ff9b
    db

hLCDC:: ; $ff9c
    db

hIE:: ; $ff9d
    db

hSCX:: ; $ff9e
    db

hSCY:: ; $ff9f
    db

hVBlankInterruptHandled:: ; $ffa0
    db

hRNGValue:: ; $ffa1
    db

hFrameCounter:: ; $ffa2
    db

hPendingCompressedLevelChanges:: ; $ffa3
    db

hGameState:: ; $ffa4
    db

hCurrMoreLivesScoreThresholdIdx:: ; $ffa5
    db

hNextScoreThresholdForMoreLives:: ; $ffa6
    dw

hNumBrickRowsForStage:: ; $ffa8
    db

hNumBrickRowsOnTopOfCurrLayout:: ; $ffa9
    db

hIsBonusLevel:: ; $ffaa
    db

hIsXScrollingStage:: ; $ffab
    db

hBrickRowIdxToSetLYCfor:: ; $ffac
    db

union

hGameplayScreenBrickRowToDrawTo:: ; $ffad
    db

nextu

hGameplayScreenBrickRowHit:: ; $ffad
    db

hGameplayScreenBrickColHit:: ; $ffae
    db

endu

hYCollisionValToCheck:: ; $ffaf
    db

hXCollisionValToCheck:: ; $ffb0
    db

union

hBrickTileToCopyToCompressedBuffer:: ; $ffb1
    db

nextu

hTileHitByBall:: ; $ffb1
    db

endu

hTileMapOffsetInGameScreenOfHitBrick:: ; $ffb2
    dw ; big-endian

hBallY:: ; $ffb4
    db

hBallSubY:: ; $ffb5
    db

hBallX:: ; $ffb6
    db

hBallSubX:: ; $ffb7
    db

hBallSpeedY:: ; $ffb8
    db

hBallSpeedSubY:: ; $ffb9
    db

hBallSpeedX:: ; $ffba
    db

hBallSpeedSubX:: ; $ffbb
    db

hPrevBallY:: ; $ffbc
    db

hPrevBallX:: ; $ffbd
    db

hBallSpeed:: ; $ffbe
    db

hPaddleY:: ; $ffbf
    db

hPaddleX:: ; $ffc0
    db

hPaddleShortened:: ; $ffc1
    db

hPaddlePixelLength:: ; $ffc2
    db

hCounterUntilBallIncreasesSpeed:: ; $ffc3
    db

hFallingLayoutCounter:: ; $ffc4
    db

hFallingLayoutSpeedIdx:: ; $ffc5
    db

hUpdateBallSpeedCounter:: ; $ffc6
    db

hBallHitATile:: ; $ffc7
    db

hNumBricksInStage:: ; $ffc8
    dw ; big-endian

hCurrScore:: ; $ffca
    dw

hTopScore:: ; $ffcc
    dw