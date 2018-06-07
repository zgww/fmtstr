--lua模板字符串
--类似于 javascript中的 反引号字符串，
--python3.6的 f''
local m = {}
package.loaded[...] = m

m.version = '0.1.0'

local tpl = require 'resty.template'

local function env(f)
	local t = {}
	for i = 1, math.maxinteger, 1 do
		local name, value = debug.getlocal(f or 2, i)
		if not name then
			break
		end
		t[name] = tostring(value)
	end
	return t
end
function m.fmt(str)
	local _env = env(3)
    return tpl.compile(str, nil, true)(_env)
end

_G.f = m.fmt
