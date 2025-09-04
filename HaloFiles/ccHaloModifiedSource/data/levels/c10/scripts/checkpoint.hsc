(script startup checkpoint_checks
  (sleep_until (volume_test_objects start_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0500)

  (sleep_until (volume_test_objects down_elevator_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0501)
  
  (sleep_until (volume_test_objects panicking_marine_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0502)
  
  (sleep_until (volume_test_objects up_elevator_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0503)
  
  (sleep_until (volume_test_objects 343_guilty_spark_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0504)
)
