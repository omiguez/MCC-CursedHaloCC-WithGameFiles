(script startup checkpoint_checks
  (sleep_until (volume_test_objects start_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0800)

  (sleep_until (volume_test_objects jump_into_water_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0801)
  
  (sleep_until (volume_test_objects gravity_life_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0802)
  
  (sleep_until (volume_test_objects find_keyes_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0803)
  
  (sleep_until (volume_test_objects catch_a_ride_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0804)
)
