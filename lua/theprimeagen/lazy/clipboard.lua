local nvim_version = vim.fn.has('nvim-0.10')
local packages = { }

if nvim_version >= 1 then
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
            ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
        },
    }
else
  table.insert(packages, {
    "ojroques/nvim-osc52",
    config = function()
      local function copy(lines, _)
        require('osc52').copy(table.concat(lines, '\n'))
      end

      local function paste()
        return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
      end

      vim.g.clipboard = {
        name = 'osc52',
        copy = {['+'] = copy, ['*'] = copy},
        paste = {['+'] = paste, ['*'] = paste},
      }

      -- Now the '+' register will copy to system clipboard using OSC52
      vim.keymap.set('n', '<leader>c', '"+y')
      vim.keymap.set('n', '<leader>cc', '"+yy')
    end,
  })
end

-- Return the packages table
return packages

-- return {
--   {
--     'ojroques/nvim-osc52',
--     config = function()
--       if vim.fn.has('nvim-0.10') == 0 then
--         require("nvim-osc52").setup()
--         vim.g.clipboard = {
--           name = 'OSC 52',
--           copy = {
--             ['+'] = require('nvim-osc52').copy('+'),
--             ['*'] = require('nvim-osc52').copy('*'),
--           },
--           paste = {
--             ['+'] = require('nvim-osc52').paste('+'),
--             ['*'] = require('nvim-osc52').paste('*'),
--           },
--         }
--       end
--     end
--   }
-- }
--
--

--
--
-- if vim.fn.has('nvim-0.10') == 1 then
--     vim.g.clipboard = {
--         name = 'OSC 52',
--         copy = {
--             ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--             ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--         },
--         paste = {
--             ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--             ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--         },
--     }
--     return {}
-- else
--     -- Use nvim-lazy to load the ojroques/nvim-osc52 package
--     return {
--
--         'ojroques/nvim-osc52',
-- 	event="VeryLazy",
--         config = function()
--             vim.g.clipboard = {
--                 name = 'OSC 52',
--                 copy = {
--                     ['+'] = require('nvim-osc52').copy('+'),
--                     ['*'] = require('nvim-osc52').copy('*'),
--                 },
--                 paste = {
--                     ['+'] = require('nvim-osc52').paste('+'),
--                     ['*'] = require('nvim-osc52').paste('*'),
--                 },
--             }
--         end
--     }
-- --  return {
-- --     "laytan/cloak.nvim",
-- --     config = function()
-- --         require("cloak").setup({
-- --             enabled = true,
-- --             cloak_character = "*",
-- --             -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
-- --             highlight_group = "Comment",
-- --             patterns = {
-- --                 {
-- --                     -- Match any file starting with ".env".
-- --                     -- This can be a table to match multiple file patterns.
-- --                     file_pattern = {
-- --                         ".env*",
-- --                         "wrangler.toml",
-- --                         ".dev.vars",
-- --                     },
-- --                     -- Match an equals sign and any character after it.
-- --                     -- This can also be a table of patterns to cloak,
-- --                     -- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
-- --                     cloak_pattern = "=.+"
-- --                 },
-- --             },
-- --         })
-- --     end
-- -- }
-- end
--
