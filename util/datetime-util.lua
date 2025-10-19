
---@param n integer
local function ordinal(n)
  local last2Digits = n % 100
  -- handle special case 11, 12, 13
  if last2Digits >= 11 and last2Digits <= 13 then
    return "th"
  end
  local lastDigit = last2Digits % 10
  if lastDigit == 1 then
    return "st"
  elseif lastDigit == 2 then
    return "nd"
  elseif lastDigit == 3 then
    return "rd"
  end
  return "th"
end

---
---@param us integer
---@return number
local function usToSecs(us)
  return us * 1e-6
end

local function getTimeStr(time)
  time = time or os.time()
  local hour = os.date("*t").hour
  if hour > 12 then
    hour = hour - 12
  elseif hour == 0 then
    hour = 12
  end
  return os.date(hour..":%M %p", time)
end

local datetimeUtil = {
  ordinal = ordinal,
  getTimeStr = getTimeStr,

  usToSecs = usToSecs,
}
return datetimeUtil
