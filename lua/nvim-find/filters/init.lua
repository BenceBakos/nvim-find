-- Easier access to filters by name

local cache = require("nvim-find.filters.cache")
local filename = require("nvim-find.filters.filename")
local join = require("nvim-find.filters.join")
local simple = require("nvim-find.filters.simple")
local sort = require("nvim-find.filters.sort")

local filters = {}

filters.cache = cache.run
filters.filename = filename.run
filters.join = join.run
filters.simple = simple.run
filters.sort = sort.run

return filters
