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
  (sleep_until (volume_test_objects mission_start (players)) 10)
  (race_checkpoint 0x0300)

  (sleep_until (volume_test_objects valley_lid (players)) 10)
  (race_checkpoint 0x0301)
  
  (sleep_until (volume_test_objects shaftB_control (players)) 10)
  (race_checkpoint 0x0302)
  
  (sleep_until (volume_test_objects shaftA_switch (players)) 10)
  (race_checkpoint 0x0303)
  
  (sleep_until (volume_test_objects shaftA_platform (players)) 10)
  (race_checkpoint 0x0304)
)
