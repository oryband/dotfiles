return {
  colorscheme = "dracula",
  options = {
    opt = {
      termguicolors = true,
    },
    g = {
      maplocalleader = ",",
      autopairs_enabled = false,
      codelens_enabled = false,
    },
  },
  diagnostics = {
    virtual_text = false,
    underline = false,
  },
  lsp = {
    formatting = {
      format_on_save = {
        enabled = false,
      },
    },
  },
  lazy = {
    -- zipPlugin is enabled (not disabled below) since Clojure go-to-definition goes into zipped jar files.
    -- also forces lazyness to be disabled.
    performance = {
      rtp = {
        disabled_plugins = { "tohtml", "gzip", "matchit", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  plugins = {
    {
      "Mofiqul/dracula.nvim",
      opts = function(_, opts)
        opts.overrides = {
          Special = { fg = "green", italic = false },
        }
      end,
    },

    { "goolord/alpha-nvim", opts = function(_, opts) opts.section.header.val = {} end },

    { "tpope/vim-surround", lazy = false },
    { "tpope/vim-repeat", lazy = false },
    { "bkad/CamelCaseMotion", lazy = false },
    { "guns/vim-sexp", ft = { "clojure" }, config = function() vim.api.nvim_set_var("sexp_enable_insert_mode_mappings", 0) end, },

    {
      "Olical/conjure",
      ft = { "clojure", "python" },
      config = function()
        vim.api.nvim_set_var("conjure#mapping#doc_word", "k")
        vim.api.nvim_set_var("conjure#client#clojure#nrepl#connection#auto_repl#hidden", true)
        vim.api.nvim_set_var("conjure#client#clojure#nrepl#connection#auto_repl#enabled", false)
        vim.api.nvim_set_var("conjure#client#clojure#nrepl#eval#auto_require", false)
        -- vim.api.nvim_set_var("conjure#debug", true)
        -- vim.api.nvim_set_var("conjure#client_on_load", false)
      end,
    },

    {
      "jackMort/ChatGPT.nvim",
      event = "VeryLazy",
      config = function() require("chatgpt").setup() end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },

    {
      "zbirenbaum/copilot.lua",
      config = function() require("copilot").setup { suggestion = { enabled = false }, panel = { enabled = false } } end,
    },
    {
      "zbirenbaum/copilot-cmp",
      event = "InsertEnter",
      dependencies = { "zbirenbaum/copilot.lua" },
      config = function()
        require("copilot_cmp").setup { formatters = { insert_text = require("copilot_cmp.format").remove_existing } }
      end,
    },

    {
      "nvim-telescope/telescope.nvim",
      opts = function(_, opts)
        local actions = require "telescope.actions"

        opts.defaults.mappings.i["<C-n>"] = actions.move_selection_next
        opts.defaults.mappings.i["<C-p>"] = actions.move_selection_previous
        opts.defaults.mappings.i["<C-j>"] = actions.cycle_history_next
        opts.defaults.mappings.i["<C-k>"] = actions.cycle_history_prev
      end,
    },

    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      commit = "cc360a9",
      opts = {
        ensure_installed = {
          "clojure",
          "lua",
          "markdown",
          "python",
          "sql",
          "yaml",
        },
      },
    },
    { "nvim-treesitter/playground", lazy = false, dependencies = { "nvim-treesitter/nvim-treesitter" } },
    { "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "clojure_lsp", "lua_ls" } } },
    { "jay-babu/mason-null-ls.nvim", opts = { ensure_installed = { "black", "jq", "stylua", "zprint" } } },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "jay-babu/mason-nvim-dap.nvim", ensure_installed = { "python" } },

    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "zbirenbaum/copilot-cmp",
        "jcdickinson/codeium.nvim",
      },
      opts = function(_, opts)
        local cmp = require "cmp"
        opts.sources = cmp.config.sources {
          { name = "copilot", priority = 1000 },
          { name = "codeium", priority = 900 },
          { name = "nvim_lsp", priority = 800 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }
        return opts
      end,
    },

    {
      "onsails/lspkind.nvim",
      opts = {
        symbol_map = {
          Copilot = "",
          Codeium = "󱃖",
        },
      },
    },
  },
  polish = function()
    local opts = { silent = true }
    local map = vim.api.nvim_set_keymap

    map("", "w", "<Plug>CamelCaseMotion_w", opts)
    map("", "e", "<Plug>CamelCaseMotion_e", opts)
    map("", "b", "<Plug>CamelCaseMotion_b", opts)

    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { link = "CmpItemKindDefault" })
  end,
}
