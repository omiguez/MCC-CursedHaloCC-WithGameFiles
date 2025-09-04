(script startup checkpoint_checks
  (sleep_until (volume_test_objects start_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0300)

  (sleep_until (volume_test_objects hunter_fight_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0301)
  
  (sleep_until (volume_test_objects disable_security_maintenance_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0302)
  
  (sleep_until (volume_test_objects silent_cartographer_maintenance_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0303)
  
  (sleep_until (volume_test_objects pelican_escape_dropship_trigger_volume_name (players)) 10)
  (race_checkpoint 0x0304)
)
