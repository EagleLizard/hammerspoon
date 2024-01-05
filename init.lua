
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

hyperKeyMods = {"cmd", "alt", "ctrl", "shift"};


googleDocsKeyMods = copy_table(hyperKeyMods);
print(hyperKeyMods)
table.insert(googleDocsKeyMods, "J");
local googleDocs = require('google-docs')
googleDocs.init(googleDocsKeyMods);


-- hs.hotkey.bind([ ])
