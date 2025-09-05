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
  (sleep_until (volume_test_objects a1_trigger (players)) 10)
  (race_checkpoint 0x0400)

  (sleep_until (volume_test_objects ext_a_trigger (players)) 10)
  (race_checkpoint 0x0401)
  
  (sleep_until (volume_test_objects crev_dialog_trigger (players)) 10)
  (race_checkpoint 0x0402)
  
  (sleep_until (volume_test_objects b3_bridge_trigger (players)) 10)
  (race_checkpoint 0x0403)
  
  (sleep_until (volume_test_objects ext_c_trigger_a (players)) 10)
  (race_checkpoint 0x0404)
    
  (sleep_until (volume_test_objects inside_control (players)) 10)
  (race_checkpoint 0x0405)
)
