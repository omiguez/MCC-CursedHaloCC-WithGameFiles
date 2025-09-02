(global long continuousCCLandmark 123654321) ; these help the trainer locate the crowd control code
; 30 bits are not enough, so we use multiple communication variables
(global long continuousCCFlags 1073741824)  ; 0x40 00 00 00, this gets changed by the trainer
(global long continuousCCFlags2 1073741824)  ; 0x40 00 00 00, this gets changed by the trainer
(global long continuousCCLandmark2 777888777); these help the trainer locate the crowd control code
(global long lastFrameContinuousCCFlags 1073741824) ; stores the last frame's flags, so that the program can tell if something has been newly activated or deactivated
(global long lastFrameContinuousCCFlags2 1073741824) ; each "lastFrameContinuousCCFlagsX" var matches the corresponding "continuousCCFlagsX"
(global long ccBitOperator 1)
(global long ccFlag 0)
(global short frameCounter 0)
(global short frameIntervalForSanityCheck 30) ; every given amount of frames, the effect flags are acted upon regardless of if the flags have actually changed.


(script static boolean changedFlag    
	(!= (bitwise_and ccBitOperator continuousCCFlags) (bitwise_and ccBitOperator lastFrameContinuousCCFlags))
)


; if we are due for a flag sanity check, or the flags have changed, return true, false otherwise
(script static boolean sanityCheckOrChangedFlag    
	(or (> frameCounter frameIntervalForSanityCheck) (!= (bitwise_and ccBitOperator continuousCCFlags) (bitwise_and ccBitOperator lastFrameContinuousCCFlags)))
)

(script continuous continuousCrowdControl

;The top bit (0x40000000) is reserved, so there's space for 30 timed effects

(set ccBitOperator 16)
; 4. Disable AI
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (ai off)
            (ai on)
        )
    )
)
(set ccBitOperator 32)
; 5. Jetpack
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (set cheat_jetpack true)
            (set cheat_jetpack false)
        )
    )
)

(set ccBitOperator 64)
;6. Decrease gravity
(if (changedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (begin
                (physics_set_gravity 0.1)
                (sound_impulse_start twitch\sounds\crowdControl\lowGravity none 1))
            (physics_set_gravity 1)
        )
    )
)

(set ccBitOperator 128)
;7. Increase gravity
(if (changedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (begin                 
                (physics_set_gravity 10)
                (sound_impulse_start twitch\sounds\crowdControl\highGravity none 1))
            (physics_set_gravity 1)
        )
    )
)

; gravity sanity check, checking if both flags are zero and rapture is not currently ongoing.
(if (> frameCounter frameIntervalForSanityCheck) 
    (begin
    (set ccBitOperator (+ 64 128))
    (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
    (if (and (= ccFlag 0) (and (not raptureOngoing) (not flappySpartanOngoing)))
        (physics_set_gravity 1))
    ))

(set ccBitOperator 256)
;8. Super jump
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (set cheat_super_jump true)
            (set cheat_super_jump false)
        )
    )
)

(set ccBitOperator 2048)
;11. Bump possession
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (begin
                (if (changedFlag)
                    (fade_in 0 0.8 0 50))
                (set cheat_bump_possession true))
            (begin
                (if (changedFlag)
                    (fade_in 0 0.8 0 50)) ; don't do the fade just because the flag is 0, or it will do it constantly
                (set cheat_bump_possession false))
        )
    )
)

(set ccBitOperator 4096)
;12. Stop all units
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (begin 
                (player_enable_input false)
                (ai off)
                (sound_impulse_start twitch\sounds\crowdControl\crickets none 1)
            )
            (begin 
                (if (changedFlag)
                    (player_enable_input true)) 
                (ai on)
            )
        )
    )
)

(set ccBitOperator 8192)
; 13. Medusa
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (set cheat_medusa true)
            (set cheat_medusa false)
        )
    )
)

(set ccBitOperator 16384)
;14. Infinite ammo
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (begin
                (set cheat_bottomless_clip true)
                (set cheat_infinite_ammo true))
            (begin
                (set cheat_bottomless_clip false)
                (set cheat_infinite_ammo false))
        )
    )
)

(set ccBitOperator 524288)
;19. Movie bars
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (cinematic_show_letterbox true)
            (if (fx_camera_safe) (cinematic_show_letterbox false))
        )
    )
)

(set ccBitOperator 2097152)
;21. Blind
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (show_hud false)
            (show_hud true)
        )
    )
)


(set ccBitOperator 4194304)
;22. No crosshair
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (hud_show_crosshair false)
            (if (not disabledCrosshairUI) (hud_show_crosshair true)) ; check the global to not override Malfunction
        )
    )
)


(set ccBitOperator 8388608)
;23. Silence
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (sound_enable false)
            (sound_enable true)
        )
    )
)


(set ccBitOperator 16777216)
;24. One shot one kill
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (set cheat_omnipotent true)
            (set cheat_omnipotent false)
        )
    )
)

(set ccBitOperator 33554432)
;25. Deathless
(if (sanityCheckOrChangedFlag)
    (begin 
        (set ccFlag (bitwise_and ccBitOperator continuousCCFlags))
        (if (= ccBitOperator ccFlag)
            (set cheat_deathless_player true)
            (set cheat_deathless_player false)
        )
    )
)

;--------- no more space for bits in the first variable. Start using the second one.

(set ccBitOperator 1)
;0. Second var test, replace when this slot is needed.
; (if (!= (bitwise_and ccBitOperator continuousCCFlags2) (bitwise_and ccBitOperator lastFrameContinuousCCFlags2))
;     (begin 
;         (set ccFlag (bitwise_and ccBitOperator continuousCCFlags2))
;         (if (= ccBitOperator ccFlag)
;             (hud_show_crosshair false)
;             (hud_show_crosshair true)                
;         )
;     )
; )

(if (> frameCounter frameIntervalForSanityCheck)
    (set frameCounter 0)
    (set frameCounter (+ frameCounter 1))
)

(if (!= continuousCCFlags lastFrameContinuousCCFlags)
    (set lastFrameContinuousCCFlags  continuousCCFlags) ; Update the flags only if they changed. This minimizes accidentaly overwriting new flags with the old ones if the memory changes during the script execution.
)
(if (!= continuousCCFlags2 lastFrameContinuousCCFlags2)
    (set lastFrameContinuousCCFlags2  continuousCCFlags2) ; Update the flags only if they changed. This minimizes accidentaly overwriting new flags with the old ones if the memory changes during the script execution.
)
)