INCLUDE "includes.s"

SECTION "WRAM", WRAM0[$c000]

wBrickLayoutBuffer:: ; $c000
    ds 30 * NUM_BYTES_IN_LAYOUT_BUFFER_ROW
.end::

wc348:
    ds $400-$348

wBreakableBricksBuffer:: ; $c400
    ds 30 * NUM_BYTES_IN_LAYOUT_BUFFER_ROW

wc748:
    ds $800-$748

wOam:: ; $c800
    ds NUM_SPRITES * OAM_SIZEOF

wc8a0:
    ds $900-$8a0

wUnusedVar_c900:: ; $c900
    db

wCompressedLevelChanges:: ; $c901
    ds $a00-$901

wHorizScrollingLayoutSCXVals:: ; $ca00
    ds NUM_SCROLL_ROWS

wHorizScrollDirection:: ; $ca14
    ds NUM_SCROLL_ROWS

wHorizScrollCounter:: ; $ca28
    ds NUM_SCROLL_ROWS

wFallingLayoutSCY:: ; $ca3c
    db

wLastInGameSCY:: ; $ca3d
    db

wMarioX:: ; $ca3e
    db

wMarioY:: ; $ca3f
    db

wMarioAnimIdx:: ; $ca40
    db

union

wTimeUntilMarioAnimated:: ; $ca41
    db

nextu

wNonMarioAnimIdx:: ; $ca41
    db

endu

wMarioJumpYdiffIdx:: ; $ca42
    db

wMarioIsMovingRight:: ; $ca43
    db

wLivesLeft:: ; $ca44
    db

wCurrStage:: ; $ca45
    db

wDisplayedStage:: ; $ca46
    db

wNumBonusStagesVisited:: ; $ca47
    db

wBonusStageTimer:: ; $ca48
    db

wNum100hFramesUntilDemoTransition:: ; $ca49
    db

wca4a:
    ds $b-$a

wReturnedToTitleScreenCounter:: ; $ca4b
    db

wca4c:
    ds $fff-$a4c

wStackTop:: ; $cfff

wcfff:
    ds $dfd0-$cfff

wSweepingSqEffectLoopVal1:: ; $dfd0
    db

wSweepingSqEffectLoopVal2:: ; $dfd1
    db

wIsAlternatingAudTerm:: ; $dfd2
    db

wCurrAlternatingAudTermCounter:: ; $dfd3
    db

wBaseAlternatingAudTermCounter:: ; $dfd4
    db

wAlternatingAudTermMainlyOnSO2:: ; $dfd5
    db

wUnusedVar_dfd6:: ; $dfd6
    db

wPlayingShortenedPaddleSqEffect:: ; $dfd7
    db

wSoundsDontStart:: ; $dfd8
    db

wdfd9:
    ds $e0-$d9

wSquareEffectToPlay:: ; $dfe0
    db

wNoiseEffectToPlay:: ; $dfe1
    db

wSquareEffectBeingPlayed:: ; $dfe2
    db

wUnusedVar_dfe3:: ; $dfe3
    db

wSongToLoopTo:: ; $dfe4
    db

wCurrSongUsesWavChannel:: ; $dfe5
    db

union

wFrameCounterForSquareEffectStep:: ; $dfe6
    db

nextu

wSweepingSqEffectDirection:: ; $dfe6
    db

endu

wdfe7:
    ds 8-7

wSongToStart:: ; $dfe8
    db

wCurrSquareEffectStep:: ; $dfe9
    db

wdfea:
    ds $b-$a

wCounterUntilReadingNewSq2Byte:: ; $dfeb
    db

wBaseCounterPerSq2Byte:: ; $dfec
    db

wCounterUntilReadingNewWavByte:: ; $dfed
    db

wBaseCounterPerWavByte:: ; $dfee
    db

wdfef:
    ds $f0-$ef

wSq2DataAddress:: ; $dff0
    dw

wWavDataAddress:: ; $dff2
    dw

wUnusedVar_dff4:: ; $dff4
    db

wSq2FrequencyIdx:: ; $dff5
    db

wWavFrequencyIdx:: ; $dff6
    db

wWavRamIdxToSet:: ; $dff7
    db

wUnusedVar_dff8:: ; $dff8
    db

wAlternatingAudTermWithNoiseCounter:: ; $dff9
    db

wBitsSetIfAudTermWithNoiseOnSO1:: ; $dffa
    db

wSweepingSqEffectFreqLo1:: ; $dffb
    db

wSweepingSqEffectFreqHi1:: ; $dffc
    db

wSweepingSqEffectFreqLo2:: ; $dffd
    db

wSweepingSqEffectFreqHi2:: ; $dffe
    db
