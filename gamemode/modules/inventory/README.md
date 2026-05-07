Inventory module
================

This module handles the Redline inventory system.

Files:
- `sh_inventory.lua`: shared item definitions and rarity metadata.
- `sv_inventory.lua`: server-side item management, equip/unequip, and item usage.
- `cl_inventory.lua`: client-side inventory UI.

How it works:
- Each inventory item has an `id`, `name`, `type`, and `rarity`.
- Suits are stored in the equipped slot and can be upgraded.
- Consumables heal or restore armor, with better rarities giving better bonuses.
- Type `!inventory` or `!suit` to open the inventory menu.
