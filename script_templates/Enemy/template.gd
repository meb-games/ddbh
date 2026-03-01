extends Enemy

## Called when the enemy should take an action.
func _act(explorer: CharacterBody2D):
	pass

## Called when the enemy collides with the explorer.
##
## The default implementation just makes the enemy lose a health if the player was offensively
## dashing.
func _hit_by_explorer(explorer: Explorer):
	pass
