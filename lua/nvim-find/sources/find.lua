-- Find files in the current directory using `find`

local async = require("nvim-find.async")
local job = require("nvim-find.job")

local find = {}

function find.run(state)
	for stdout, stderr, close in job.spawn("find", { ".", "-type", "f" }) do
		if state.closed() or state.changed() or stderr ~= "" then
			close()
			coroutine.yield(async.stopped)
		end

		if stdout ~= "" then
			coroutine.yield({ as_string = stdout })
		else
			coroutine.yield(async.pass)
		end
	end
end

return find
