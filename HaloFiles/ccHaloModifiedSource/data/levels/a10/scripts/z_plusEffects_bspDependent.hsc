; moved these to its own file so we can change other stuff in all the levels without having to edit them one by one.
(global ai fx_ai_ret none)

;; BSP -> follow encounter selector function
(script static ai fx_follower_enc
	(if (= (structure_bsp_index) 0) (set fx_ai_ret fx_follower00/follow))
	(if (= (structure_bsp_index) 1) (set fx_ai_ret fx_follower01/follow))
	(if (= (structure_bsp_index) 2) (set fx_ai_ret fx_follower02/follow))
	(if (= (structure_bsp_index) 3) (set fx_ai_ret fx_follower03/follow))
	(if (= (structure_bsp_index) 4) (set fx_ai_ret fx_follower04/follow))
	(if (= (structure_bsp_index) 5) (set fx_ai_ret fx_follower05/follow))
	(if (= (structure_bsp_index) 6) (set fx_ai_ret fx_follower06/follow))
	(if (= (structure_bsp_index) 7) (set fx_ai_ret fx_follower07/follow))
	(if (= (structure_bsp_index) 8) (set fx_ai_ret fx_follower08/follow))

	fx_ai_ret
)

;; same function as above but uses the previous frame as the bsp index. this is what happens when you dont think certain things through in your code   :(
(script static ai fx_follower_prev_enc
	(if (= fx_bsp 0) (set fx_ai_ret fx_follower00/follow))
	(if (= fx_bsp 1) (set fx_ai_ret fx_follower01/follow))
	(if (= fx_bsp 2) (set fx_ai_ret fx_follower02/follow))
	(if (= fx_bsp 3) (set fx_ai_ret fx_follower03/follow))
	(if (= fx_bsp 4) (set fx_ai_ret fx_follower04/follow))
	(if (= fx_bsp 5) (set fx_ai_ret fx_follower05/follow))
	(if (= fx_bsp 6) (set fx_ai_ret fx_follower06/follow))
	(if (= fx_bsp 7) (set fx_ai_ret fx_follower07/follow))
	(if (= fx_bsp 8) (set fx_ai_ret fx_follower08/follow))

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
    (ai_erase fx_steve05)
    (ai_erase fx_steve06)
    (ai_erase fx_steve07)
    (ai_erase fx_steve08)

	(ai_erase fx_foe00)
	(ai_erase fx_foe01)
	(ai_erase fx_foe02)
	(ai_erase fx_foe03)
	(ai_erase fx_foe04)
	(ai_erase fx_foe05)
	(ai_erase fx_foe06)
	(ai_erase fx_foe07)
	(ai_erase fx_foe08)

)

;; BSP -> foe encounter selector function
(script static ai fx_foe_enc	
	(if (= (structure_bsp_index) 0) (set fx_ai_ret fx_foe00/foe))
    (if (= (structure_bsp_index) 1) (set fx_ai_ret fx_foe01/foe))
    (if (= (structure_bsp_index) 2) (set fx_ai_ret fx_foe02/foe))
    (if (= (structure_bsp_index) 3) (set fx_ai_ret fx_foe03/foe))
    (if (= (structure_bsp_index) 4) (set fx_ai_ret fx_foe04/foe))
    (if (= (structure_bsp_index) 5) (set fx_ai_ret fx_foe05/foe))
    (if (= (structure_bsp_index) 6) (set fx_ai_ret fx_foe06/foe))
    (if (= (structure_bsp_index) 7) (set fx_ai_ret fx_foe07/foe))
    (if (= (structure_bsp_index) 8) (set fx_ai_ret fx_foe08/foe))

	fx_ai_ret
)

;; BSP -> steve encounter selector function
(script static ai fx_steve_enc	
	(if (= (structure_bsp_index) 0) (set fx_ai_ret fx_steve00/steve))
    (if (= (structure_bsp_index) 1) (set fx_ai_ret fx_steve01/steve))
    (if (= (structure_bsp_index) 2) (set fx_ai_ret fx_steve02/steve))
    (if (= (structure_bsp_index) 3) (set fx_ai_ret fx_steve03/steve))
    (if (= (structure_bsp_index) 4) (set fx_ai_ret fx_steve04/steve))
    (if (= (structure_bsp_index) 5) (set fx_ai_ret fx_steve05/steve))
    (if (= (structure_bsp_index) 6) (set fx_ai_ret fx_steve06/steve))
    (if (= (structure_bsp_index) 7) (set fx_ai_ret fx_steve07/steve))
    (if (= (structure_bsp_index) 8) (set fx_ai_ret fx_steve08/steve))

	fx_ai_ret
)