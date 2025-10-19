
local obj = require "./util/obj"

--[[
  overrides for hs.alert.defaultStyle
]]
local defaultAlertStyle = {
  textSize = 20,
  radius = 16,
  strokeColor = { white = 1, alpha = 0.75 },
  textFont = "IBM Plex Mono",
}

local function getAlertStr (alertText)
  -- local verticalBanner = "\n";
  local verticalBanner = "";
  local alertStr = (
    verticalBanner
    ..alertText
    ..verticalBanner
  )
  return alertStr;
end

local function alert(alertText, style, screen, seconds)
  if style == nil then
    style = defaultAlertStyle
  else
    style = obj.assign({}, defaultAlertStyle, style)
  end
  return hs.alert.show(
    getAlertStr(alertText),
    style,
    screen,
    seconds
  )
end

local function alertAll(alertText, style, seconds)
  local allScreens = hs.screen.allScreens()
  local alertIds = {}
  if allScreens == nil then
    return alertIds
  end
  for _, currScreen in pairs(allScreens) do
    local currAlertId = alert(
      alertText,
      style,
      currScreen,
      seconds
    )
    table.insert(alertIds, currAlertId)
  end
  return alertIds
end

local function alertActive (alertText, style, seconds)
  local currScreen = hs.mouse.getCurrentScreen()
  alert(alertText, style, currScreen, seconds)
end

local printUtil = {
  alert = alert,
  alertAll = alertAll,
  alertActive = alertActive,
}
return printUtil