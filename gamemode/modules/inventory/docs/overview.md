# Inventory Module Overview

This folder contains docs for the inventory system.

- `sv_inventory.lua`: server logic for inventory actions.
- `cl_inventory.lua`: client user interface.
- `sh_inventory.lua`: shared definitions, item catalog, and rarity system.

The new rarity system gives every inventory item a quality tier:
- common
- uncommon
- rare
- legendary
- god
- ultra_god
- admin

Items and suits now show their rarity when viewed in the inventory UI.
