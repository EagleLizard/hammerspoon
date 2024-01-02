
-- hs.loadSpoon("AClock")
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
--   spoon.AClock:toggleShow()
-- end)

-- hs.loadSpoon("Cherry")
hs.loadSpoon('EmmyLua')
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
--shallow copy
local function copy_table(tb)
  local copied = {}
  for k, v in pairs(tb) do
    copied[k] = v
  end
  return copied
end

-- function reloadConfig(files)
--   doReload = false
--   for _,file in pairs(files) do
--       if file:sub(-4) == ".lua" then
--           doReload = true
--       end
--   end
--   if doReload then
--       hs.reload()
--   end
-- end
-- myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
-- hs.alert.show("Config loaded")

hyperKeyMods = {"cmd", "alt", "ctrl", "shift"};


googleDocsKeyMods = copy_table(hyperKeyMods);
print(hyperKeyMods)
table.insert(googleDocsKeyMods, "J");
local googleDocs = require('google-docs')
googleDocs.init(googleDocsKeyMods);


-- hs.hotkey.bind([ ])
