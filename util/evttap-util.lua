
local default_delay_us = 20000 -- microseconds

local function keyStroke(keyMods, keyChar, delayUs)
  delayUs = delayUs or default_delay_us
  hs.eventtap.keyStroke(keyMods, keyChar, delayUs)
end
local function keyStrokes(text)
  hs.eventtap.keyStrokes(text)
end

local evttapUtilModule = {
  default_delay_us = default_delay_us,
  keyStroke = keyStroke,
  keyStrokes = keyStrokes,
}
return evttapUtilModule
