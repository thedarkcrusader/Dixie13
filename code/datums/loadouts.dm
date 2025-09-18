GLOBAL_LIST_INIT(loadout_items, subtypesof(/datum/loadout_item))

/datum/loadout_item
	var/name = "Parent loadout datum"
	var/desc
	var/path

//Miscellaneous

/datum/loadout_item/card_deck
	name = "Card Deck"
	path = /obj/item/toy/cards/deck

//HATS
/datum/loadout_item/zalad
	name = "Keffiyeh"
	path = /obj/item/clothing/neck/keffiyeh

/datum/loadout_item/strawhat
	name = "Straw Hat"
	path = /obj/item/clothing/head/strawhat

/datum/loadout_item/witchhat
	name = "Witch Hat"
	path = /obj/item/clothing/head/wizhat/witch

/datum/loadout_item/bardhat
	name = "Bard Hat"
	path = /obj/item/clothing/head/bardhat

/datum/loadout_item/fancyhat
	name = "Fancy Hat"
	path = /obj/item/clothing/head/fancyhat

/datum/loadout_item/furhat
	name = "Fur Hat"
	path = /obj/item/clothing/head/hatfur


/datum/loadout_item/headband
	name = "Headband"
	path = /obj/item/clothing/head/headband

/datum/loadout_item/nunveil
	name = "Nun Veil"
	path = /obj/item/clothing/head/nun

/datum/loadout_item/papakha
	name = "Papakha"
	path = /obj/item/clothing/head/papakha

//CLOAKS
/datum/loadout_item/tabard
	name = "Tabard"
	path = /obj/item/clothing/cloak/tabard

/datum/loadout_item/surcoat
	name = "Surcoat"
	path = /obj/item/clothing/cloak/stabard

/datum/loadout_item/jupon
	name = "Jupon"
	path = /obj/item/clothing/cloak/stabard/jupon

/datum/loadout_item/cape
	name = "Cape"
	path = /obj/item/clothing/cloak/cape

/datum/loadout_item/halfcloak
	name = "Halfcloak"
	path = /obj/item/clothing/cloak/half

/datum/loadout_item/volfmantle
	name = "Volf Mantle"
	path = /obj/item/clothing/cloak/volfmantle

//SHOES

/datum/loadout_item/babouche
	name = "Babouche"
	path = /obj/item/clothing/shoes/shalal

/datum/loadout_item/sandals
	name = "Sandals"
	path = /obj/item/clothing/shoes/sandals

/datum/loadout_item/gladsandals
	name = "Gladiatorial Sandals"
	path = /obj/item/clothing/shoes/gladiator

/datum/loadout_item/ankletscloth
	name = "Cloth Anklets"
	path = /obj/item/clothing/shoes/boots/clothlinedanklets

//SHIRTS

/datum/loadout_item/robe
	name = "Robe"
	path = /obj/item/clothing/shirt/robe

/datum/loadout_item/longshirt
	name = "Shirt"
	path = /obj/item/clothing/shirt

/datum/loadout_item/shortshirt
	name = "Short-sleeved Shirt"
	path = /obj/item/clothing/shirt/shortshirt

/datum/loadout_item/sailorshirt
	name = "Striped Shirt"
	path = /obj/item/clothing/shirt/undershirt/sailor

/datum/loadout_item/bottomtunic
	name = "Low-cut Tunic"
	path = /obj/item/clothing/shirt/undershirt/lowcut

/datum/loadout_item/tunic
	name = "Tunic"
	path = /obj/item/clothing/shirt/tunic/colored/random

/datum/loadout_item/dress
	name = "Dress"
	path = /obj/item/clothing/shirt/dress/gen

/datum/loadout_item/bardress
	name = "Bar Dress"
	path = /obj/item/clothing/shirt/dress

/datum/loadout_item/nun_habit
	name = "Nun Habit"
	path = /obj/item/clothing/shirt/robe/nun

//PANTS
/datum/loadout_item/tights
	name = "Cloth Tights"
	path = /obj/item/clothing/pants/tights

/datum/loadout_item/sailorpants
	name = "Seafaring Pants"
	path = /obj/item/clothing/pants/tights/sailor

/datum/loadout_item/skirt
	name = "Skirt"
	path = /obj/item/clothing/pants/skirt

//ACCESSORIES

/datum/loadout_item/elf_ear_necklace
	name = "Elf Ear Necklace"
	path = /obj/item/clothing/neck/elfears

/datum/loadout_item/men_ear_necklace
	name = "Men Ear Necklace"
	path = /obj/item/clothing/neck/menears

/datum/loadout_item/wrappings
	name = "Handwraps"
	path = /obj/item/clothing/wrists/wrappings

/datum/loadout_item/loincloth
	name = "Loincloth"
	path = /obj/item/clothing/pants/loincloth

/datum/loadout_item/fingerless
	name = "Fingerless Gloves"
	path = /obj/item/clothing/gloves/fingerless

/datum/loadout_item/feather
	name = "Feather"
	path = /obj/item/natural/feather

/datum/loadout_item/collar
	name = "Collar"
	path = /obj/item/clothing/neck/leathercollar

/datum/loadout_item/bell_collar
	name = "Bell Collar"
	path = /obj/item/clothing/neck/bellcollar

/datum/loadout_item/chaperon
    name = "Chaperon (Normal)"
    path = /obj/item/clothing/head/chaperon

/datum/loadout_item/jesterhat
    name = "Jester's Hat"
    path = /obj/item/clothing/head/jester

/datum/loadout_item/jestertunick
    name = "Jester's Tunick"
    path = /obj/item/clothing/shirt/jester

/datum/loadout_item/jestershoes
    name = "Jester's Shoes"
    path = /obj/item/clothing/shoes/jester
