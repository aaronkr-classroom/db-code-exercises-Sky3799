Table UserAccount {
	user_id INT [pk]
	email VARCHAR
	password VARCHAR
	created_at TIMESTAMP
}

Table Character {
	character_id INT [pk]
	user_id INT
	name VARCHAR
	levle INT
	class VARCHAR
}

Table Item {
	item_id INT [pk]
	name VARCHAR
	type VARCHAR
}

Table Inventory{
	character_id INT
	item_id INT
	quantity INT
	indexes {
		(character_id, item_id)
	}
}

Ref: Character.user_id > UserAccount.user_id
Ref: Inventory.character_id > Character.character_id
Ref: Inventory.item_id > Item.item_id