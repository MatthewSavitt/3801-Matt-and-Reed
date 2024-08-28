function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
function first_then_lower_case(strings, min_length)
  -- Check if strings is an array and min_length is a number
  if type(strings) ~= "table" then
    error("strings must be a list of type str")
  elseif math.type(min_length) ~= "integer" then
    error("min_length must be an integer")
  -- Check if the array is empty
  elseif #strings == 0 then
    return nil
  end
  -- Iterate through the array and find the first string with a length greater than or equal to min_length
  for _, string in ipairs(strings) do
    if #string >= min_length then
      return string.lower(string)
    end
  end
  -- If no string meets the minimum length, return nil
  return nil
end

-- Write your powers generator here
function powers_generator(base, exponent)
  return coroutine.wrap(function()
    for power = 0, exponent - 1 do
      coroutine.yield(base ^ power)
    end
    coroutine.yield(nil)
  end)
end
-- Write your say function here

-- Write your line count function here

-- Write your Quaternion table here
