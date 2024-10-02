-- Search through the project with `rg`

local async = require("nvim-find.async")
local job = require("nvim-find.job")
local config = require("nvim-find.config")
local table = require("table")

local rg = {}

function rg.grep(state)
	if state.query == "" then
		return {}
	end

	for stdout, stderr, close in job.spawn("rg", { "--vimgrep", "--smart-case", state.query }) do
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

function rg.files(state)
	local params = {
		'--files',
		'./'
	}

	if config.alternative_paths ~= nil and next(config.alternative_paths) ~= nil then
		for _,path in ipairs(config.alternative_paths) do
			table.insert(params, path)
		end
	end

	for stdout, stderr, close in job.spawn("rg", params) do
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

return rg
