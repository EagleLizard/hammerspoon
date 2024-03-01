
local printUtil = require('print-util')

hs.loadSpoon("SpoonInstall")

local spoonDeps = {
  "EmmyLua", -- intellisense
  "ReloadConfiguration", -- auto reload on change
}

for _, spoonDep in ipairs(spoonDeps) do
  spoon.SpoonInstall:andUse(spoonDep)
end


spoon.ReloadConfiguration:start()

--shallow copy
local function copy_table(tb)
  local copied = {}
  for k, v in pairs(tb) do
    copied[k] = v
  end
  return copied
end

hyperKeyMods = {"cmd", "alt", "ctrl", "shift" };


googleDocsKeyMods = copy_table(hyperKeyMods);
print(hyperKeyMods)
-- table.insert(googleDocsKeyMods, "J");
local googleDocs = require('google-docs')
googleDocs.init(googleDocsKeyMods);


mouseKeyMods = copy_table(hyperKeyMods)

local mouse = require('mouse')
-- mouse.init(mouseKeyMods)

local win = require('win')
win.init(hyperKeyMods)


-- local emojiKeyMods = copy_table(hyperKeyMods)

-- spoon.Emojis:bindHotkeys({toggle = {hyperKeyMods, 'e'}});
-- spoon.ColorPicker:bindHotkeys({
--   show = {hyperKeyMods, 'C'}
-- })

local function showConfigMessage ()
  local allScreens = hs.screen.allScreens()
  local configAlertText = "⚒️ Hammerspoon Configured ⚒️"
  printUtil.alertAll(configAlertText)
  -- local verticalBanner = string.rep("⚒", string.len(configAlertText))
  -- local verticalBanner = "\n"
  -- for _, currScreen in pairs(allScreens) do
  --   hs.alert.show(
  --     (
  --       verticalBanner
  --       .."\n"
  --       ..configAlertText
  --       .."\n"
  --       ..verticalBanner
  --     ),
  --     hs.alert.defaultStyle,
  --     currScreen
  --   )
  -- end
end

showConfigMessage()


-- hs.hotkey.bind([ ])
