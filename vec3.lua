local sqrt = math.sqrt

local ro = require 'ro'
local cache = require 'cache'

local vec = {}
local intern = {}

local function new(x, y, z)
	return ro({x=x, y=y, z=z}, vec)
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

function vec.cross(a, b)
	local x = a.y*b.z - a.z*b.y
	local y = a.z*b.x - a.x*b.z
	local z = a.x*b.y - a.y*b.x
	return ctor(x, y, z)
end

function vec.dot(a, b)
	return a.x*b.x + a.y*b.y + a.z*b.z
end

function vec:__add(o)
	return ctor(self.x+o.x, self.y+o.y, self.z+o.z)
end

function vec:__sub(o)
	return ctor(self.x-o.x, self.y-o.y, self.z-o.z)
end

function vec:__mul(o)
	return ctor(self.x*o.x, self.y*o.y, self.z*o.z)
end

function vec:__div(o)
	return ctor(self.x/o.x, self.y/o.y, self.z/o.z)
end

function vec:__unm()
	return ctor(-self.x, -self.y, -self.z)
end

function vec:with_x(x)
	return ctor(x, self.y, self.z)
end

function vec:with_y(y)
	return ctor(self.x, y, self.z)
end

function vec:with_z(z)
	return ctor(self.x, self.y, z)
end

function vec:length()
	return sqrt(vec.dot(self, self))
end

function vec:normalize()
	local length = self:length()
	return ctor(self.x/length, self.y/length, self.z/length)
end

function vec:floor()
	return ctor(floor(self.x), floor(self.y), floor(self.z))
end

return ctor
