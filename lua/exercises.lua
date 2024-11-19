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


function first_then_lower_case(strings, predicate)
  if #strings == 0 then
    return nil
  end
  for _, string in ipairs(strings) do
    if type(string) ~= "string" then
      error("strings must be a list of type str")
    end
    if predicate(string) then
      return string.lower(string)
    end
  end
end


function powers_generator(base, limit)
  local power = 1
  return coroutine.create(function()
    while power <= limit do
      coroutine.yield(power)
      power *= base
    end
  end)
end


function say(initial_string)
  if initial_string == nil then
    return ""
  end
  function nextsay(next_string)
    if next_string == nil then
      return initial_string
    else
      return say(initial_string .. " " .. next_string)
    end
  end
  return nextsay
end


function meaningful_line_count(filename)
  local file, err = io.open(filename, "r")
  if not file then
    error("No such file")
  end
  local count = 0
  for line in file:lines() do
    local trimmed = line:match("^%s*(.-)%s*$")
    if #trimmed > 0 and trimmed:sub(1, 1) ~= "#" then
      count = count + 1
    end
  end
  file:close()
  return count
end

Quaternion = {}
Quaternion.__index = Quaternion
  
function Quaternion.new(a, b, c, d)
  local self = setmetatable({}, Quaternion)
  self.a, self.b, self.c, self.d = a or 0, b or 0, c or 0, d or 0
  return self
end
  
function Quaternion:coefficients()
  return {self.a, self.b, self.c, self.d}
end
  
function Quaternion:conjugate()
  return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end
  
function Quaternion.__add(q1, q2)
  return Quaternion.new(
    q1.a + q2.a,
    q1.b + q2.b,
    q1.c + q2.c,
    q1.d + q2.d
  )
end
  
function Quaternion.__mul(q1, q2)
  return Quaternion.new(
    q1.a * q2.a - q1.b * q2.b - q1.c * q2.c - q1.d * q2.d,
    q1.a * q2.b + q1.b * q2.a + q1.c * q2.d - q1.d * q2.c,
    q1.a * q2.c - q1.b * q2.d + q1.c * q2.a + q1.d * q2.b,
    q1.a * q2.d + q1.b * q2.c - q1.c * q2.b + q1.d * q2.a
  )
end
  
function Quaternion.__eq(q1, q2)
  return q1.a == q2.a and q1.b == q2.b and q1.c == q2.c and q1.d == q2.d
end
  
function Quaternion:__tostring()
  local parts = {}
  if self.a ~= 0 then table.insert(parts, tostring(self.a)) end
  if self.b ~= 0 then
    if self.b == 1 then
      table.insert(parts, "i")
    elseif self.b == -1 then
      table.insert(parts, "-i")
    else
      table.insert(parts, tostring(self.b) .. "i")
    end
  end
  if self.c ~= 0 then
    if self.c == 1 then
      table.insert(parts, "j")
    elseif self.c == -1 then
      table.insert(parts, "-j")
    else
      table.insert(parts, tostring(self.c) .. "j")
    end
  end
  if self.d ~= 0 then
    if self.d == 1 then
      table.insert(parts, "k")
    elseif self.d == -1 then
      table.insert(parts, "-k")
    else
      table.insert(parts, tostring(self.d) .. "k")
    end
  end
  if #parts == 0 then
    return "0"
  else
    local string = table.concat(parts, "+")
    string = result:gsub("%+%-", "-") -- fix signs like "+-" to "-"
    return string
  end
end
  