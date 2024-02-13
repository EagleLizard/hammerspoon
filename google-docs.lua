
-- Parameters:
-- * keyMods - table  of base key modifiers
local function ordinal(time)
  -- Get the day from the time
  local day = os.date("*t", time).day

  -- Determine the ordinal suffix
  local last_digit = day % 10
  local last_two_digits = day % 100

  if last_digit == 1 and last_two_digits ~= 11 then
      return "st"
  elseif last_digit == 2 and last_two_digits ~= 12 then
      return "nd"
  elseif last_digit == 3 and last_two_digits ~= 13 then
      return "rd"
  else
      return "th"
  end
end

-- default_delay = 1500-- microseconds
default_delay = 10000-- microseconds

local function keyStroke(keyMods, keyChar, delayUs)
  delayUs = delayUs or default_delay;
  hs.eventtap.keyStroke(keyMods, keyChar, default_delay)

  -- hs.eventtap.event.newKeyEvent(keyMods, keyChar, true):post()
  -- hs.eventtap.event.newKeyEvent(keyMods, keyChar, false):post()
end
local function keyStrokes(text)
  hs.eventtap.keyStrokes(text)
end


local function writeTime()
  local delay = default_delay
  local now = os.time()
  local timeTb = os.date("*t", now)
  local hourPart = timeTb["hour"]
  if hourPart > 12 then
    hourPart = hourPart - 12;
  end
  -- 6:44 PM
  keyStroke({"cmd", "option"}, "0")
  keyStrokes(os.date(hourPart..":%M %p:",  now))
end

local function writeDate()
  local now = os.time()
  local dateStr = os.date("%m/%d/%Y", now)
  keyStrokes(dateStr)
end

local function init(keyMods)
  
  hs.hotkey.bind(keyMods, "D", function ()
    writeDate()
  end)

  hs.hotkey.bind(keyMods, "N", function ()
    -- hs.eventtap.keyStroke({}, "return")
    keyStroke({"cmd"}, "up")
    keyStroke({}, "down")
    keyStroke({}, "return")
    keyStroke({}, "up")
    -- hs.timer.usleep(1000)
    -- keyStroke({"cmd", "option"}, "0")
    writeTime()
    hs.timer.usleep(10000)
    keyStroke({}, "return")
    keyStroke({}, "tab")
  end)
  
  hs.hotkey.bind(keyMods, "J", function ()
    local delay = default_delay
    hs.notify.new({title="google", informativeText="docs"}):send()
    local allScreens = hs.screen.allScreens()
    -- for idx, currScreen in pairs(allScreens) do
    --   hs.alert.show("google docs", hs.alert.defaultStyle, currScreen)
    -- end
    local win = hs.window.focusedWindow()
    local now = os.time()
    local timeTb = os.date("*t", now)
    local dayPart = timeTb["day"]
    keyStroke({"cmd"}, "up")
    keyStroke({}, "return")
    keyStroke({}, "up")
    keyStroke({"cmd", "option"}, "2")
    -- Tues. Dec 27th, 2023
    hs.eventtap.keyStrokes(os.date("%a. %b "..dayPart..ordinal(now)..", %Y",  now))
    hs.timer.usleep(10000)
    keyStroke({}, "return")
  end)
end

local googleDocsModule = {
  init = init
}
return googleDocsModule
