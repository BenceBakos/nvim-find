return {
  -- Maximum height of non-preview finders
  height = 20,
  -- Maximum width of non-preview finders
  width = 100,
  files = {
    -- list of ignore globs for the filename filter
    ignore = {},
  },
  search = {
    -- start with all result groups collapsed
    start_closed = false,
  },
  -- fuzzy find file in these paths too(list of directory paths as table)
  alternative_paths = nil
}
