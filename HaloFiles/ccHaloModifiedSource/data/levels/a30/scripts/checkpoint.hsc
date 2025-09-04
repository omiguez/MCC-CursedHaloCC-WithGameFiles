(script startup checkpoint_checks
  (sleep_until (volume_test_objects start_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0100)

  (sleep_until (volume_test_objects first_marines_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0101)
  
  (sleep_until (volume_test_objects second_marines_maintenance_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0102)
  
  (sleep_until (volume_test_objects third_marines_maintenance_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0103)
  
  (sleep_until (volume_test_objects final_marines_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0104)
)
