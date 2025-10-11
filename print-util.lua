local function getAlertStr (alertText)
  local verticalBanner = '\n';
  local alertStr = (
    verticalBanner
    .."\n"
    ..alertText
    .."\n"
    ..verticalBanner
  )
  return alertStr;
end

local function alert(alertText, screen, seconds)
  return hs.alert.show(
    getAlertStr(alertText),
    hs.alert.defaultStyle,
    screen,
    seconds
  )
end

local function alertAll (alertText, seconds)
  local allScreens = hs.screen.allScreens()
  local alertIds = {}
  if allScreens == nil then
    return alertIds
  end
  -- local verticalBanner = string.rep("~", string.len(configAlertText))..'\n'
  -- local verticalBanner = "\n"
  for _, currScreen in pairs(allScreens) do
    local currAlertId = hs.alert.show(
      getAlertStr(alertText),
      hs.alert.defaultStyle,
      currScreen,
      seconds
    )
    table.insert(alertIds, currAlertId)
  end
  return alertIds
end

local function alertActive (alertText)
  local currScreen = hs.mouse.getCurrentScreen()
  hs.alert.show(
    alertText,
    hs.alert.defaultStyle,
    currScreen
  )
end

local printUtil = {
  alert = alert,
  alertAll = alertAll,
  alertActive = alertActive,
}
return printUtil