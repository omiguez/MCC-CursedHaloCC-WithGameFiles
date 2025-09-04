(script startup checkpoint_checks
  (sleep_until (volume_test_objects start_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0900)

  (sleep_until (volume_test_objects reach_autumn_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0901)
  
  (sleep_until (volume_test_objects bridge_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0902)
  
  (sleep_until (volume_test_objects engine_room_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0903)
  
  (sleep_until (volume_test_objects warthog_room_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0904)
  
  (sleep_until (volume_test_objects pelican_finish_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0905)
)
