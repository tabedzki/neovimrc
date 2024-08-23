
    local M = {
    	"hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        -- use {'quangnguyen30192/cmp-nvim-ultisnips'}
            -- event = "Lazy",
    	dependencies = {
    		"hrsh7th/cmp-nvim-lsp",
    		"hrsh7th/cmp-nvim-lua",
    		"hrsh7th/cmp-buffer",
    		"hrsh7th/cmp-path",
            "quangnguyen30192/cmp-nvim-ultisnips",
    		"hrsh7th/cmp-cmdline",
    		"saadparwaiz1/cmp_luasnip",
    		"L3MON4D3/LuaSnip",
    		"sirver/ultisnips",
            "quangnguyen30192/cmp-nvim-ultisnips",
    	},
    }

    M.config = function()
    	local cmp = require("cmp")
        cmp.setup({
            mapping = {
                ['<C-Space>'] = cmp.mapping.complete(),
            },

            -- You should specify your *installed* sources.
            sources = {
                { name = 'buffer' },
                { name = 'nvim_lsp' },
                { name = 'ultisnips' },
            },
        })
    	vim.opt.completeopt = { "menu", "menuone", "noselect" }

    	local kind_icons = {
    		-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
    		Text = " ",
    		Method = "󰆧",
    		Function = "ƒ ",
    		Constructor = " ",
    		Field = "󰜢 ",
    		Variable = " ",
    		Constant = " ",
    		Class = " ",
    		Interface = "󰜰 ",
    		Struct = " ",
    		Enum = "了 ",
    		EnumMember = " ",
    		Module = "",
    		Property = " ",
    		Unit = " ",
    		Value = "󰎠 ",
    		Keyword = "󰌆 ",
    		Snippet = " ",
    		File = " ",
    		Folder = " ",
    		Color = " ",
    	}

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
    	cmp.setup({
    		snippet = {
    			expand = function(args)
    				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    			end,
    		},
    		window = {
    			-- completion = cmp.config.window.bordered(),
    			-- documentation = cmp.config.window.bordered(),
    		},
            -- event = {
            --     on_confirm_done = function()
            --         vim.schedule(function()
            --             cmp.complete()
            --         end)
            --     end,
            -- },
    		mapping = cmp.mapping.preset.insert({
    			["<C-b>"] = cmp.mapping.scroll_docs(-4),
    			["<C-f>"] = cmp.mapping.scroll_docs(4),
    			["<C-Space>"] = cmp.mapping.complete(),
    			-- ["<C-e>"] = cmp.mapping.abort(),

                -- ["<CR>"] = {
                --     c = function()
                --         cmp.mapping.confirm({select = true})
                --     end
                -- },

                -- ['<CR>'] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.confirm({ select = true })
                --         cmp.event:on('confirm_done', function()
                --             cmp.complete()
                --         end)
                --         return
                --     end
                --     fallback()
                -- end, { 'i', 'c' }),


                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            fallback()
                        else
                            cmp.confirm({ select = true })
                            -- cmp.complete()
                            -- If the selected entry is a directory path, trigger the completion again
                            -- if entry.completion_item.kind == cmp.lsp.CompletionItemKind.Folder then
                                -- You can adjust the trigger characters as needed
                                -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-f>', true, true, true), 'n', true)
                            -- end
                            vim.defer_fn(function()
                                cmp.complete()
                            end, 10) -- Delay i
                        end
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
               --  ['<C-y>'] = {
               --     c = function()
               --         cmp.mapping.confirm({select = true})
               --         cmp.mapping.complete()
               --     end
               -- },
                ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
                ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
    		}),
    		sources = cmp.config.sources({
    			{ name = "nvim_lsp" },
    			{ name = "nvim_lua" },
    			{ name = "luasnip" }, -- For luasnip users.
    		}, {
    			{ name = "buffer" },
    			{ name = "path" },
    		}, {
    			{ name = "neorg" },
    		}),

    		formatting = {
    			format = function(entry, vim_item)
    				-- Kind icons
    				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
    				-- Source
    				vim_item.menu = ({
    					buffer = "[Buffer]",
    					nvim_lsp = "[LSP]",
    					luasnip = "[LuaSnip]",
    					nvim_lua = "[NvimAPI]",
    					path = "[Path]",
    				})[entry.source.name]
    				return vim_item
    			end,
    		},
    	})

    	cmp.setup.cmdline(":", {
    		mapping = cmp.mapping.preset.cmdline(),
    		sources = cmp.config.sources({
    			{ name = "path" },
    		}, {
    			{ name = "cmdline" },
    		}),
    	})
    end

    return M
