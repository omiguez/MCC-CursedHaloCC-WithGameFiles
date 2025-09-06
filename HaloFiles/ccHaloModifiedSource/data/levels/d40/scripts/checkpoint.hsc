;========== Global Progress Script(s) ==========
(global long race_progress_anchor_value_left -1091585346)   ;; anchor value start is something easy to find in memory
(global long race_progress_value 2304)                ;; starting value
(global long race_progress_anchor_value_end -559038737)     ;; anchor value end is something easy to find in memory

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
  (sleep_until (volume_test_objects section1 (players)) 10)
  (race_checkpoint 2305)
  
  (sleep_until (volume_test_objects cinematic_bridge (players)) 10)
  (race_checkpoint 2306)
  
  (sleep_until (volume_test_objects enc5_1 (players)) 10)
  (race_checkpoint 2307)
  
  (sleep_until (volume_test_objects section6 (players)) 10)
  (race_checkpoint 2308)
  
  (sleep_until (volume_test_objects grand_finale (players)) 10)
  (race_checkpoint 2309)
)
