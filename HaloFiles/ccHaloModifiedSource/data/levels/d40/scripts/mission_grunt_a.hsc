(script dormant mission_grunt_kart_a
	(sleep_until (volume_test_objects grunt_kart_trigger_a (players)) 10)
	
	(object_create kart_a)
	(object_create kart_b)
	(object_create kart_c)

	(ai_place_tracked grunt_karts/kart_a)
	(ai_place_tracked grunt_karts/kart_b)
	(ai_place_tracked grunt_karts/kart_c)

	(vehicle_load_magic kart_a "" (ai_actors grunt_karts/kart_a))
	(vehicle_load_magic kart_b "" (ai_actors grunt_karts/kart_b))
	(vehicle_load_magic kart_c "" (ai_actors grunt_karts/kart_c))

	(ai_magically_see_players grunt_karts)

	(ai_command_list_by_unit (vehicle_driver kart_a) kartz)
	(ai_command_list_by_unit (vehicle_driver kart_b) kartz)
	(ai_command_list_by_unit (vehicle_driver kart_c) kartz)
)