;; Objects invovled with this script
;; scenery: barrage_hat, barrage_pistol, jump_left, jump_right
;; cameras: special_action_far_0/1, special_action_close_0/1, special_action_jump_0/1
;; strings: *help text entry for reloading pistol hat*
;; title: cooldown

(global boolean karate_unlocked true)
(global boolean barrage_unlocked true)
(global boolean jump_unlocked true)

(script startup hat_upgrade
	(sleep_until (not (game_is_cooperative)) 30)
	(sleep_until barrage_unlocked 30)
	(object_create barrage_hat)
	(objects_attach (unit (list_get (players) 0)) "head" barrage_hat "")
)

(script startup jump_upgrade
	(sleep_until (not (game_is_cooperative)) 30)
	(sleep_until jump_unlocked 30)
	(object_create jump_left)
	(objects_attach (unit (list_get (players) 0)) "left leg" jump_left "")
	(object_create jump_right)
	(objects_attach (unit (list_get (players) 0)) "right leg" jump_right "")
)

(global short gen_cooldown 30)
(global short barrage_cooldown 30)
(global short jump_cooldown 30)

(global long inp_q 99)
(global long inp_sp 99)
(global long inp_z 99)
(global long inp_ta 99)
(global boolean state_q false)

(script static boolean special_jump_kick
	(camera_control_tracked 1)
	(custom_animation (unit (list_get (players) 0)) "characters\cyborg\special\special" "jump-kick" false)
	(camera_set_relative special_action_jump_0 0 (list_get (players) 0))
	(camera_set_relative special_action_jump_1 33 (list_get (players) 0))

	;; Hitbox time
	(sleep 12)
	(effect_new_on_object_marker "characters\cyborg\special\effects\jump kick" (list_get (players) 0) "right foot")

	;; If ya got jump upgrade also fire pistols
	(sleep 2)
	(if jump_unlocked (begin
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "primary spawn")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "primary trigger")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "secondary spawn")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "secondary trigger")
		(sound_impulse_start sound\sfx\weapons\pistol\fire jump_right 1)
	))

	;; Done
	(sleep 19)
	(camera_control_tracked 0)
false
)

(script static boolean special_spin_kick
	(camera_control_tracked 1)
	(unit_impervious (players) true)
	(custom_animation (unit (list_get (players) 0)) "characters\cyborg\special\special" "spin-kick" false)
	(camera_set_relative special_action_close_0 0 (list_get (players) 0))
	(camera_set_relative special_action_close_1 40 (list_get (players) 0))

	;; Hitbox time
	(sleep 18)
	(effect_new_on_object_marker "characters\cyborg\special\effects\spin kick" (list_get (players) 0) "right foot")

	;; If ya got jump upgrade also fire pistols
	(if jump_unlocked (begin
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "primary spawn")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "primary trigger")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "secondary spawn")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "secondary trigger")
		(sound_impulse_start sound\sfx\weapons\pistol\fire jump_right 1)
	))
	(sleep 2)
	(if jump_unlocked (begin
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "primary spawn")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "primary trigger")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "secondary spawn")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "secondary trigger")
		(sound_impulse_start sound\sfx\weapons\pistol\fire jump_right 1)
	))
	(sleep 2)
	(if jump_unlocked (begin
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "primary spawn")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "primary trigger")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "secondary spawn")
		(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "secondary trigger")
		(sound_impulse_start sound\sfx\weapons\pistol\fire jump_right 1)
	))

	;; Done
	(sleep 17)
	(unit_impervious (players) false)
	(camera_control_tracked 0)
false
)

(script static boolean special_barrage
	(camera_control_tracked 1)
	(unit_impervious (players) true)
	(custom_animation (unit (list_get (players) 0)) "characters\cyborg\special\special" "barrage" false)
	(camera_set_relative special_action_far_0 0 (list_get (players) 0))
	(camera_set_relative special_action_far_1 85 (list_get (players) 0))

	;; Grab pistol from belt
	(sleep 10)
	(object_create barrage_pistol)
	(objects_attach (unit (list_get (players) 0)) "left hand" barrage_pistol "")

	;; Begin shooting
	(sleep 14)
	(scenery_animation_start barrage_hat "characters\cyborg\special\hat\hat" "barrage")
	(scenery_animation_start barrage_pistol "characters\cyborg\special\left pistol\left pistol" "barrage")
	(effect_new_on_object_marker "characters\cyborg\special\effects\barrage damage" barrage_hat "primary spawn")
	(effect_new_on_object_marker "characters\cyborg\special\effects\barrage damage" barrage_hat "secondary spawn")
	(effect_new_on_object_marker "characters\cyborg\special\effects\barrage damage" barrage_pistol "primary trigger")
	(effect_new_on_object_marker "characters\cyborg\special\effects\barrage fire" barrage_hat "primary trigger")
	(sleep 1)
	(effect_new_on_object_marker "characters\cyborg\special\effects\barrage fire" barrage_hat "secondary trigger")
	(sleep 1)
	(effect_new_on_object_marker "characters\cyborg\special\effects\barrage fire" barrage_pistol "primary trigger")

	;; Put pistol away
	(sleep 56)
	(objects_detach (unit (list_get (players) 0)) barrage_pistol)
	(object_destroy barrage_pistol)

	;; Done
	(sleep 5)
	(unit_impervious (players) false)
	(camera_control_tracked 0)
	(set barrage_cooldown 3600)
false
)

(script static boolean special_jump
	(effect_new_on_object_marker "characters\cyborg\special\effects\jump boost" (list_get (players) 0) "body")

	(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_left "primary spawn")
	(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_left "primary trigger")
	(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_left "secondary spawn")
	(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_left "secondary trigger")

	(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "primary spawn")
	(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "primary trigger")
	(effect_new_on_object_marker "characters\cyborg\special\effects\jump damage" jump_right "secondary spawn")
	(effect_new_on_object_marker "characters\cyborg\special\effects\jump fire" jump_right "secondary trigger")

	(sound_impulse_start characters\cyborg\special\sounds\jump (list_get (players) 0) 1)

	(set jump_cooldown (+ jump_cooldown 90))
	(print "double jumped")
false
)

;; On a successful trigger of a special move we clear input entirely to prevent buffering
(script static boolean special_cooldown
	(set inp_q 99)
	(set inp_sp 99)
	(set inp_z 99)
	(set inp_ta 99)
	(unit_set_desired_flashlight_state (unit (list_get (players) 0)) false)
	(set state_q false)
	(players_unzoom_all)
	(set gen_cooldown 30)
false
)

(script continuous special_input_main
	;; This is not enabled in multiplayer since it uses cinematic camera stuff to function
	(if (game_is_cooperative) (sleep_until false 999))

	;; Halt script until the karate moves are unlocked, I don't want to interfere with the actual tutorial
	(if (not karate_unlocked) (sleep_until karate_unlocked 30) )

	;; Increment input timers
	(set inp_q (+ inp_q 1))
	(set inp_sp (+ inp_sp 1))
	(set inp_z (+ inp_z 1))
	(set inp_ta (+ inp_ta 1))

	;; Test input and check for double tap
	(if (player_action_test_jump) (begin (if (and (< inp_sp 6) (> inp_sp 1) (<= jump_cooldown 0) jump_unlocked) (special_jump)) (set inp_sp 0)))
	(if (!= (unit_get_current_flashlight_state (unit (list_get (players) 0))) state_q) (begin
		(if (and (< inp_q 6) (> inp_q 1) (<= gen_cooldown 0) karate_unlocked) (begin (special_cooldown) (special_spin_kick)))
		(set inp_q 0)
	))
	(if (player_action_test_zoom) (set inp_z 0))
	(if (player_action_test_back) (set inp_ta 0))

	;; Record current flashlight state
	(set state_q (unit_get_current_flashlight_state (unit (list_get (players) 0))))

	;; Reset for next frame
	(player_action_test_reset)

	;; Cooldown timers
	(if (> gen_cooldown 0) (set gen_cooldown (- gen_cooldown 1)))
	(if (> barrage_cooldown 0) (set barrage_cooldown (- barrage_cooldown 1)))
	(if (> jump_cooldown 0) (set jump_cooldown (- jump_cooldown 1)))

	;; Test for special action
	(if (and (< inp_q 3) (< inp_sp 8) (>= inp_sp inp_q) (<= gen_cooldown 0)) (begin (special_cooldown) (special_jump_kick))) ;; flashlight + jump
	(if (and (< inp_q 3) (< inp_z 3) (<= gen_cooldown 0) barrage_unlocked) (begin                                            ;; flashlight + zoom
		(if (<= barrage_cooldown 0)
			(begin (special_cooldown) (special_barrage))
			(cinematic_set_title cooldown)
		)
	))
)