require "/interface/paintPicker/paintPickerUtil.lua"

local serializeSelection = false

local wColors = "colors"
local widgetColorIndices = { none = -1, white = 0, black = 1, red = 2, orange = 3, yellow = 4, green = 5, blue = 6, pink = 7 }

function init()
  sb.logInfo("PaintPicker: Initializing...")

  -- Load serialized data
  serializeSelection = config.getParameter("serializeSelection")
  if serializeSelection == nil then
    serializeSelection = false
  elseif serializeSelection then
    loadSerializedColor()
  end

  sb.logInfo("PaintPicker: Initialized!")
end

local logged
function update()
  -- Log update message once
  if not logged then
    logged = true
    sb.logInfo("PaintPicker: Update also works! This message will only appear once.")
  end
end

function uninit()
  sb.logInfo("PaintPicker: Uninitialized!")
end

-- Serializes the selected color.
function pickColor(_, data)
  -- data == getSelectedColor()
  sb.logInfo("PaintPicker: You selected the color %s.", getSelectedColor())

  if serializeSelection then
    setSerializedColor(data)
  end
end

-- Gets the color from the selected widget.
function getSelectedColor()
  local index = widget.getSelectedOption(wColors)
  local data = widget.getData(string.format("%s.%s", wColors, index))
  return data
end

-- Loads the serialized color and updates the widget selection.
function loadSerializedColor()
  local selectedColor = getSerializedColor()
  if selectedColor then
    local selectionIndex = widgetColorIndices[selectedColor]
    if selectionIndex then
      -- Note: this will also call pickColor.
      widget.setSelectedOption(wColors, selectionIndex)
    end
  end
end
