require "/interface/colorPicker/colorPickerUtil.lua"
require "/interface/colorPicker/spectrum.lua"
require "/scripts/vec2.lua"

local serializeSelection = false

local canvas
local currentPosition = {-1, -1}
local holding = false

function init()
  sb.logInfo("ColorPicker: Initializing...")

  canvas = widget.bindCanvas("eventCanvas")

  -- Load serialized data
  serializeSelection = config.getParameter("serializeSelection")
  if serializeSelection == nil then
    serializeSelection = false
  elseif serializeSelection then
    loadSerializedColor()
  end

  sb.logInfo("ColorPicker: Initialized!")
end

-- Loads the serialized color and updates the canvas selection.
function loadSerializedColor()
  local pos = getSerializedPosition()
  if pos then selectColorFromPosition(pos) end
end

local logged
function update()
  -- Log update message once
  if not logged then
    logged = true
    sb.logInfo("ColorPicker: Update also works! This message will only appear once.")
  end

  -- Update color when dragging
  dragUpdate()
end

-- Called every frame while dragging, to update the selected color.
function dragUpdate()
  if holding then
    local pos = canvas:mousePosition()
    if not vec2.eq(currentPosition, pos) then
      selectColorFromPosition(pos)
      currentPosition = pos
    end
  end
end

function uninit()
  sb.logInfo("ColorPicker: Uninitialized!")
end

-- Called when pressing on the canvas
-- While left mouse button is pressed, update selected color.
-- When right mouse button is pressed, clear selection.
function canvasClickEvent(position, button, isButtonDown)
  if button == 0 then
    holding = isButtonDown
  elseif button == 2 and isButtonDown then
    clearColor()
  end
end

function clearColor()
  canvas:clear()
  if serializeSelection then
    setSerializedPosition(nil)
    setSerializedColor(nil)
  end
end

function selectColorFromPosition(pos)
  -- Clamp position within canvas bounds
  local clampedPos = {
    math.clamp(pos[1], 0, 157),
    math.clamp(pos[2], 0, 54)
  }
  -- Invert Y
  local colorPos = {clampedPos[1] + 1, 54 - clampedPos[2] + 1}

  if pos[1] < 1 then pos[1] = 1 end
  if pos[2] < 1 then pos[2] = 1 end
  if pos[1] > 141 then pos[1] = pos[1] - 16 end
  if pos[1] > 141 then pos[1] = 141 end
  if pos[2] > 38 then pos[2] = pos[2] - 16 end
  if pos[2] > 38 then pos[2] = 38 end

  -- Get color
  local color = spectrum[colorPos[1]][colorPos[2]]

  -- Set image
  local img = "/interface/colorPicker/indicator.png?replace;ffffff="..num2hex(color[1])..num2hex(color[2])..num2hex(color[3])
  canvas:clear()
  canvas:drawImage(img, pos)

  currentPosition = pos

  -- Serialize
  if serializeSelection then
    setSerializedPosition(pos)
    setSerializedColor(color)
  end
end