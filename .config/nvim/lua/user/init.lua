local config = {
    colorscheme = "dracula",
    header = {},
    options = {
        opt = {
            termguicolors = true,
        },
        g = {
            maplocalleader = ",",
        },
    },
    diagnostics = {
        virtual_text = false,
        underline = false,
    },
    plugins = {
        init = {
            { "windwp/nvim-autopairs", disable = true },

            { "dracula/vim",           as = "dracula" },

            { "tpope/vim-surround" },
            { "tpope/vim-repeat" },

            { "guns/vim-sexp",         opt = true,    ft = { "clojure" } },
            { "Olical/conjure",        opt = true,    ft = { "clojure" } },
        },
        treesitter = {
            ensure_installed = {
                "clojure",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
            },
        },
        ["mason-lspconfig"] = {
            ensure_installed = {
                "clojure_lsp",
                "sumneko_lua", -- old name for lua_language_server
                "pyright",
            },
        },
        ["mason-null-ls"] = {
            ensure_installed = {
                "black",
                "joker",
                "jq",
                "stylua",
            },
        },
        ["guns/vim-sexp"] = {
            vim.api.nvim_set_var("sexp_enable_insert_mode_mappings", 0),
        },
    },
    polish = function()
        -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
        vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
            group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
            callback = function()
                vim.opt.foldmethod = "expr"
                vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            end,
        })
    end,
}

return config
