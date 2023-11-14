(global boolean var_init_invert false)

(script startup reverse_pistol_init
	(set var_init_invert (player0_look_pitch_is_inverted))
)

(script continuous reverse_pistol_update
	(sleep_until (or (unit_has_weapon_readied (player0) "weapons\reverse\reverse") (unit_has_weapon_readied (player1) "weapons\reverse\reverse")) 1)
	(player0_look_invert_pitch (not var_init_invert))

	(sleep_until (and (not (unit_has_weapon_readied (player0) "weapons\reverse\reverse")) (not (unit_has_weapon_readied (player1) "weapons\reverse\reverse"))) 1)
	(player0_look_invert_pitch var_init_invert)
)