/datum/job_pack/selection/test_selector
	name = "test"
	pack_stats = list(
		STATKEY_STR = 10,
		STATKEY_INT = 10,
	)
	pack_selectables = list(
		"Sword" = list(
			"Falchion" = /obj/item/weapon/sword/scimitar/falchion,
			"Greatsword" = /obj/item/weapon/sword/long/greatsword,
		),
		"Bow" = list(
			"Long Bow" = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long,
			"Bow" = /obj/item/gun/ballistic/revolver/grenadelauncher/bow,
			"Slur Bow x2" = list(/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow/slurbow, /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow/slurbow),
		)
	)
