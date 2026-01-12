
--[[
redoing some stuff for journaling & writing. Iteration on google-docs.lua
some goals:
  - manage hotkey bindings for specific actions using modal hotkeys
    - see: https://www.hammerspoon.org/docs/hs.hotkey.modal.html
  - insert new entries at the bottom instead of the top
    - reverse-chronological to chronological
Modal hotkeys:
  My initial idea is that hotkeys bound to a mode should act
    as on-shot hotkeys; that is, a key bound to a mode should
    exit the mode when active.
  I also think that a mode should automatically expire after
    some time. If a mode is activated and no modal keys are
    activated within N seconds, the mode should exit on its own.
    - heuristic for this is the amount of time I might space out
      after activating a mode trying to remember what I was doing
Reference:
  - Good discussion on managing hs.modal so that when a key that's not
    valid is pressed, it exits the mode: https://github.com/Hammerspoon/hammerspoon/issues/848
]]

local printUtil = require "print-util"
local dtUtil = require "util.datetime-util"

local default_delay_us = 20000 -- microseconds
local exit_timeout_secs = 5

---@type hs.hotkey.modal
local doc_k
local doc_kActive = false

local function keyStroke(keyMods, keyChar, delayUs)
  delayUs = delayUs or default_delay_us
  hs.eventtap.keyStroke(keyMods, keyChar, delayUs)
end
local function keyStrokes(text)
  hs.eventtap.keyStrokes(text)
end

local function getDateLong(time)
  time = time or os.time()
  local day = os.date("*t", time).day + 0
  -- Tues. Dec 27th, 2023
  local dateLongStr = os.date("%a. %b "..day..dtUtil.ordinal(day)..", %Y", time)
  return dateLongStr
end
local function getDateIso(time)
  time = time or os.time()
  return os.date("%Y-%m-%d", time)
end

local function setNormalText()
  keyStroke({"cmd", "option"}, "0")
end
local function setHeading(headingNum)
  keyStroke({"cmd", "option"}, tostring(headingNum))
end

local function writeTimeEntry()
  local delay = default_delay_us
  local timeStr = dtUtil.getTimeStr()
  keyStroke({}, "pagedown")
  keyStroke({}, "return")
  setHeading(2)
  keyStrokes(timeStr..":")
  hs.timer.doAfter(dtUtil.usToSecs(delay), function ()
    keyStroke({}, "return")
    setNormalText()
  end)
end

local function writeDayEntry()
  local delay = default_delay_us
  keyStroke({}, "pagedown")
  keyStroke({}, "return")
  setHeading(1)
  keyStrokes(getDateLong())
  hs.timer.doAfter(dtUtil.usToSecs(delay), function ()
    writeTimeEntry()
  end)
end

local function writeTime()
  keyStrokes(dtUtil.getTimeStr())
end
local function writeDate()
  keyStrokes(os.date("%m/%d/%Y", os.time()))
end
local function writeDateLong()
  keyStrokes(getDateLong())
end
local function writeDateIso()
  keyStrokes(getDateIso())
end
local function writePlainEntry()
  local plainEntry = "_> "..getDateLong().." | "..dtUtil.getTimeStr()..":"
  keyStrokes(plainEntry)
end

local function oneShot(mods, key, fn)
  doc_k:bind(mods, key, function ()
    fn()
    doc_k:exit()
  end)
end

local function initMode(keyMods)
  ---@type hs.timer
  local exitTimer

  doc_k = hs.hotkey.modal.new(keyMods, "K")
  -- exit mode
  oneShot(keyMods, "K", function ()
    doc_k:exit()
  end)
  oneShot('', "escape", function ()
    doc_k:exit()
  end)

  function doc_k:entered()
    doc_kActive = true;
    printUtil.alertActive("entered docs2")
    exitTimer = hs.timer.doAfter(exit_timeout_secs, function ()
      doc_k:exit()
    end)
  end
  function doc_k:exited()
    if not doc_kActive then
      return
    end
    doc_kActive = false
    printUtil.alertActive("exited docs2")
  end
end

local function init(keyMods)
  initMode(keyMods)
  oneShot("", "j", writePlainEntry)
  -- oneShot(keyMods, "J", writeDayEntry)
  -- oneShot(keyMods, "N", writeTimeEntry)
  oneShot('', "t", writeTime)
  oneShot('', "d", writeDate)
  oneShot('', "l", writeDateLong)
  oneShot(keyMods, "I", writeDateIso)
end

local docs2 = {
  init = init,
}
return docs2
