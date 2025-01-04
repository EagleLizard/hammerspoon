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

local function alert(alertText, screen)
  hs.alert.show(
    getAlertStr(alertText),
    hs.alert.defaultStyle,
    screen
  )
end

local function alertAll (alertText)
  local allScreens = hs.screen.allScreens()
  -- local verticalBanner = string.rep("~", string.len(configAlertText))..'\n'
  -- local verticalBanner = "\n"
  for _, currScreen in pairs(allScreens) do
    hs.alert.show(
      getAlertStr(alertText),
      hs.alert.defaultStyle,
      currScreen
    )
  end
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