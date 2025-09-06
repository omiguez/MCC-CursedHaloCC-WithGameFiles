;========== Global Progress Script(s) ==========
(global long race_progress_anchor_value_left -1091585346)   ;; anchor value start is something easy to find in memory
(global long race_progress_value 768)                ;; starting value
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
  (sleep_until (volume_test_objects valley_lid (players)) 10)
  (race_checkpoint 769)
  
  (sleep_until (volume_test_objects shaftB_control (players)) 10)
  (race_checkpoint 770)
  
  (sleep_until (volume_test_objects shaftA_switch (players)) 10)
  (race_checkpoint 771)
  
  (sleep_until (volume_test_objects shaftA_platform (players)) 10)
  (race_checkpoint 772)
)
