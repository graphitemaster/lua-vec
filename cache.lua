return function(ctor, cache, ...)
  local params = { ... }
  local node = cache
  for i=1, #params do
    node = node.children and node.children[params[i]]
    if not node then
      result = ctor(...)
      node = cache
      for i=1, #params do
        local param = params[i]
        node.children = node.children or {}
        node.children[param] = node.children[param] or {}
        node = node.children[param]
      end
      node.result = result
      return result
    end
  end
  return node.result
end
