

local mouseModuleState = {
  jigglerToggle = false,
  jiggleCount = 0,
  autoScrollDownEnabled = false
}

local function jiggler()
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
end

local function autoScrollDown()
  mouseModuleState.autoScrollDownEnabled = not mouseModuleState.autoScrollDownEnabled
  local enabledStr;
  if mouseModuleState.autoScrollDownEnabled then
    enabledStr = "true"
  else
    enabledStr = "false"
  end
  hs.alert.show("autoScrollDownEnabled: "..enabledStr);
  local function scrollDown()
    if mouseModuleState.autoScrollDownEnabled then
      hs.eventtap.scrollWheel({0, -1500}, {}, "pixel")
    end
    hs.timer.doAfter(0.5, scrollDown)
  end
  scrollDown()
end

local function init(keyMods)
  hs.hotkey.bind(keyMods, "pagedown", autoScrollDown);
  hs.hotkey.bind(keyMods, "M", jiggler);
end

local mouseModule = {
  init = init
}
return mouseModule


