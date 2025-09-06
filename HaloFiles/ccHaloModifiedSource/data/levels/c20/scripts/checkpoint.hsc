;========== Global Progress Script(s) ==========
(global long race_progress_anchor_value_left -1091585346)   ;; anchor value start is something easy to find in memory
(global long race_progress_value 1536)                ;; starting value
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
  (sleep_until (volume_test_objects tv_platform1 (players)) 10)
  (race_checkpoint 1537)
  
  (sleep_until (volume_test_objects tv_platform2 (players)) 10)
  (race_checkpoint 1538)
  
  (sleep_until (volume_test_objects tv_platform3 (players)) 10)
  (race_checkpoint 1539)
  
  (sleep_until (volume_test_objects enc7_9_trigger (players)) 10)
  (race_checkpoint 1540)
  
  (sleep_until (volume_test_objects finale (players)) 10)
  (race_checkpoint 1541)
)
