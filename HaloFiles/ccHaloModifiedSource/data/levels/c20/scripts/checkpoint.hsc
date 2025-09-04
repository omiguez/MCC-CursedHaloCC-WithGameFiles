(script startup checkpoint_checks
  (sleep_until (volume_test_objects start_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0600)

  (sleep_until (volume_test_objects elevator_one_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0601)
  
  (sleep_until (volume_test_objects elevator_two_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0602)
  
  (sleep_until (volume_test_objects elevator_three_maintenance_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0603)
  
  (sleep_until (volume_test_objects meer_424_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0604)
  
  (sleep_until (volume_test_objects valve_index_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0605)
)
