(global ai tracked00 none)
(global ai tracked01 none)
(global ai tracked02 none)
(global ai tracked03 none)
(global ai tracked04 none)
(global ai tracked05 none)
(global ai tracked06 none)
(global ai tracked07 none)
(global ai tracked08 none)
(global ai tracked09 none)

;; Override for (ai_place <ai>)
(script static void (ai_place_tracked (ai AI))
	(ai_place ai)
	(set tracked09 tracked08)
	(set tracked08 tracked07)
	(set tracked07 tracked06)
	(set tracked06 tracked05)
	(set tracked05 tracked04)
	(set tracked04 tracked03)
	(set tracked03 tracked02)
	(set tracked02 tracked01)
	(set tracked01 tracked00)
	(set tracked00 ai)
)

;; Override for (camera_control <bool>)
(global boolean fx_cc_state false)
(script static void (camera_control_tracked (boolean STATE))
	(set fx_cc_state STATE)
	(camera_control STATE)
)


;; Returns true if it's safe to use (camera_control) at the moment
;; Multiple scripts doing stuff with camera at the same time = horrifying bugs. this is for safety
(script static boolean fx_camera_safe
	(not fx_cc_state)
)

;====== Code for follower effects ========================================================================================================================================================================;
;==============================================================================================================================================================================;
; fx_follower_enc, fx_follower_prev_enc, fx_bsp_switch_cleanup, fx_foe_enc, fx_steve_enc moved to z_plusEffects_bspDependent, since they depend on the amount of bsp of the map. This way I can just copy this file everywhere.

;; Skyrim style follower managemnt code
(global real follow_dist 1.5)
(script static void (fx_follower_update (ai AI) (object_list LIST) (short INDEX))
	(if (< INDEX (list_count LIST)) (begin
		;; If beyond follow distance from player we run this command list to move towards the player
		(if (> (objects_distance_to_object (list_get LIST INDEX) (player0)) follow_dist) (begin
			(if (objects_can_see_object (list_get LIST INDEX) (player0) 25) (begin
				(ai_command_list_by_unit (unit (list_get LIST INDEX)) fx_move)
				;;(print "dave run")
			)
			(begin
				(ai_command_list_by_unit (unit (list_get LIST INDEX)) fx_turn)
				;;(print "dave turn")
			))
		)
		;; Otherwise just vibe
		(begin
			(ai_command_list_by_unit (unit (list_get LIST INDEX)) fx_stop)
			;;(print "dave stop")
		))
		;; If beyond this max distance just kill them to save memory
		(if (> (objects_distance_to_object (list_get LIST INDEX) (player0)) 75) (unit_kill (unit (list_get LIST INDEX))))
	))
)

(global short followerLoop 0)
(script static void (fx_follower_update_all (ai AI) (object_list LIST))
	;; followerLoop, forced 50 iterations 5 per frame for a 10 frame delay between updates to ai
	(if (and (> followerLoop (list_count LIST)) (>= followerLoop 50)) (set followerLoop 0) (set followerLoop (+ followerLoop 5)))

	;; 5 iterations at a time so we get consistent 10 frame updates up to 50 followers
	;; game would probably start to poop itself around 30 though
	(fx_follower_update AI LIST followerLoop)
	(fx_follower_update AI LIST (+ followerLoop 1))
	(fx_follower_update AI LIST (+ followerLoop 2))
	(fx_follower_update AI LIST (+ followerLoop 3))
	(fx_follower_update AI LIST (+ followerLoop 4))
)

;; Main update loop
(global short fx_bsp 0)
(script continuous fx_follower_main
	;; if the bsp changed this frame we migrate ai to the relevant encounter
	(if (not (= fx_bsp (structure_bsp_index))) (begin (fx_bsp_switch_cleanup) (ai_migrate (fx_follower_prev_enc) (fx_follower_enc))))
	(set fx_bsp (structure_bsp_index))

	;; following distance in combat is set much wider
	(if (> (ai_status (fx_follower_enc)) 4) (set follow_dist 3.5) (set follow_dist 1.25))

	;; increase follow distance further using the number of ai as a multiplier type thing
	(set follow_dist (min 4.5 (* follow_dist (min 2 (max 1 (* follow_dist (/ (ai_living_count (fx_follower_enc)) 5)))))))

	;; update the boys
	(fx_follower_update_all (fx_follower_enc) (ai_actors (fx_follower_enc)))
)

(script static void (fx_follower_move_to (object_list LIST) (short INDEX) (string MARKER))
	(if (< INDEX (list_count LIST)) (begin
		(objects_attach (player0) MARKER (list_get LIST INDEX) "")
		(objects_detach (player0) (list_get LIST INDEX))
	))
)

;; generic function, generates followers from given squad
(script static void (fx_create_follower (ai AI) (string MARKER))
	(ai_place AI)
	(ai_force_active AI true)

	(fx_follower_move_to (ai_actors AI) 0 MARKER)
	(fx_follower_move_to (ai_actors AI) 1 MARKER)
	(fx_follower_move_to (ai_actors AI) 2 MARKER)
	(fx_follower_move_to (ai_actors AI) 3 MARKER)
	(fx_follower_move_to (ai_actors AI) 4 MARKER)
	(fx_follower_move_to (ai_actors AI) 5 MARKER)
	(fx_follower_move_to (ai_actors AI) 6 MARKER)
	(fx_follower_move_to (ai_actors AI) 7 MARKER)
	(fx_follower_move_to (ai_actors AI) 8 MARKER)
	(fx_follower_move_to (ai_actors AI) 9 MARKER)


	(ai_migrate AI (fx_follower_enc))
	(ai_force_active (fx_follower_enc) true)
	(ai_force_active AI false)
)

;; Create some dave followers
(script static void fx_dave
	(fx_create_follower fx_follower00/dave "head")
)

;; Create some minecraft followers
(script static void fx_minecraft
	(fx_create_follower fx_follower00/minecraft "head")
)

;; Create some hunter followers
(script static void fx_hunter
	(fx_create_follower fx_follower00/hunter "head")
)

;; Create some turret followers
(script static void fx_turret
	(fx_create_follower fx_follower00/turret "high")
)

;; Create johnson follower
(script static void fx_johnson
	(fx_create_follower fx_follower00/johnson "head")
)

;; Create keyes follower
(script static void fx_captain
	(fx_create_follower fx_follower00/captain "head")
)

;; Create many piss grunt followers
(script static void fx_piss
	(fx_create_follower fx_follower00/piss "head")
)

;; stevemaker
(script static void (fx_create_steve (ai AI) (string MARKER))
	(ai_place AI)
	(ai_force_active AI true)

	(fx_follower_move_to (ai_actors AI) 0 MARKER)
	(fx_follower_move_to (ai_actors AI) 1 MARKER)
	(fx_follower_move_to (ai_actors AI) 2 MARKER)
	(fx_follower_move_to (ai_actors AI) 3 MARKER)
	(fx_follower_move_to (ai_actors AI) 4 MARKER)
	(fx_follower_move_to (ai_actors AI) 5 MARKER)
	(fx_follower_move_to (ai_actors AI) 6 MARKER)
	(fx_follower_move_to (ai_actors AI) 7 MARKER)
	(fx_follower_move_to (ai_actors AI) 8 MARKER)
	(fx_follower_move_to (ai_actors AI) 9 MARKER)


	(ai_migrate AI (fx_steve_enc))
	(ai_force_active (fx_steve_enc) true)
	(ai_force_active AI false)
)

;; Create some steves
;; These are not followers anymore due to bugs. They just go suicide bomb something nearby
(script static void fx_steve
	(fx_create_steve fx_follower00/steve "head")
)

;===== Code for 1 shot effects =========================================================================================================================================================================;
;==============================================================================================================================================================================;

;; Doubles all currently loaded enemies
;; Won't work on heavily scripted stuff like enemies that come in on dropships
;; small chance of softlock. could add a safety function that auto kills the dupes if they are too far away
(script static void fx_doubleup
  (if (> (ai_living_count tracked09) 0) (ai_place tracked09))
  (if (> (ai_living_count tracked08) 0) (ai_place tracked08))
  (if (> (ai_living_count tracked07) 0) (ai_place tracked07))
  (if (> (ai_living_count tracked06) 0) (ai_place tracked06))
  (if (> (ai_living_count tracked05) 0) (ai_place tracked05))
  (if (> (ai_living_count tracked04) 0) (ai_place tracked04))
  (if (> (ai_living_count tracked03) 0) (ai_place tracked03))
  (if (> (ai_living_count tracked02) 0) (ai_place tracked02))
  (if (> (ai_living_count tracked01) 0) (ai_place tracked01))
  (if (> (ai_living_count tracked00) 0) (ai_place tracked00))
)

;; Template for reconnecting ai onto a different team
(global unit fx_tsv none)
(script static void (fx_ai_reconnect (object_list LIST) (short INDEX) (ai AI))
	(if (< INDEX (list_count LIST)) (begin 
		(set fx_tsv (unit (list_get LIST INDEX)))
		(ai_detach fx_tsv)
		(ai_attach fx_tsv AI)
	))
)

(script static void (fx_ai_reconnect_list (ai SOURCE)(object_list LIST) (ai DESTINATION))
	(if (and (> (ai_living_count SOURCE) 0) (<= (ai_swarm_count SOURCE) 0)) (begin
		(fx_ai_reconnect LIST 0 DESTINATION)
		(fx_ai_reconnect LIST 1 DESTINATION)
		(fx_ai_reconnect LIST 2 DESTINATION)
		(fx_ai_reconnect LIST 3 DESTINATION)
		(fx_ai_reconnect LIST 4 DESTINATION)
		(fx_ai_reconnect LIST 5 DESTINATION)
		(fx_ai_reconnect LIST 6 DESTINATION)
		(fx_ai_reconnect LIST 7 DESTINATION)
		(fx_ai_reconnect LIST 8 DESTINATION)
		(fx_ai_reconnect LIST 9 DESTINATION)
		(fx_ai_reconnect LIST 10 DESTINATION)
		(fx_ai_reconnect LIST 11 DESTINATION)
		(fx_ai_reconnect LIST 12 DESTINATION)
		(fx_ai_reconnect LIST 13 DESTINATION)
		(fx_ai_reconnect LIST 14 DESTINATION)
		(fx_ai_reconnect LIST 15 DESTINATION)
	))
)

;; Makes all loaded ai friendly and follow the player
(script static void fx_friend
  (fx_ai_reconnect_list tracked09 (ai_actors tracked09) (fx_follower_enc))
  (fx_ai_reconnect_list tracked08 (ai_actors tracked08) (fx_follower_enc))
  (fx_ai_reconnect_list tracked07 (ai_actors tracked07) (fx_follower_enc))
  (fx_ai_reconnect_list tracked06 (ai_actors tracked06) (fx_follower_enc))
  (fx_ai_reconnect_list tracked05 (ai_actors tracked05) (fx_follower_enc))
  (fx_ai_reconnect_list tracked04 (ai_actors tracked04) (fx_follower_enc))
  (fx_ai_reconnect_list tracked03 (ai_actors tracked03) (fx_follower_enc))
  (fx_ai_reconnect_list tracked02 (ai_actors tracked02) (fx_follower_enc))
  (fx_ai_reconnect_list tracked01 (ai_actors tracked01) (fx_follower_enc))
  (fx_ai_reconnect_list tracked00 (ai_actors tracked00) (fx_follower_enc))
  (fx_ai_reconnect_list (fx_foe_enc) (ai_actors (fx_foe_enc)) (fx_follower_enc))
)

;; Makes all loaded ai hostile, including any followers
(script static void fx_foe
  (fx_ai_reconnect_list tracked09 (ai_actors tracked09) (fx_foe_enc))
  (fx_ai_reconnect_list tracked08 (ai_actors tracked08) (fx_foe_enc))
  (fx_ai_reconnect_list tracked07 (ai_actors tracked07) (fx_foe_enc))
  (fx_ai_reconnect_list tracked06 (ai_actors tracked06) (fx_foe_enc))
  (fx_ai_reconnect_list tracked05 (ai_actors tracked05) (fx_foe_enc))
  (fx_ai_reconnect_list tracked04 (ai_actors tracked04) (fx_foe_enc))
  (fx_ai_reconnect_list tracked03 (ai_actors tracked03) (fx_foe_enc))
  (fx_ai_reconnect_list tracked02 (ai_actors tracked02) (fx_foe_enc))
  (fx_ai_reconnect_list tracked01 (ai_actors tracked01) (fx_foe_enc))
  (fx_ai_reconnect_list tracked00 (ai_actors tracked00) (fx_foe_enc))
  (fx_ai_reconnect_list (fx_follower_enc) (ai_actors (fx_follower_enc)) (fx_foe_enc))
)

;; Template for shrinking a unit
(script static void (fx_apply_shrink (object_list LIST) (short INDEX))
	(if (< INDEX (list_count LIST)) (object_set_scale (list_get LIST INDEX) 0.5 90))
)

;; Template for shrinking all actors in a list
(script static void (fx_apply_shrink_list (ai AI) (object_list LIST))
	(if (> (ai_living_count AI) 0) (begin
		(fx_apply_shrink LIST 0 )
		(fx_apply_shrink LIST 1 )
		(fx_apply_shrink LIST 2 )
		(fx_apply_shrink LIST 3 )
		(fx_apply_shrink LIST 4 )
		(fx_apply_shrink LIST 5 )
		(fx_apply_shrink LIST 6 )
		(fx_apply_shrink LIST 7 )
		(fx_apply_shrink LIST 8 )
		(fx_apply_shrink LIST 9 )
		(fx_apply_shrink LIST 10 )
		(fx_apply_shrink LIST 11 )
		(fx_apply_shrink LIST 12 )
		(fx_apply_shrink LIST 13 )
		(fx_apply_shrink LIST 14 )
		(fx_apply_shrink LIST 15 )
	))
)

;; Make all loaded ai shrink
(script static void fx_shrink
  (fx_apply_shrink_list tracked09 (ai_actors tracked09))
  (fx_apply_shrink_list tracked08 (ai_actors tracked08))
  (fx_apply_shrink_list tracked07 (ai_actors tracked07))
  (fx_apply_shrink_list tracked06 (ai_actors tracked06))
  (fx_apply_shrink_list tracked05 (ai_actors tracked05))
  (fx_apply_shrink_list tracked04 (ai_actors tracked04))
  (fx_apply_shrink_list tracked03 (ai_actors tracked03))
  (fx_apply_shrink_list tracked02 (ai_actors tracked02))
  (fx_apply_shrink_list tracked01 (ai_actors tracked01))
  (fx_apply_shrink_list tracked00 (ai_actors tracked00))
  (fx_apply_shrink_list (fx_follower_enc) (ai_actors (fx_follower_enc)))
  (fx_apply_shrink_list (fx_foe_enc) (ai_actors (fx_foe_enc)))
)


;; Makes all loaded ai scream constantly. this uses an ai command list in the scenario file
(script static void fx_scream
  (if (> (ai_living_count tracked09) 0) (ai_command_list tracked09 fx_scream))
  (if (> (ai_living_count tracked08) 0) (ai_command_list tracked08 fx_scream))
  (if (> (ai_living_count tracked07) 0) (ai_command_list tracked07 fx_scream))
  (if (> (ai_living_count tracked06) 0) (ai_command_list tracked06 fx_scream))
  (if (> (ai_living_count tracked05) 0) (ai_command_list tracked05 fx_scream))
  (if (> (ai_living_count tracked04) 0) (ai_command_list tracked04 fx_scream))
  (if (> (ai_living_count tracked03) 0) (ai_command_list tracked03 fx_scream))
  (if (> (ai_living_count tracked02) 0) (ai_command_list tracked02 fx_scream))
  (if (> (ai_living_count tracked01) 0) (ai_command_list tracked01 fx_scream))
  (if (> (ai_living_count tracked00) 0) (ai_command_list tracked00 fx_scream))
)

;; Template for applying an effect to units
(script static void (fx_apply_mass_effect (object_list LIST) (short INDEX) (effect EFFECT))
	(if (< INDEX (list_count LIST)) (effect_new_on_object_marker EFFECT (list_get LIST INDEX) "body"))
)

;; Template for applying an effect to all actors in a list
(script static void (fx_apply_mass_effect_list (ai AI) (object_list LIST) (effect EFFECT))
	(if (> (ai_living_count AI) 0) (begin
		(fx_apply_mass_effect LIST 0 EFFECT)
		(fx_apply_mass_effect LIST 1 EFFECT)
		(fx_apply_mass_effect LIST 2 EFFECT)
		(fx_apply_mass_effect LIST 3 EFFECT)
		(fx_apply_mass_effect LIST 4 EFFECT)
		(fx_apply_mass_effect LIST 5 EFFECT)
		(fx_apply_mass_effect LIST 6 EFFECT)
		(fx_apply_mass_effect LIST 7 EFFECT)
		(fx_apply_mass_effect LIST 8 EFFECT)
		(fx_apply_mass_effect LIST 9 EFFECT)
		(fx_apply_mass_effect LIST 10 EFFECT)
		(fx_apply_mass_effect LIST 11 EFFECT)
		(fx_apply_mass_effect LIST 12 EFFECT)
		(fx_apply_mass_effect LIST 13 EFFECT)
		(fx_apply_mass_effect LIST 14 EFFECT)
		(fx_apply_mass_effect LIST 15 EFFECT)
	))
)

;; Boing!
(script static void fx_boing
  (effect_new_on_object_marker "twitch\effects\boing" (player0) "body")
  (fx_apply_mass_effect_list tracked09 (ai_actors tracked09) "twitch\effects\boing")
  (fx_apply_mass_effect_list tracked08 (ai_actors tracked08) "twitch\effects\boing")
  (fx_apply_mass_effect_list tracked07 (ai_actors tracked07) "twitch\effects\boing")
  (fx_apply_mass_effect_list tracked06 (ai_actors tracked06) "twitch\effects\boing")
  (fx_apply_mass_effect_list tracked05 (ai_actors tracked05) "twitch\effects\boing")
  (fx_apply_mass_effect_list tracked04 (ai_actors tracked04) "twitch\effects\boing")
  (fx_apply_mass_effect_list tracked03 (ai_actors tracked03) "twitch\effects\boing")
  (fx_apply_mass_effect_list tracked02 (ai_actors tracked02) "twitch\effects\boing")
  (fx_apply_mass_effect_list tracked01 (ai_actors tracked01) "twitch\effects\boing")
  (fx_apply_mass_effect_list tracked00 (ai_actors tracked00) "twitch\effects\boing")
  (fx_apply_mass_effect_list (fx_follower_enc) (ai_actors (fx_follower_enc)) "twitch\effects\boing")
  (fx_apply_mass_effect_list (fx_foe_enc) (ai_actors (fx_foe_enc)) "twitch\effects\boing")
)

;; Give player a custom loadout
(script static void (fx_loadout (starting_profile PROFILE))
	(set fx_data_value_a (unit_get_health (player0)))
	(set fx_data_value_b (unit_get_shield (player0)))
	(player_add_equipment (player0) PROFILE true)
	(unit_set_current_vitality (player0) (* 75 fx_data_value_a) (* 105 fx_data_value_b))
)

;; Give player an invis
(script static void fx_invis
	(effect_new_on_object_marker "twitch\effects\spawn invis" (player0) "body")
)

;; Spawn a D20 where the player is looking (pops out of his face with a small amount of impulse)
(script static void fx_d20
	(effect_new_on_object_marker "twitch\effects\spawn d20" (player0) "head")
)

;; Spawn a Black Hole
(script static void fx_blackhole
	(effect_new_on_object_marker "twitch\effects\spawn blackhole" (player0) "head")
)

;; Spawn a random vehicle
(script static void fx_vehicle
	(effect_new_on_object_marker "twitch\effects\spawn vehicle" (player0) "head")
)

;; Spawn a Nuke
(script static void fx_nuke
	(effect_new_on_object_marker "twitch\effects\spawn nuke" (player0) "head")
)

;; Spawn a toolgun
(script static void fx_toolgun
	(effect_new_on_object_marker "twitch\effects\spawn toolgun" (player0) "head")
)

;; Spawn a rat
(script static void fx_rat
	(effect_new_on_object_marker "twitch\effects\spawn rat" (player0) "head")
)

;; Unlock double jump for this level
(script static void fx_jump_upgrade
	(set jump_unlocked true)
)

;; Unlock head pistols for this level
(script static void fx_head_upgrade
	(set barrage_unlocked true)
)

;==== Code for timed effects ==========================================================================================================================================================================;
;==============================================================================================================================================================================;

;; Infinite Ammo: cheat infinite ammo and gives one of each grenade so you can throw stuff yuh
(script static void (fx_infinite (short DURATION))
	;; First frame
	(if (<= fx_infinite_timer 0) (begin
		(set cheat_infinite_ammo true)
		(player_add_equipment (player0) fx_grenade false)
	))
	(set fx_infinite_timer (+ fx_infinite_timer DURATION))
)

(global short fx_infinite_timer 0)
(script static void fx_infinite_update
	;; Running
	(if (> fx_infinite_timer 1) (set fx_infinite_timer (- fx_infinite_timer 1)))
	;; Final frame
	(if (= fx_infinite_timer 1) (begin
		(set fx_infinite_timer 0)
		(set cheat_infinite_ammo false)
	))
)

;; Moon gravity: floaty
(script static void (fx_moon (short DURATION))
	(if (<= fx_moon_timer 0) (begin
  		(physics_set_gravity 0.25)
	))
	(set fx_moon_timer (+ fx_moon_timer DURATION))
)

(global short fx_moon_timer 0)
(script static void fx_moon_update
	;; Running
	(if (> fx_moon_timer 1) (set fx_moon_timer (- fx_moon_timer 1)))
	;; Final frame
	(if (= fx_moon_timer 1) (begin
		(set fx_moon_timer 0)
		(physics_set_gravity 1)
	))
)

;; Rapture: everyone floats away
(script static void (fx_rapture (short DURATION))
	(if (<= fx_rapture_timer 0) (begin
  		(physics_set_gravity -0.05)
		(set raptureOngoing true)
  		(effect_new_on_object_marker "twitch\effects\rapture" (player0) "body")
 		(fx_apply_mass_effect_list tracked09 (ai_actors tracked09) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list tracked08 (ai_actors tracked08) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list tracked07 (ai_actors tracked07) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list tracked06 (ai_actors tracked06) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list tracked05 (ai_actors tracked05) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list tracked04 (ai_actors tracked04) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list tracked03 (ai_actors tracked03) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list tracked02 (ai_actors tracked02) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list tracked01 (ai_actors tracked01) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list tracked00 (ai_actors tracked00) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list (fx_follower_enc) (ai_actors (fx_follower_enc)) "twitch\effects\rapture")
 		(fx_apply_mass_effect_list (fx_foe_enc) (ai_actors (fx_foe_enc)) "twitch\effects\rapture")
	))
	(set fx_rapture_timer (+ fx_rapture_timer DURATION))
)

(global short fx_rapture_timer 0)
(global boolean raptureOngoing false)
(script static void fx_rapture_update
	;; Running
	(if (> fx_rapture_timer 1) (set fx_rapture_timer (- fx_rapture_timer 1)))
	;; Final frame
	(if (= fx_rapture_timer 1) (begin
		(set fx_rapture_timer 0)
		(physics_set_gravity 1)
		(set raptureOngoing false)
	))	
)

;; Joyride: forces player into a grunt joyride
(script static void (fx_joyride (short DURATION))
	(if (<= fx_joyride_timer 0) (begin
		(object_destroy fx_joyride)
		(object_create fx_joyride)
		(objects_attach (player0) "body" fx_joyride "")
		(objects_detach (player0) fx_joyride)
		(unit_enter_vehicle (player0) fx_joyride "WS-Passenger")
		(player_enable_input false)
	))
	(set fx_joyride_timer (+ fx_joyride_timer DURATION))
)

(global short fx_joyride_timer 0)
(script static void fx_joyride_update
	;; Running
	(if (> fx_joyride_timer 1) (set fx_joyride_timer (- fx_joyride_timer 1)))
	;; Final frame
	(if (= fx_joyride_timer 1) (begin
		(set fx_joyride_timer 0)
		(player_enable_input true)
	))
)

;; Dance lock: forces player to dance for a bit
(script static void (fx_dance (short DURATION))
	(if (<= fx_dance_timer 0) (begin
		(camera_set_relative special_action_close_0 0 (list_get (players) 0))
		(camera_set_relative special_action_close_1 250 (list_get (players) 0))
		(custom_animation (player0) "twitch\twitch" dance00 true)
		(set fx_dance_anim 250)
	))
	(set fx_dance_timer (+ fx_dance_timer DURATION))
)

(global short fx_dance_timer 0)
(global short fx_dance_anim 0)
(script static void fx_dance_update
	;; Running
	(if (> fx_dance_timer 1) (begin
		(if (fx_camera_safe) (camera_control 1))
		(if (<= fx_dance_anim 0) (begin
			(custom_animation (player0) "twitch\twitch" dance00 true)
			(set fx_dance_anim 250)
		))
		(set fx_dance_anim (- fx_dance_anim 1))
		(set fx_dance_timer (- fx_dance_timer 1))
	))
	;; Final frame
	(if (= fx_dance_timer 1) (begin
		(if (fx_camera_safe) (camera_control 0))
		(set fx_dance_timer 0)
		(unit_stop_custom_animation (player0))
	))
)

;; Armor lock: does the thing
(script static void (fx_lock (short DURATION))
	(if (<= fx_lock_timer 0) (begin
		(camera_set_relative special_action_close_0 0 (list_get (players) 0))
		(camera_set_relative special_action_close_1 300 (list_get (players) 0))
		(custom_animation (player0) "twitch\twitch" lock00 true)
		(set fx_lock_anim 28)
		(effect_new_on_object_marker "characters\cyborg\cyborg shield depletion" (player0) "body")
		(object_create fx_bubble)
		(objects_attach (player0) "body" fx_bubble "")
		(scenery_animation_start fx_bubble "twitch\bubble\bubble" bubble)
		(unit_impervious (player0) true)
		(object_cannot_take_damage (player0))
	))
	(set fx_lock_timer (+ fx_lock_timer DURATION))
)

(global short fx_lock_timer 0)
(global short fx_lock_anim 0)
(script static void fx_lock_update
	;; Running
	(if (> fx_lock_timer 1) (begin
		(if (fx_camera_safe) (camera_control 1))
		(if (<= fx_lock_anim 0) (begin
			(custom_animation (player0) "twitch\twitch" lock01 false)
			(set fx_lock_anim 340)
		))
		(set fx_lock_anim (- fx_lock_anim 1))
		(set fx_lock_timer (- fx_lock_timer 1))
	))
	;; Final frame
	(if (= fx_lock_timer 1) (begin
		(if (fx_camera_safe) (camera_control 0))
		(set fx_lock_timer 0)
		(objects_detach (player0) fx_bubble)
		(object_destroy fx_bubble)
		(unit_impervious (player0) false)
		(object_can_take_damage (player0))
		(unit_stop_custom_animation (player0))
	))
)

;; Forced Reverse Pistol: forces player to use a reverse pistol for a time
(script static void (fx_reverse (short DURATION))
	(set fx_reverse_timer (+ fx_reverse_timer DURATION))
)

(global short fx_reverse_timer 0)
(global real fx_data_value_a 0) ;; used to fix health on player reset, used by other similar scripts as well to save global space
(global real fx_data_value_b 0)
(script static void fx_reverse_update
	;; Running
	(if (> fx_reverse_timer 1) (begin 
		(if (not (unit_has_weapon_readied (player0) "weapons\reverse\reverse")) (begin
			(set fx_data_value_a (unit_get_health (player0)))
			(set fx_data_value_b (unit_get_shield (player0)))
			(player_add_equipment (player0) fx_reverse true)
			(unit_set_current_vitality (player0) (* 75 fx_data_value_a) (* 105 fx_data_value_b))
		))
		(set fx_reverse_timer (- fx_reverse_timer 1))
	))
	;; Final frame
	(if (= fx_reverse_timer 1) (begin
		(set fx_reverse_timer 0)
	))
)

;; Berserk: Forces fisticuffs for a duration and adds some visual effects
(script static void (fx_berserk (short DURATION))
	(cinematic_screen_effect_start 1)
	(cinematic_screen_effect_set_convolution 3 2 1 10 1)
	(set fx_berserk_timer (+ fx_berserk_timer DURATION))
)


(global short fx_berserk_timer 0)
(script static void fx_berserk_update
	;; Running
	(if (> fx_berserk_timer 1) (begin 
		(if (not (unit_has_weapon_readied (player0) "weapons\c plasma rifle\c plasma rifle")) (begin
			(set fx_data_value_a (unit_get_health (player0)))
			(set fx_data_value_b (unit_get_shield (player0)))
			(player_add_equipment (player0) fx_berserk true)
			(unit_set_current_vitality (player0) (* 75 fx_data_value_a) (* 105 fx_data_value_b))
			(print "reset inv")
		))
		(damage_object "twitch\effects\berserk" (player0))
		(set fx_berserk_timer (- fx_berserk_timer 1))
	))
	;; Final frame
	(if (= fx_berserk_timer 1) (begin
		(cinematic_screen_effect_stop)
		(set fx_berserk_timer 0)
	))
)

;; No cooldown: removes cooldowns for special actions
(script static void (fx_cooldown (short DURATION))
	(set fx_cooldown_timer (+ fx_cooldown_timer DURATION))
)

(global short fx_cooldown_timer 0)
(script static void fx_cooldown_update
	;; Running
	(if (> fx_cooldown_timer 1) (begin
		(if (> barrage_cooldown 30) (set barrage_cooldown 29))
		(if (> jump_cooldown 30) (set jump_cooldown 20))
		(set fx_cooldown_timer (- fx_cooldown_timer 1))
	))
	;; Final frame
	(if (= fx_cooldown_timer 1) (begin
		(set fx_cooldown_timer 0)
		(physics_set_gravity 1)
	))
)

;; Main update loop for all timed effects
(script continuous fx_main_update
	(fx_lock_update)
	(fx_dance_update)
	(fx_joyride_update)
	(fx_reverse_update)
	(fx_berserk_update)
	(fx_rapture_update)
	(fx_moon_update)
	(fx_cooldown_update)
	(fx_infinite_update)
)