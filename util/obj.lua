--[[
  Utils for working with lua tables as objects.
]]

---JavaScript-style Object.assign function
---@param destObj table
---@params ... table
---@return table
local function assign(destObj, ...)
  local srcObjs = { ... }
  for _, srcObj in ipairs(srcObjs) do
    if srcObj ~= nil then
      for k, v in pairs(srcObj) do
        destObj[k] = v
      end
    end
  end
  return destObj
end

local obj = {
  assign = assign,
}
return obj
