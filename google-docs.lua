
local printUtil = require('print-util')

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

--local default_delay = 1500-- microseconds
-- local default_delay = 10000-- microseconds
local default_delay = 20000-- microseconds

local function keyStroke(keyMods, keyChar, delayUs)
  delayUs = delayUs or default_delay;
  hs.eventtap.keyStroke(keyMods, keyChar, delayUs)

  -- hs.eventtap.event.newKeyEvent(keyMods, keyChar, true):post()
  -- hs.eventtap.event.newKeyEvent(keyMods, keyChar, false):post()
end
local function keyStrokes(text)
  hs.eventtap.keyStrokes(text)
end


local function setNormalText()
  keyStroke({"cmd", "option"}, "0")
end
local function setHeading(headingNum)
  keyStroke({"cmd", "option"}, tostring(headingNum))
end


local function writeTime()
  local delay = default_delay
  local now = os.time()
  local timeTb = os.date("*t", now)
  local hourPart = timeTb["hour"]
  if hourPart > 12 then
    hourPart = hourPart - 12;
  elseif hourPart == 0 then
    hourPart = 12 --[[ 12 AM ]]
  end
  -- 6:44 PM
  -- setNormalText()
  keyStrokes(os.date(hourPart..":%M %p:",  now))
end

local function writeDate()
  local now = os.time()
  local dateStr = os.date("%m/%d/%Y", now)
  keyStrokes(dateStr)
end

local function initDebug(keyMods, key)
  local alertIds = nil

  local pressedFn = function ()
    local focusedWindow = hs.window.focusedWindow()
    local jsStr = [[
      (() => {
        const str = "etc";
        return str;
      })();
    ]]
    local ok, jsRes, jsOut = hs.osascript.javascript(jsStr)
    local alertStr = string.format("%s\n%s", focusedWindow:application(), jsRes)
    alertIds = printUtil.alertAll(alertStr)
  end
  local releasedFn = function ()
    if alertIds == nil then
      return nil
    end
    for _, alertId in ipairs(alertIds) do
      hs.alert.closeSpecific(alertId)
    end
  end

  return hs.hotkey.bind(keyMods, "H", pressedFn, releasedFn)
end

local function init(keyMods)
  initDebug(keyMods, "H")

  hs.hotkey.bind(keyMods, "D", function ()
    writeDate()
  end)
  hs.hotkey.bind(keyMods, "T", function ()
    writeTime()
  end)

  hs.hotkey.bind(keyMods, "N", function ()
    local delay = default_delay
    -- hs.eventtap.keyStroke({}, "return")
    keyStroke({"cmd"}, "up")
    hs.timer.usleep(delay)
    keyStroke({}, "down")
    keyStroke({}, "return")
    keyStroke({}, "up")
    -- hs.timer.usleep(1000)
    -- keyStroke({"cmd", "option"}, "0")

    -- setNormalText(3)
    setHeading(3)
    writeTime()
    hs.timer.usleep(10000)
    keyStroke({}, "return")
    -- keyStroke({}, "tab")
    setNormalText()
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
    hs.timer.usleep(delay)
    keyStroke({}, "return")
    keyStroke({}, "up")
    setHeading(2);
    -- Tues. Dec 27th, 2023
    keyStrokes(os.date("%a. %b "..dayPart..ordinal(now)..", %Y",  now))
    hs.timer.usleep(delay)
    keyStroke({}, "return")
  end)
end

local googleDocsModule = {
  init = init
}
return googleDocsModule
