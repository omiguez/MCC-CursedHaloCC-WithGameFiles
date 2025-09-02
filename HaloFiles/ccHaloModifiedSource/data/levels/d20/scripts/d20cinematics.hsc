;   script:		halo d20 cinematics script 
; synopsis:		

;- history ---------------------------------------------------------------------

; 07/01/01 - initial version (tyson)


;- globals ---------------------------------------------------------------------

; print useful debugging text
(global boolean cinematics_debug false)

; sound control parameters
(global real cortana_dialogue_scale 1)
(global real keyes_dialogue_scale 1)
(global real chief_dialogue_scale 1)


;- vehicles --------------------------------------------------------------------
					
; outro banshee 1
(script static void outro_banshee1
	(object_teleport ending_banshee1 outro_banshee1)
	(recording_play (unit ending_banshee1) outro_banshee1)
)


; outro banshee 2
(script static void outro_banshee2
	(object_teleport ending_banshee2 outro_banshee2)
	(recording_play (unit ending_banshee2) outro_banshee2)
)


;- outro -----------------------------------------------------------------------

; launch banshees appropriately
(script static void outro_banshees

	(if (> (list_count (players)) 1)
		(begin
			(outro_banshee2)
			(outro_banshee1)
		)
		(begin
			(if (vehicle_test_seat_list ending_banshee1 "b-driver" (players))
				(begin (outro_banshee1) (object_destroy ending_banshee2))
				(begin (outro_banshee2) (object_destroy ending_banshee1))
			)
		)
	)
)


; trigger the outro
(script static void cinematic_outro
	(fade_out 1 1 1 30)
	(sleep 30)

	(camera_control_tracked on)
	(cinematic_start)

	; place the finale elites
	(ai_place_tracked outro_cov)

	(camera_set outro_1 0)
	(sleep 15)
	(fade_in 1 1 1 30)
	
	; cram the players into the banshees
	(vehicle_load_magic ending_banshee1 "b-driver" (player0))
	(vehicle_load_magic ending_banshee2 "b-driver" (player1))
	
	; move every banshee
	(outro_banshees)
	(sleep 100)
	(sound_class_set_gain ambient_machinery 0 3)
	(camera_set outro_2 135)
	(sleep 180)

	; muzak!
	(sound_looping_stop "levels\d20\music\d20_06")
	
	(sleep 30)

	; fade to black
	(fade_out 0 0 0 60)
	(sleep 90)
)


;- captain cinematic -----------------------------------------------------------

(script stub void cutscene_captain (print "foo"))
(script static void cinematic_captain
	; -- (cutscene_captain) -- old cutscene, replacing this with a dumb meme
	(cutscene_new_captain)
)


;- lift cinematic --------------------------------------------------------------

;*	cinematic for when the player travels from the exterior of the ship into the
	ship by route of the gravity lift. also responsible for teleporting the 
	player from the lift site to the appropriate part of the ship, and swapping
	the bsp.
*;
(script stub void cutscene_lift (print "foo"))
(script static void cinematic_lift
	(cutscene_lift)
)


;- drop cinematic --------------------------------------------------------------

;*	cinematic for when the player drops from the ship to the exterior
	environment. also responsible for switching the bsp and teleporting the 
	player into the new bsp (as well as saving the game)
*;
(script stub void cutscene_fall (print "foo"))
(script static void cinematic_drop
	(cutscene_fall)
)


;- intro cinematic -------------------------------------------------------------

(script stub void cutscene_insertion (print "foo"))
(script static void cinematic_intro
	(cutscene_insertion)
)


;- section 1 dialogue hooks ----------------------------------------------------

(script static void d20_10_cortana ;
	(if cinematics_debug (print "cortana: i can read the captain's cni transponder. he's in the control room. but i'm not detecting any human life signs."))
	(sound_impulse_start sound\dialog\d20\d20_010_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_010_cortana) 30)))
)

(script static void d20_20_cortana ;
	(if cinematics_debug (print "cortana: the damage caused by the crash and the flood have sealed off all nearby accessways to the control room. we should find another way in."))
	(sound_impulse_start sound\dialog\d20\d20_020_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_020_cortana) 30)))
)

(script static void d20_30_cortana ;
	(if cinematics_debug (print "cortana: analyzing damage. [pause] this hole was caused by some kind of explosive. very powerful, if it tore through the ship's hull. all i detect down there are pools of coolant. we should continue our search somewhere else."))
	(sound_impulse_start sound\dialog\d20\d20_030_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_030_cortana) 30)))
)

(script static void d20_50_cortana ;
	(if cinematics_debug (print "cortana: there's so many i can't track them all!"))
	(sound_impulse_start sound\dialog\d20\d20_050_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_050_cortana) 30)))
)

(script static void d20_60_chief
	(sleep 1) ; this hook is obsolete
;	(if cinematics_debug (print "chief: you have no idea."))
;	(sound_impulse_start sound\dialog\d20\d20_060_chief none "chief"_dialogue_scale)
;	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_060_chief) 30)))
)

(script static void d20_70_cortana ;
	(if cinematics_debug (print "cortana: warning! threat level increasing. [pause] that jump into the coolant is looking better all the time, chief. trust me. its deep enough to cushion our fall."))
	(sound_impulse_start sound\dialog\d20\d20_070_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_070_cortana) 30)))
)

(script static void d20_71_cortana ;
	(if cinematics_debug (print "cortana: warning! threat level increasing."))
	(sound_impulse_start sound\dialog\d20\d20_071_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_071_cortana) 30)))
)

(script static void d20_72_cortana ;
	(if cinematics_debug (print "cortana: that jump into the coolant is looking better all the time, chief."))
	(sound_impulse_start sound\dialog\d20\d20_072_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_072_cortana) 30)))
)

(script static void d20_73_cortana ;
	(if cinematics_debug (print "cortana: trust me. its deep enough to cushion our fall."))
	(sound_impulse_start sound\dialog\d20\d20_073_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_073_cortana) 30)))
)

(script static void d20_80_chief
	(sleep 1) ; this hook is obsolete
;	(if cinematics_debug (print "chief: are you sure that pool is deep enough?"))
;	(sound_impulse_start sound\dialog\d20\d20_080_chief "none" chief_dialogue_scale)
;	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_080_chief) 30)))
)

(script static void d20_90_cortana ;
	(if cinematics_debug (print "cortana: [very urgent] chief, we need to jump. now! "))
	(sound_impulse_start sound\dialog\d20\d20_090_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_090_cortana) 30)))
	(activate_team_nav_point_flag "default_red" player waypoint1 0)
)


;- section 3 dialogue hooks ----------------------------------------------------

(script static void d20_120_cortana ;
	(if cinematics_debug (print "cortana: let's get out of here and find another back aboard the ship."))
	(sound_impulse_start sound\dialog\d20\d20_120_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_120_cortana) 30)))
)

(script static void d20_130_cortana ;
	(if cinematics_debug (print "cortana: the crash did more damage than i suspected. analyzing: [pause] coolant leakage rate is significant. the ship's reactors should already have gone critical."))
	(sound_impulse_start sound\dialog\d20\d20_130_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_130_cortana) 30)))
)

(script static void d20_140_cortana ;
	(if cinematics_debug (print "cortana: we should head this way, towards the ship's gravity lift."))
	(sound_impulse_start sound\dialog\d20\d20_140_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_140_cortana) 30)))
	(activate_team_nav_point_flag "default_red" player waypoint2 0)
)

(script static void d20_150_cortana ;
	(if cinematics_debug (print "cortana: wait. the covenant and flood are attacking each other. i recommend we wait until they've worm each other down. then we'll only have to deal with the stragglers. "))
	(sound_impulse_start sound\dialog\d20\d20_150_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_150_cortana) 30)))
)

(script static void d20_160_cortana ;
	(if cinematics_debug (print "cortana: power source detected. there's the gravity lift. [pause] it's still operational. that's our way back in."))
	(sound_impulse_start sound\dialog\d20\d20_160_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_160_cortana) 30)))
)


;- section 4 dialogue hooks ----------------------------------------------------

(script static void d20_180_cortana ;
	(if cinematics_debug (print "cortana: we should be able to get into the ship's control room from here. "))
	(sound_impulse_start sound\dialog\d20\d20_180_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_180_cortana) 30)))
)

(script static void d20_190_cortana ;
	(if cinematics_debug (print "cortana: wait a moment. we went through the doors on the right the last time we were here. this is a different route. [pause] the covenant battle net is a mess. i can't access the ship's schematics. my records indicate that a shuttle bay should be here. "))
	(sound_impulse_start sound\dialog\d20\d20_190_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_190_cortana) 30)))
	(activate_team_nav_point_flag "default_red" player waypoint3 0)
)

(script static void d20_200_cortana ;
	(if cinematics_debug (print "cortana: look, in the corners. the flood are gathering bodies here."))
	(sound_impulse_start sound\dialog\d20\d20_200_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_200_cortana) 30)))
)


;- section 5 dialogue hooks ----------------------------------------------------

(script static void d20_210_cortana ;
	(if cinematics_debug (print "cortana: looks like another shuttle bay, we should be able to reach the control room from the third level."))
	(sound_impulse_start sound\dialog\d20\d20_210_cortana "none" cortana_dialogue_scale)
	(deactivate_team_nav_point_flag player waypoint3)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_210_cortana) 30)))
	(activate_team_nav_point_flag "default_red" player waypoint4 0)
)


(script static void d20_220_cortana ;
	(if cinematics_debug (print "cortana: the control room should be this way."))
	(sound_impulse_start sound\dialog\d20\d20_220_cortana "none" cortana_dialogue_scale)
	(deactivate_team_nav_point_flag player waypoint4)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_220_cortana) 30)))
	(activate_team_nav_point_flag "default_red" player waypoint5 0)
)


;- section 7 dialogue hooks ----------------------------------------------------

(script static void d20_240_cortana ;
	(if cinematics_debug (print "cortana: we need to get back to the pillar of autumn.  let's go back to the shuttle bay and find a ride."))
	(sound_impulse_start sound\dialog\d20\d20_240_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_240_cortana) 30)))
)

(script static void d20_250_cortana
	(if cinematics_debug (print "cortana: perfect. grab one of the escort banshees and we'll use it to return to the pillar of autumn."))
	(sound_impulse_start sound\dialog\d20\d20_250_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_250_cortana) 30)))
	(activate_team_nav_point_object "default_red" player ending_banshee1 0)
)


;- flava dialogue hooks --------------------------------------------------------

(script static void d20_flavor_010_captkeyes 
	(if cinematics_debug (print "d20_flavor_010_captkeyes"))
	(sound_impulse_start sound\dialog\d20\d20_flavor_010_captkeyes "none" keyes_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_flavor_010_captkeyes) 15)))
)

(script static void d20_flavor_020_cortana
	(if cinematics_debug (print "d20_flavor_020_cortana"))
	(sound_impulse_start sound\dialog\d20\d20_flavor_020_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_flavor_020_cortana) 15)))
)

(script static void d20_flavor_030_captkeyes 
	(if cinematics_debug (print "d20_flavor_030_captkeyes"))
	(sound_impulse_start sound\dialog\d20\d20_flavor_030_captkeyes "none" keyes_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_flavor_030_captkeyes) 15)))
)

(script static void d20_flavor_040_cortana
	(if cinematics_debug (print "d20_flavor_040_cortana"))
	(sound_impulse_start sound\dialog\d20\d20_flavor_040_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_flavor_040_cortana) 15)))
)

(script static void d20_flavor_050_captkeyes 
	(if cinematics_debug (print "d20_flavor_050_captkeyes"))
	(sound_impulse_start sound\dialog\d20\d20_flavor_050_captkeyes "none" keyes_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_flavor_050_captkeyes) 15)))
)

(script static void d20_flavor_060_cortana
	(if cinematics_debug (print "d20_flavor_060_cortana"))
	(sound_impulse_start sound\dialog\d20\d20_flavor_060_cortana "none" cortana_dialogue_scale)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\d20\d20_flavor_060_cortana) 15)))
)


;- music control ---------------------------------------------------------------

; scale controls
(global real music_01_scale 1)
(global real music_02_scale 1)
(global real music_03_scale 1)
(global real music_04_scale 1)
(global real music_05_scale 1)
(global real music_06_scale 1)

; play controls
(global boolean music_01_base false)
(global boolean music_02_base false)
(global boolean music_03_base false)
(global boolean music_03_alt false)
(global boolean music_04_base false)
(global boolean music_05_base false)
(global boolean music_06_base false)

(script static void music_01 
	; wait for it... waaaait for it... then begin music
	(sleep_until music_01_base)
	(if cinematics_debug (print "start music_01"))
	(sound_looping_start "levels\d40\music\d40_01" none music_01_scale)

	; stop?
	(sleep_until (not music_01_base))
	(if cinematics_debug (print "end music_01"))
	(sound_looping_stop "levels\d40\music\d40_01")
)

(script static void music_02 
	; wait for it... waaaait for it... then begin music
	(sleep_until music_02_base)
	(if cinematics_debug (print "start music_02"))
	(sound_looping_start "levels\d40\music\d40_02" none music_02_scale)

	; stop?
	(sleep_until (not music_02_base))
	(if cinematics_debug (print "end music_02"))
	(sound_looping_stop "levels\d40\music\d40_02")
)

(script static void music_03 
	; wait for it... waaaait for it... then begin music
	(sleep_until music_03_base)
	(if cinematics_debug (print "start music_03"))
	(sound_looping_start "levels\d40\music\d40_03" none music_03_scale)

	; alt?
	(sleep_until music_03_alt)
	(if cinematics_debug (print "alt music_03"))
	(sound_looping_set_alternate "levels\d40\music\d40_03" true)
	
	; stop?
	(sleep_until (not music_03_base))
	(set music_03_alt false)
	(if cinematics_debug (print "end music_03"))
	(sound_looping_stop "levels\d40\music\d40_03")
)

(script static void music_04_start
	(set music_04_base true)
	(if cinematics_debug (print "start music_04"))
	(sound_looping_start "levels\d40\music\d40_02" none music_02_scale)
)

(script static void music_04_end
	(set music_04_base false)
	(if cinematics_debug (print "end music_04"))
	(sound_looping_stop "levels\d40\music\d40_02")
)

(script static void music_05 
	; wait for it... waaaait for it... then begin music
	(sleep_until music_05_base)
	(if cinematics_debug (print "start music_05"))
	(sound_looping_start "levels\d40\music\d40_02" none music_02_scale)

	; stop?
	(sleep_until (not music_05_base))
	(if cinematics_debug (print "end music_05"))
	(sound_looping_stop "levels\d40\music\d40_02")
)

(script static void music_06 
	; wait for it... waaaait for it... then begin music
	(sleep_until music_06_base)
	(if cinematics_debug (print "start music_06"))
	(sound_looping_start "levels\d40\music\d40_02" none music_02_scale)

	; stop?
	(sleep_until (not music_06_base))
	(if cinematics_debug (print "end music_06"))
	(sound_looping_stop "levels\d40\music\d40_02")
)

(script dormant music_control
	(music_01)
	(music_02)
	(music_03)
;	(music_04)
	(music_05)
	(music_06)
)

