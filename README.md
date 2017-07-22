# Compact Interfaces

A collection of some compact standalone ScriptPane interfaces. They serve mostly as templates.

To prevent conflicts with other mods when copying any files from this repository, it is recommended to rename or move said files.

## Opening an interface

There are various ways of opening ScriptPane interfaces. Please note that not all of the possible methods are listed below.

### Object

Interactable objects can be customized to open a ScriptPane. Note that not all interactable objects allow modification of the `interactAction` parameter.

Object parameters:
```json
{
  "interactAction" : "ScriptPane",
  "interactData" : "/interface/yourInterface.config"
}
```

Sample:
```
/spawnitem capturestation 1 '{"interactAction":"ScriptPane","interactData":"/interface/paintPicker/paintPicker.config"}'
```

### Lua

### • player table
Any script with access to the player table can open a ScriptPane through the function `player.interact`.

```lua
local cfg = root.assetJson("/interface/paintPicker/paintPicker.config")
player.interact("ScriptPane", cfg)
-- Can only open ONE interface at a time:
--player.interact("ScriptPane", cfg, player.id())
```

### • activeitem table

Active items can also open ScriptPane interfaces. `activeitem.interact` functions the same as `player.interact`.

```lua
local cfg = root.assetJson("/interface/paintPicker/paintPicker.config")
activeitem.interact("ScriptPane", cfg)
-- Can only open ONE interface at a time:
--activeitem.interact("ScriptPane", cfg, activeItem.ownerEntityId())
```

## Interfaces

### Paint Picker

The paint picker allows users to select a paint color. The interface goes well with code that dyes tiles using `world.setMaterialColor(position, layerName, colorIndex)`.

If a selection was previously made, it will automatically be selected when opening the interface.

!["Paint Picker"](https://i.imgur.com/cfa6MkT.png "Paint Picker")

#### paintPickerUtil

The utility script can be used to share the selected paint color with other scripts.

```lua
require "/interface/paintPicker/paintPickerUtil.lua"
```

* `getSerializedColor()`  
Returns a string representing the selected color. With no color selected (first option), this returns `nil`.
* `setSerializedColor(color)`  
Serializes the given string representation of a color.  
Values: `"none", "white", "black", "red", "orange", "yellow", "green", "blue", "pink"`
* `getColorIndex(color)`  
Returns the color index of the given color string, which can be used for the `world.setMaterialColor` function.

### Color Picker

The color picker allows users to select (basically) any color. The interface uses the color gradient from the EASEL interface.

If a selection was previously made, it will automatically be shown when opening the interface.

!["Color Picker"](https://i.imgur.com/HacXcrk.png "Color Picker")

#### colorPickerUtil

The utility script can be used to share the selected color with other scripts.

```lua
require "/interface/colorPicker/colorPickerUtil.lua"
```

* `getSerializedColor()`  
Returns a table containg the red, green and blue color values (`0-255`).  
I.e. `{255, 255, 255}` for white.
* `setSerializedColor(color)` *Not recommended for use.*  
Sets the serialized color. The format should be the same as described above, or nil.
* `getSerializedPosition()` *Not recommended for use.*  
Returns the selected position on the color gradient. Primarily used to show the selected color when opening the interface.
* `setSerializedPosition(pos)` *Not recommended for use.*  
Sets the serialized color position. Primarily used to show the selected color when opening the interface.