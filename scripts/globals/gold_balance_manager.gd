#class_name GoldBalanceManager
extends Node 

var gold := 0:
	set(value):
		gold = min(value, max_gold)
var max_gold := 0:
	set(value):
		max_gold = value
		gold = min(gold,max_gold)

	
func update_max_gold( gold_change:int):
	max_gold += gold_change

func redistribute(ammount:int, origin:Node)->void:
	print('must redistribute ammount:', ammount, origin)
	if gold + ammount < 0:
		gold = 0
		push_error('gold balance would drop bellow zero') 
		return
	var remaining_gold = ammount
	for node in get_tree().get_nodes_in_group('GoldStorers'):
		print(node, node.owner, node.stored_gold , node.max_stored_gold)
		if node == origin:
			continue
		if ammount > 0:
			var inserted_gold = min(remaining_gold ,  node.max_stored_gold - node.stored_gold  )
			node.stored_gold += inserted_gold 
			remaining_gold -= inserted_gold
			gold += inserted_gold
			
		elif ammount < 0:
			var removed_gold = min(-ammount, node.stored_gold)
			node.stored_gold -= removed_gold
			gold -= removed_gold
			remaining_gold += removed_gold
		else:
			break
		if remaining_gold == 0:
				break
