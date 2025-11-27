// Blackboard keys for papameat defense
#define BB_PAPAMEAT_TARGET "bb_papameat_target"
#define BB_PAPAMEAT_HEALING "bb_papameat_healing"
#define BB_CORPSE_TO_FEED "bb_corpse_to_feed"
#define BB_FEEDING_CORPSE "bb_feeding_corpse"
#define BB_BRIDGE_TARGET "bridge_target"
#define BB_BRIDGING "bridging"
#define BB_OBSTACLE_TARGET "obstacle_target"
#define BB_ATTACKING_OBSTACLE "attacking_obstacle"

// Signal for papameat damage
#define COMSIG_PAPAMEAT_DAMAGED "papameat_damaged"
#define COMSIG_PAPAMEAT_CRITICAL "papameat_critical"

// Papameat health thresholds
#define PAPAMEAT_CRITICAL_HEALTH 0.3 // 30% health
#define PAPAMEAT_SACRIFICE_RANGE 2 // Must be within 2 tiles to sacrifice

#define COMSIG_MEATVINE_RESOURCE_CHANGE "meatvine_resource_change"
#define COMSIG_MEATVINE_PERSONAL_RESOURCE_CHANGE "personal_resource_change"
#define COMSIG_MEATVINE_PERSONAL_EVOLUTION_CHANGE "personal_evolution_change"

#define PERSONAL_RESOURCE_MAX 100
#define PERSONAL_RESOURCE_REGEN_RATE 0.5 // Per life tick
#define HEALING_WELL_DRAIN_AMOUNT 50
#define HEALING_WELL_DRAIN_TIME 30 SECONDS
#define HEALING_WELL_DRAIN_COOLDOWN 60 SECONDS
