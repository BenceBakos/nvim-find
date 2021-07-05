# nvim-find

A fast and simple finder plugin for Neovim

## Goals

* **Speed:** The finder should open fast and filter quickly
* **Simplicity:** The finder should be unobtrusive and not distract from flow
* **Extensible:** It should be easy to create custom finders

## Default Finders

For usage instructions see the [Finders](#finders) section below.

* **Files:** Find files in the current working directory respecting gitignore
* **Buffers:** List open buffers
* **Search:** Search using ripgrep in the current working directory

## Requirements

**Requires Neovim >= v0.5.0**

Optional dependencies:
* [`fd`](https://github.com/sharkdp/fd) for listing files.
* [`ripgrep`](https://github.com/BurntSushi/ripgrep) for listing files or for project search.
  `ripgrep` may be used in place of fd for listing files.

## Installation

Install with a plugin manager such as:

[packer](https://github.com/wbthomason/packer.nvim)

```
use 'natecraddock/nvim-find'
```

[vim-plug](https://github.com/junegunn/vim-plug)

```
Plug 'natecraddock/nvim-find'
```

# Finders

Finders are not mapped by default. Each section below indicates which function to map to enable
quick access to the finder. The default command is also listed if available.

If a finder is **transient** then it can be closed immediately with <kbd>esc</kbd>. A **non-transient**
finder will return to normal mode when <kbd>esc</kbd> is pressed.

Finders open centered at the top of the terminal window. Any finder with a file preview draws centered
and is expanded to fill more of the available space.

## General

These mappings are always enabled when a finder is open

Key(s) | Mapping
-------|--------
<kbd>ctrl-j</kbd> or <kbd>ctrl-n</kbd> | select next result
<kbd>ctrl-k</kbd> or <kbd>ctrl-p</kbd> | select previous result
<kbd>ctrl-c</kbd>                      | close finder
<kbd>esc</kbd> or <kbd>ctrl-[</kbd>    | close finder if transient or enter normal mode

A **non-transient** finder has the following additional mappings in normal mode

Key(s) | Mapping
-------|--------
<kbd>j</kbd> or <kbd>n</kbd> | select next result
<kbd>k</kbd> or <kbd>p</kbd> | select previous result
<kbd>ctrl-c</kbd> or  <kbd>esc</kbd> or <kbd>ctrl-[</kbd> | close finder

## Files
**Transient**. Find files in the current working directory.

Because the [majority of file names are unique](https://nathancraddock.com/posts/in-search-of-a-better-finder/)
within a project, the file finder does not do fuzzy-matching. The query is separated into space-delimited tokens.
The first token is used to filter the file list by file name. The remaining tokens are used to further reduce the
list of results by matching against the full file paths.

Additionally, if no matches are found, then the first token will be matched against the full path rather than only
the filename.

Although this finder does not do fuzzy-matching, there is still some degree of sloppiness allowed. If the characters
`-_.` are not included in the query they will be ignored in the file paths. For example, the query
`outlinerdrawc` matches the file `outliner_draw.c`.

This algorithm is the main reason I created `nvim-find`.

Example mapping:
```
nnoremap <silent> <c-p> :lua require("nvim-find.defaults").files()<cr>
```

**Command:** `:NvimFindFiles`

Key | Mapping
----|--------
<kbd>enter</kbd>  | open selected file in last used buffer
<kbd>ctrl-v</kbd> | split vertically and open selected file
<kbd>ctrl-s</kbd> | split horizontally and open selected file
<kbd>ctrl-t</kbd> | open selected file in a new tab

## Buffers
**Transient**. List open buffers.

Lists open buffers. The alternate buffer is labeled with `(alt)`, and any buffers with unsaved changes
are prefixed with a circle icon.

Example mapping:
```
nnoremap <silent> <leader>b :lua require("nvim-find.defaults").buffers()<cr>
```

**Command:** `:NvimFindBuffers`

Key | Mapping
----|--------
<kbd>enter</kbd>  | open selected file in last used buffer
<kbd>ctrl-v</kbd> | split vertically and open selected file
<kbd>ctrl-s</kbd> | split horizontally and open selected file
<kbd>ctrl-t</kbd> | open selected file in a new tab

## Search (`ripgrep`)
**Non-transient**. Search files in the current working directory with ripgrep with a preview.

This finder shows a preview of the match in context of the file. After choosing a result the
lines are also sent to the quickfix list for later reference.

Example mapping:
```
nnoremap <silent> <leader>f :lua require("nvim-find.defaults").search()<cr>
```

**Command:** `:NvimFindSearch`

Key | Mapping
----|--------
<kbd>ctrl-q</kbd> (insert) or <kbd>q</kbd> (normal) | send results to the quickfix list and close
<kbd>enter</kbd>  | open selected match in last used buffer
<kbd>ctrl-v</kbd> | split vertically and open selected match
<kbd>ctrl-s</kbd> | split horizontally and open selected match
<kbd>ctrl-t</kbd> | open selected match in a new tab

# Contributing
If you find a bug, have an idea for a new feature, or even write some code you want included, please
create an issue or pull request! I would appreciate contributions. Note that plan to keep nvim-find
simple, focused, and opinionated, so not all features will be accepted.

## Acknowledgements

This is my first vim/neovim plugin, and first project in Lua. I have relied on
[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim),
[plenary.nvim](https://github.com/nvim-lua/plenary.nvim),
and [Snap](https://github.com/camspiers/snap) for help on how to interact with the neovim api, and for
inspiration on various parts of this plugin. Thanks to all the developers for helping me get started!

The async design of nvim-find is most heavily inspired by Snap.
