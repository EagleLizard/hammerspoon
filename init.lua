
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
local googleDocs = require('google-docs')
googleDocs.init(googleDocsKeyMods);

local docs2 = require "docs2"
docs2.init(googleDocsKeyMods)


mouseKeyMods = copy_table(hyperKeyMods)

local mouse = require('mouse')
mouse.init(mouseKeyMods)

local win = require('win')
win.init(hyperKeyMods)


-- local emojiKeyMods = copy_table(hyperKeyMods)

-- spoon.Emojis:bindHotkeys({toggle = {hyperKeyMods, 'e'}});
-- spoon.ColorPicker:bindHotkeys({
--   show = {hyperKeyMods, 'C'}
-- })

local function showConfigMessage ()
  local configAlertText = "⚒️ Hammerspoon Configured ⚒️"
  printUtil.alertAll(configAlertText)
end

showConfigMessage()


-- hs.hotkey.bind([ ])
