

local mouseModuleState = {
  jigglerToggle = false,
  jiggleCount = 0
}

local function init(keyMods)
  hs.hotkey.bind(keyMods, "M", function()
    mouseModuleState.jigglerToggle = not mouseModuleState.jigglerToggle
    local toggleStr;
    if mouseModuleState.jigglerToggle then
      toggleStr = "true"
    else 
      toggleStr = "false"
    end
    hs.alert.show("M "..toggleStr);
    local function jiggle()
      if mouseModuleState.jigglerToggle then
        local moveBy = 50
        local nextJiggleCount = mouseModuleState.jiggleCount + 1
        if nextJiggleCount > 3 then
          nextJiggleCount = 0
        end
        local currMousePos = hs.mouse.absolutePosition()
        if nextJiggleCount == 0 then
          -- move right
          currMousePos.x = currMousePos.x + moveBy;
        elseif nextJiggleCount == 1 then 
          -- move down
          currMousePos.y = currMousePos.y + moveBy;
        elseif nextJiggleCount == 2 then 
          -- move left
          currMousePos.x = currMousePos.x - moveBy;
        elseif nextJiggleCount == 3 then 
          -- move up
          currMousePos.y = currMousePos.y - moveBy;
        end
        hs.mouse.absolutePosition(currMousePos)
        mouseModuleState.jiggleCount = nextJiggleCount
        hs.alert.show(mouseModuleState.jiggleCount.."\n"..currMousePos.x..","..currMousePos.y);
        

        
        hs.timer.doAfter(1, jiggle)
      end
    end
    jiggle()
  end)
end


local mouseModule = {
  init = init
}
return mouseModule


