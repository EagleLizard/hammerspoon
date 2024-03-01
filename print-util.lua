local function alertAll (alertText)
  local allScreens = hs.screen.allScreens()
  -- local verticalBanner = string.rep("⚒", string.len(configAlertText))
  local verticalBanner = "\n"
  for _, currScreen in pairs(allScreens) do
    hs.alert.show(
      (
        verticalBanner
        .."\n"
        ..alertText
        .."\n"
        ..verticalBanner
      ),
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
  alertAll = alertAll,
  alertActive = alertActive,
}
return printUtil