; moved these to its own file so we can change other stuff in all the levels without having to edit them one by one.
(global ai fx_ai_ret none)

;; BSP -> follow encounter selector function
(script static ai fx_follower_enc
	(if (= (structure_bsp_index) 0) (set fx_ai_ret fx_follower00/follow))
	(if (= (structure_bsp_index) 1) (set fx_ai_ret fx_follower01/follow))
	(if (= (structure_bsp_index) 2) (set fx_ai_ret fx_follower02/follow))
	(if (= (structure_bsp_index) 3) (set fx_ai_ret fx_follower03/follow))
	(if (= (structure_bsp_index) 4) (set fx_ai_ret fx_follower04/follow))

	fx_ai_ret
)

;; same function as above but uses the previous frame as the bsp index. this is what happens when you dont think certain things through in your code   :(
(script static ai fx_follower_prev_enc
	(if (= fx_bsp 0) (set fx_ai_ret fx_follower00/follow))
	(if (= fx_bsp 1) (set fx_ai_ret fx_follower01/follow))
	(if (= fx_bsp 2) (set fx_ai_ret fx_follower02/follow))
	(if (= fx_bsp 3) (set fx_ai_ret fx_follower03/follow))
	(if (= fx_bsp 4) (set fx_ai_ret fx_follower04/follow))

	fx_ai_ret
)

;; Trim fat on bsp switch (save memory save lives)
(script static void fx_bsp_switch_cleanup
	(print "cleanup!")
    (ai_erase fx_steve00)
    (ai_erase fx_steve01)
    (ai_erase fx_steve02)
    (ai_erase fx_steve03)
    (ai_erase fx_steve04)

	(ai_erase fx_foe00)
	(ai_erase fx_foe01)
	(ai_erase fx_foe02)
	(ai_erase fx_foe03)
	(ai_erase fx_foe04)

)

;; BSP -> foe encounter selector function
(script static ai fx_foe_enc	
	(if (= (structure_bsp_index) 0) (set fx_ai_ret fx_foe00/foe))
    (if (= (structure_bsp_index) 1) (set fx_ai_ret fx_foe01/foe))
    (if (= (structure_bsp_index) 2) (set fx_ai_ret fx_foe02/foe))
    (if (= (structure_bsp_index) 3) (set fx_ai_ret fx_foe03/foe))
    (if (= (structure_bsp_index) 4) (set fx_ai_ret fx_foe04/foe))

	fx_ai_ret
)

;; BSP -> steve encounter selector function
(script static ai fx_steve_enc	
	(if (= (structure_bsp_index) 0) (set fx_ai_ret fx_steve00/steve))
    (if (= (structure_bsp_index) 1) (set fx_ai_ret fx_steve01/steve))
    (if (= (structure_bsp_index) 2) (set fx_ai_ret fx_steve02/steve))
    (if (= (structure_bsp_index) 3) (set fx_ai_ret fx_steve03/steve))
    (if (= (structure_bsp_index) 4) (set fx_ai_ret fx_steve04/steve))

	fx_ai_ret
)