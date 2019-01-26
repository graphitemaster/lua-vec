local function ro_error(t, k)
  error(('%s field %s is read only'):format(t, k))
end

return function(t, base)
  local meta = { }
  local proxy = { }
  meta.__index = t
  meta.__newindex = ro_error
  meta.__metatable = false
  for k,v in pairs(base) do
    (k:match('^__') and meta or proxy)[k] = base[k]
  end
  return setmetatable(proxy, meta)
end
