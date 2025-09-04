(script startup checkpoint_checks
  (sleep_until (volume_test_objects start_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0200)

  (sleep_until (volume_test_objects gravity_lift_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0201)
  
  (sleep_until (volume_test_objects board_cruiser_maintenance_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0202)
  
  (sleep_until (volume_test_objects keyes_cell_maintenance_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0203)
  
  (sleep_until (volume_test_objects steal_dropship_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0204)
)
