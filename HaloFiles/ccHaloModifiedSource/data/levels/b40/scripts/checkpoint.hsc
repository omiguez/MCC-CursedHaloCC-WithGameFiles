(script startup checkpoint_checks
  (sleep_until (volume_test_objects start_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0400)

  (sleep_until (volume_test_objects meet_johnson_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0401)
  
  (sleep_until (volume_test_objects wheres_the_road_maintenance_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0402)
  
  (sleep_until (volume_test_objects blue_grunt_twin_bridge_maintenance_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0403)
  
  (sleep_until (volume_test_objects ice_bridge_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0404)
    
  (sleep_until (volume_test_objects control_room_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0405)
)
