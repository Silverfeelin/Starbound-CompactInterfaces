local positionKey = "colorPicker.position"
local colorKey = "colorPicker.color"

function getSerializedPosition()
  return status.statusProperty(positionKey)
end

function setSerializedPosition(pos)
  status.setStatusProperty(positionKey, pos)
end

function getSerializedcolor()
  return status.statusProperty(colorKey)
end

function setSerializedColor(color)
  status.setStatusProperty(colorKey, color)
end

-- http://snipplr.com/view/13086/number-to-hex/
function num2hex(num)
    local hexstr = "0123456789abcdef"
    local s = ""
    while num > 0 do
        local mod = math.fmod(num, 16)
        s = string.sub(hexstr, mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end
    if s == "" then s = "00" end
    if string.len(s) == 1 then s = "0" .. s end
    return s
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