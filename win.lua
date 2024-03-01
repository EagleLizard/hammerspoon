
local printUtil = require('print-util')

local function getScreenPointFromPercent(point, screen)
  local xPosPercent = point.x * screen.w
  local yPosPercent = point.y * screen.h
  local xPos = xPosPercent + screen.x
  local yPos = yPosPercent + screen.y
  return {
    x=xPos,
    y=yPos,
  }
end

local function getMousePosPercent(mousePosPercent, targetScreen)
  local xPos = mousePosPercent.x / targetScreen.w
  local yPos = mousePosPercent.y / targetScreen.h
  return {
    x=xPos,
    y=yPos,
  }
end

local function moveMouseRelative(srcScreen, targetScreen)
  local activeFrame = srcScreen:fullFrame()
  local mousePos = hs.mouse.getRelativePosition();
  local winFrame = targetScreen:fullFrame()
  local mousePosPercent = getMousePosPercent(mousePos, activeFrame)
  local nextMousePos = getScreenPointFromPercent(mousePosPercent, winFrame)
  hs.mouse.absolutePosition(nextMousePos)
end

local function moveMouseDirectional(direction)
  -- -1 is left, 1 is right
  local allScreens = hs.screen.allScreens()
  local currScreen = hs.mouse.getCurrentScreen()
  local currIdx = -1
  local nextIdx = -1
  for k,v in ipairs(allScreens) do
    if v == currScreen then
      currIdx = k
    end
  end
  local isCurrScreen = false
  local terminalIdx = -1
  if direction == -1 then
    isCurrScreen = currIdx == 1
    terminalIdx = #allScreens
  else
    isCurrScreen = currIdx == #allScreens
    terminalIdx = 1
  end
  if isCurrScreen then
    nextIdx = terminalIdx
  else
    nextIdx = currIdx + direction
  end
  local nextScreen = allScreens[nextIdx]
  moveMouseRelative(currScreen, nextScreen)
end

local function init(keyMods)
  hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(win, appName)
    local activeScreen = hs.mouse.getCurrentScreen()
    local winScreen = win:screen()
    moveMouseRelative(activeScreen, winScreen)
  end)

  hs.hotkey.bind(keyMods, "left", function ()
    moveMouseDirectional(-1)
  end)

  hs.hotkey.bind(keyMods, "right", function ()
    moveMouseDirectional(1)
  end)
end

local winModule = {
  init = init
}

return winModule
