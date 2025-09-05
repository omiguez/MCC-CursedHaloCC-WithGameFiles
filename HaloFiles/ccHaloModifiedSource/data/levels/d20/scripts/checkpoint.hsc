;========== Global Progress Script(s) ==========
(global long race_progress_anchor_value_start 0xDEADBEEF)   ;; anchor value start is something easy to find in memory
(global long race_progress_value 0x00000000)                ;; starting value
(global long race_progress_anchor_value_end 0xBEEFBABE)     ;; anchor value end is something easy to find in memory

;; external program finds that race_progress_value then sets it to 0
;; it then watches taht value for updates


;; template function that updates the race progress
;; call this from the mission script anywhere you want a progress update
(script static void (race_checkpoint (long id))
    (if (> id race_progress_value)
        (set race_progress_value id)
    )
)

(script startup checkpoint_checks
  (sleep_until (volume_test_objects enc1_1_door1_volume (players)) 10)
  (race_checkpoint 0x0800)

  (sleep_until (volume_test_objects 0_to_1_transition_trigger (players)) 10)
  (race_checkpoint 0x0801)
  
  (sleep_until (volume_test_objects 1_to_2_transition_trigger (players)) 10)
  (race_checkpoint 0x0802)
  
  (sleep_until (volume_test_objects enc6_3 (players)) 10)
  (race_checkpoint 0x0803)
  
  (sleep_until (volume_test_objects enc7_6c (players)) 10)
  (race_checkpoint 0x0804)
)
