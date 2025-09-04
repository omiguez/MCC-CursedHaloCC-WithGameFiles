(script startup checkpoint_checks
  (sleep_until (volume_test_objects start_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0700)

  (sleep_until (volume_test_objects pulse_generator_one_autumn_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0701)
  
  (sleep_until (volume_test_objects pulse_generator_two_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0702)
  
  (sleep_until (volume_test_objects pulse_generator_three_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0703)
)
