local vec2 = require 'vec2'
local vec3 = require 'vec3'
local vec4 = require 'vec4'

local function test_vec2()
	-- identity through interning
	local a = vec2(1, 1)
	local b = vec2(1, 1)
	assert(a == b)

	-- cache was cleared, should be different
	vec2.clear_cache()
	local c = vec2(1, 1)
	assert(a ~= c)

	-- arithmetic operators
	assert((-c).x == -1)
	assert((-c).y == -1)
	assert(c + c == vec2(2, 2))
	assert(c * c == c) -- 1 * 1 = 1
	assert(c / c == c) -- 1 / 1 = 1

	assert(vec2.dot(c,c) == 2)

	-- withs
	local d = c:with_x(10):with_y(10)
	local e = c:with_y(10):with_x(10)
	assert(d == e)
end

local function test_vec3()
	-- identity through interning
	local a = vec3(1, 1, 1)
	local b = vec3(1, 1, 1)
	assert(a == b)

	-- cache was cleared, should be different
	vec3.clear_cache()
	local c = vec3(1, 1, 1)
	assert(a ~= c)

	-- arithmetic operators
	assert((-c).x == -1)
	assert((-c).y == -1)
	assert((-c).z == -1)
	assert(c + c == vec3(2, 2, 2))
	assert(c * c == c) -- 1 * 1 = 1
	assert(c / c == c) -- 1 / 1 = 1

	assert(vec3.dot(c,c) == 3)

	-- withs
	local d = c:with_x(10):with_y(10):with_z(10)
	local e = c:with_z(10):with_y(10):with_x(10)
	assert(d == e)
end

local function test_vec4()
	-- identity through interning
	local a = vec4(1, 1, 1, 1)
	local b = vec4(1, 1, 1, 1)
	assert(a == b)

	-- cache was cleared, should be different
	vec4.clear_cache()
	local c = vec4(1, 1, 1, 1)
	assert(a ~= c)

	-- arithmetic operators
	assert((-c).x == -1)
	assert((-c).y == -1)
	assert((-c).z == -1)
	assert((-c).w == -1)
	assert(c + c == vec4(2, 2, 2, 2))
	assert(c * c == c) -- 1 * 1 = 1
	assert(c / c == c) -- 1 / 1 = 1

	assert(vec4.dot(c,c) == 4)

	-- withs
	local d = c:with_x(10):with_y(10):with_z(10):with_w(10)
	local e = c:with_w(10):with_z(10):with_y(10):with_x(10)
	assert(d == e)
end

local function test_interning()
	local loop = 65536
	local vecs = {}
	for i=1, loop do
		local rnd = math.random
		local v2 = vec2(rnd(1, 10), rnd(1, 10))
		local v3 = vec3(rnd(1, 10), rnd(1, 10), rnd(1, 10))
		local v4 = vec4(rnd(1, 10), rnd(1, 10), rnd(1, 10), rnd(1, 10))
		vecs[v2] = true
		vecs[v3] = true
		vecs[v4] = true
	end

	local count = 0
	for k,v in pairs(vecs) do
		count = count + 1
	end

	print(('created %d vectors, %d interned references (%d reused vectors)'):format(loop*3, count, loop*3-count))
end

test_vec2()
test_vec3()
test_vec4()

test_interning()


