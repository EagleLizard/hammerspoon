local function alertAll (alertText)
  local allScreens = hs.screen.allScreens()
  -- local verticalBanner = string.rep("⚒", string.len(configAlertText))
  local verticalBanner = "\n"
  for _, currScreen in pairs(allScreens) do
    hs.alert.show(
      alertText,
      hs.alert.defaultStyle,
      currScreen
    )
  end
end

local printUtil = {
  alertAll = alertAll,
}
return printUtil