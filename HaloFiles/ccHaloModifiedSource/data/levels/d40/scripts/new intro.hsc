;; new intro cutscene in the expanded desert bsp
(script static void new_cutscene_insertion
	(fade_out 0 0 0 0)

	(camera_control_tracked on)
	(cinematic_start)
	
	(switch_bsp 10)

	(object_teleport (player0) new_intro_done0)
	(object_teleport (player1) new_intro_done1)
	
	(unit_suspended (player0) true)
	(unit_suspended (player1) true)	

	(wake insertion_music)
	
;	BEGIN "INSERTION_1" SCENE
	(fade_out 0 0 0 0)

	(camera_set new_flyin_1 0)
	(camera_set new_flyin_2 200)
	
	(sleep 60)
	
	(fade_in 0 0 0 60)
	
	(sleep 40)
	
	(camera_set new_flyin_3 200)
	(sleep 100)
	(camera_set new_flyin_4 200)
	(sleep 100)
	(camera_set new_flyin_5 200)
	(sleep 100)
	(camera_set new_flyin_6 200)
	(sleep 100)
	(camera_set new_flyin_7 200)
	(sleep 100)
	(camera_set new_flyin_8 250)
	(sleep 125)
	(camera_set new_flyin_9 250)
	(sleep 125)
	(camera_set new_flyin_10 250)
	(sleep 125)
	(camera_set new_flyin_11 250)
	(sleep 125)
	(camera_set new_flyin_12 200)
	(sleep 100)
	(camera_set new_flyin_13 200)
	(sleep 100)
	(camera_set new_flyin_14 400)
	(sleep 200)

	(unit_suspended (player0) false)
	(unit_suspended (player1) false)

	(object_create desert_hog)
	(unit_enter_vehicle (player0) desert_hog "W-Driver")
	(unit_enter_vehicle (player1) desert_hog "W-Passenger")

	(camera_set new_flyin_15 200)
	(sleep 100)

	(recording_play desert_hog desert_hog_go)

	(camera_set new_flyin_16 300)
	(sleep 150)
	(camera_set new_flyin_17 300)
	(sleep 150)

	(sound_looping_stop sound\sinomatixx_music\d40_insertion_music) ;; stop this music (its already stopped but incase i am fast forwarding lol
	(sound_looping_start "levels\d40\music\d40_01" none 1)

	(camera_set new_flyin_18 155)
	(sleep 80)
	(camera_set new_flyin_19 100)
	(sleep 50)

	(camera_control_tracked off)
	(cinematic_stop)
	
	(sleep 90)
	(recording_kill desert_hog)
	
	(breakable_surfaces_reset)
	(breakable_surfaces_enable false)
	(sound_class_set_gain vehicle_engine 1 5)

	(wake mission_desert)
)

;; God help you
(global boolean do_annoy false)
(script dormant mission_desert
	(sleep 50)
	(game_save)
	(sleep 50)
	(sound_impulse_start "levels\d40\dialog\cortana3" none 0.9)
	(sleep 90)
	(activate_team_nav_point_flag "default_red" player desert_nav 0)
	(wake mission_desert_end)

	(sleep 200)
	(sound_looping_stop "levels\d40\music\d40_01")
	(sleep 90)
	(set do_annoy true)

	(sleep 100)
	(ai_place_tracked desert_banshees)
	(object_create desert_banshee00)
	(object_create desert_banshee01)
	(object_create desert_banshee02)
	(vehicle_load_magic desert_banshee00 "" (ai_actors desert_banshees/a))
	(vehicle_load_magic desert_banshee01 "" (ai_actors desert_banshees/b))
	(vehicle_load_magic desert_banshee02 "" (ai_actors desert_banshees/c))
	(sleep 1000)
	(begin_random
		(ai_magically_see_players desert_banshees/a)
		(ai_magically_see_players desert_banshees/b)
		(ai_magically_see_players desert_banshees/c)
		(sleep 1000)
		(sleep 1000)
		(sleep 1000)
		(sleep 1000)
		(sleep 1000)
		(sleep 1000)
		(sleep 1000)
		(sleep 1000)
	)
)

;; Why did I do this?
(global short annoy_timer 0)
(script continuous mission_desert_annoy
	(if do_annoy (begin
		(if (= (game_difficulty_get) impossible)
			(begin
				(begin_random (set annoy_timer 80) (set annoy_timer 90) (set annoy_timer 100) (set annoy_timer 70))
			)
			(begin
				(begin_random (set annoy_timer 300) (set annoy_timer 900) (set annoy_timer 500) (set annoy_timer 1500) (set annoy_timer 1700))
			)
		)
		(sound_impulse_start "levels\d40\dialog\cortana4" none 0.9)
		(sleep annoy_timer)
	))
)

(script dormant mission_desert_end
	(sleep_until (volume_test_objects desert_end_trigger (players)) 30)
	(set do_annoy false)
	(deactivate_team_nav_point_flag player desert_nav)
	(sleep 90)
	(cs_board)
)

(script static boolean rec_ani00
	(object_teleport desert_hog desert_hog_start)
	(unit_enter_vehicle debug_boy desert_hog "W-Driver")
false
)

(script static boolean rec_ani01
	(object_teleport cs_hog cs_hog_start)
	(unit_enter_vehicle cs_chief cs_hog "W-Driver")
false
)

(script static boolean rec_ani02
	(object_teleport cs_hog cs_hog_start)
	(unit_enter_vehicle cs_chief cs_hog "W-Driver")
	(recording_play cs_hog cs_hog_go)
	(sleep 250)
	(vehicle_unload cs_hog "W-Driver")
false
)

(script static boolean rec_ani03
	(unit_doesnt_drop_items cs_chief_fall)
	(object_destroy cs_chief_fall)
	(sleep 1)
	(object_create cs_chief_fall)
	(effect_new "levels\d40\effects\launch" cs_launch)
false
)

;; Camera positions in their own script to make it easier
(script dormant cs_board_async
	(camera_set cs1_00 0)
	(camera_set cs1_01 150)
	(sleep 100)
	(camera_set cs1_02 125)
	(sleep 100)
	
	(sleep 130)
	(camera_set cs1_03 15)
	(sleep 88)
	(camera_set cs1_04 20)
	(sleep 20)

	(camera_set_relative cs2_00 0 cs_chief)
	(camera_set_relative cs2_01 150 cs_chief)
)

;; New cutscene where chief boards the ship via dual wield blunder jump
(script static boolean cs_board
	;; EXT Part
	(player_enable_input false)
	(player_camera_control false)
	(fade_out 1 1 1 30)
	(cinematic_start)
	(sound_looping_stop "levels\d40\music\d40_01")  ;; Just incase this is still playing...
	(sound_looping_start "levels\d40\music\music0" none 0.85)
	(sleep 30)

	(vehicle_unload desert_hog "")
	(sleep 1)
	(object_teleport desert_hog cs_in_progress2) ;; move stupid hog, delete it later
	(object_teleport (player0) cs_in_progress0)
	(object_teleport (player1) cs_in_progress1)

	(camera_control_tracked 1)
	(camera_set cs0_00 0)
	(camera_set cs0_01 275)
	(object_create cs_hog)
	(object_create cs_chief)
	(object_teleport cs_hog cs_hog_start)
	(unit_enter_vehicle cs_chief cs_hog "W-Driver")
	(recording_play cs_hog cs_hog_go)
	(recording_play cs_chief cs_chief_look)
	(sleep 30)
	(fade_in 1 1 1 20)

	(sleep 200)
	(vehicle_unload cs_hog "W-Driver")
	(sleep 95)

	(wake cs_board_async)
	(object_teleport cs_chief cs_chief00)
	(recording_kill cs_chief)
	(custom_animation cs_chief "levels\d40\cinematics\cyborg\cyborg" blunder-1 false)
	(sound_impulse_start "levels\d40\dialog\cortana0" none 0.725)
	(sleep 155)

	(object_create cs_shotgun00)
	(object_create cs_shotgun01)
	(objects_attach cs_chief "right hand" cs_shotgun00 "")
	(objects_attach cs_chief "left hand" cs_shotgun01 "")
	(sleep 70)
	(sound_impulse_start "levels\d40\dialog\cortana1" none 0.725)
	(sleep 73)
	(sound_impulse_start "levels\d40\dialog\cortana2" none 0.725)
	(sleep 50)
	(sound_impulse_start "levels\d40\dialog\chief0" cs_chief 1)
	(sleep 10)
	(sleep 40)

	(effect_new_on_object_marker "levels\d40\effects\blunder fire" cs_shotgun00 "primary trigger")
	(effect_new_on_object_marker "levels\d40\effects\blunder fire" cs_shotgun01 "primary trigger")
	(sleep 20)

	(unit_stop_custom_animation "cs_chief")
	(custom_animation cs_chief "levels\d40\cinematics\cyborg\cyborg" blunder-2 false)
	(sleep 150)

	(object_destroy cs_shotgun00)
	(object_destroy cs_shotgun01)
	(object_destroy cs_chief)
	(object_destroy cs_hog)
	(object_destroy desert_hog)

	;; INT Part (mostly reused from base game)
	(switch_bsp 0)
	(object_teleport (player0) player0_intro_base)
	(object_teleport (player1) player1_intro_base)

	(objects_predict chief_insertion)
	
	(camera_set chief_climb_1a 0)
	(camera_set chief_climb_1b 125)
	
	(sound_looping_stop "levels\d40\music\music0")

	(fade_in 0 0 0 30)
	(object_create cs_chief_fall)
	(unit_doesnt_drop_items cs_chief_fall)
	(effect_new "levels\d40\effects\launch" cs_launch)
	(sleep 50)
	(sound_impulse_start sound\dialog\d40\d40_insert_040_cortana none 1)
	(camera_set chief_climb_2a 350)
	(sleep 75)
	
	(print "boom")
	
	(player_effect_set_max_rotation 0 .3 .3)
	(player_effect_start 1 0)
	(effect_new "effects\explosions\large explosion" banshee_explosion)
	(sound_impulse_start sound\sfx\impulse\impacts\jeep_hit_solid none 0.5)
	(player_effect_stop 4)

	(object_destroy intro_banshee)
	
	(object_create_anew chief_insertion)
	(object_beautify chief_insertion true)
	
	(object_pvs_activate chief_insertion)
	
	(sleep 60)
	
	(sound_impulse_start sound\dialog\d40\d40_insert_070_cortana none 1)
	(print "cortana: You did that on purpose, didn't you.")

	(sleep 40)
	
	(object_create_anew chief_insertion)
	(object_teleport chief_insertion chief_climbup_base)
	(unit_suspended chief_insertion true)
	(custom_animation chief_insertion cinematics\animations\chief\level_specific\d40\d40 d40climbup true)
	
	(sleep 80)
	(sound_impulse_start "levels\d40\sounds\climb foley" chief_insertion 1)
	(sleep 100)
	
	(camera_set chief_climb_2b 0)
	(camera_set chief_climb_2c 120)
	(sleep (- (unit_get_custom_animation_time chief_insertion) 30))

	(fade_out 1 1 1 15)
	(sleep 15)
	
	(unit_suspended (player0) false)
	(unit_suspended (player1) false)
	
	(object_teleport (player0) player0_intro_done)
	(object_teleport (player1) player1_intro_done)
	
	(object_destroy chief_insertion)
	(object_destroy intro_banshee)
	
	(camera_control_tracked off)
	(player_enable_input true)
	(player_camera_control true)
	(cinematic_stop)

	;; Some objects need to be spawned now that intersected with the desert space and i had to temp remove for the new intro
	(object_create stuff00)
	(object_create stuff01)
	(object_create stuff02)
	(object_create stuff03)
	(object_create stuff04)
	(object_create test4)

	(fade_in 1 1 1 15)
	(sleep 30)
	(game_save)
false
)

(script static boolean cs_test
	(object_destroy cs_chief)
	(object_destroy cs_shotgun00)
	(object_destroy cs_shotgun01)
	(sleep 1)
	(object_create cs_chief)
	(object_create cs_shotgun00)
	(object_create cs_shotgun01)
	(sleep 1)

	(object_teleport cs_chief cs_chief00)
	(custom_animation cs_chief "levels\d40\cinematics\cyborg\cyborg" blunder-1 false)
	(sleep 155)

	(object_create cs_shotgun00)
	(object_create cs_shotgun01)
	(objects_attach cs_chief "right hand" cs_shotgun00 "")
	(objects_attach cs_chief "left hand" cs_shotgun01 "")
	(sleep 263)

	(effect_new_on_object_marker "levels\d40\effects\blunder fire" cs_shotgun00 "primary trigger")
	(effect_new_on_object_marker "levels\d40\effects\blunder fire" cs_shotgun01 "primary trigger")

false
)