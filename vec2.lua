local sqrt = math.sqrt

local ro = require 'ro'
local cache = require 'cache'

local vec = {}
local intern = {}

local function new(x, y)
	return ro({x=x, y=y}, vec)
end

local function caching_new(_, ...)
	return cache(new, intern, ...)
end

local function clear_cache()
	intern = {}
end

local ctor = setmetatable(vec, { __call = caching_new, __metatable = false })

function vec.clear_cache()
	clear_cache()
end

function vec.dot(a, b)
	return a.x*b.x + a.y*b.y
end

function vec:__add(o)
	return ctor(self.x+o.x, self.y+o.y)
end

function vec:__sub(o)
	return ctor(self.x-o.x, self.y-o.y)
end

function vec:__mul(o)
	return ctor(self.x*o.x, self.y*o.y)
end

function vec:__div(o)
	return ctor(self.x/o.x, self.y/o.y)
end

function vec:__unm()
	return ctor(-self.x, -self.y)
end

function vec:with_x(x)
	return ctor(x, self.y)
end

function vec:with_y(y)
	return ctor(self.x, y)
end

function vec:length()
	return sqrt(vec.dot(self, self))
end

function vec:normalize()
	local length = self:length()
	return ctor(self.x/length, self.y/length)
end

function vec:floor()
	return ctor(floor(self.x), floor(self.y))
end

return ctor
