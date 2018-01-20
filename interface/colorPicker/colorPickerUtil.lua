local positionKey = "colorPicker.position"
local colorKey = "colorPicker.color"

-- See setSerializedPosition.
function getSerializedPosition()
  return status.statusProperty(positionKey)
end

-- The serialized position is used to show the user the selected color.
-- This prevents us from having to know the position of each selectable color.
function setSerializedPosition(pos)
  status.setStatusProperty(positionKey, pos)
end

-- {r,g,b} [0-255] or nil.
function getSerializedcolor()
  return status.statusProperty(colorKey)
end

-- {r,g,b} [0-255] or nil.
function setSerializedColor(color)
  status.setStatusProperty(colorKey, color)
end

--[[
  Clamps and returns a value between the minimum and maximum value.
  @param i - Value to clamp.
  @param low - Minimum bound (inclusive).
  @param high - Maximum bound (inclusive).
  @return - low when i<low, high when i>high, or i.
]]
function math.clamp(i, low, high)
  if low > high then low, high = high, low end
  return math.min(high, math.max(low, i))
end