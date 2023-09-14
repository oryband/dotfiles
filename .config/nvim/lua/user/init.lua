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
    { "goolord/alpha-nvim", opts = function(_, opts) opts.section.header.val = {} end },

    {
      "AstroNvim/astrocommunity",
      { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
      { "smartcolumn.nvim", opts = { scope = "line", custom_colorcolumn = { python = { 79 }, clojure = { 120 }, gitcommit = { 50, 72 } } } },
      { import = "astrocommunity.bars-and-lines.vim-illuminate" },
      { import = "astrocommunity.colorscheme.dracula-nvim" },
      { import = "astrocommunity.completion.copilot-lua" },
      { "copilot.lua", opts = { suggestion = { enabled = false }, panel = { enabled = false } } },
      { import = "astrocommunity.editing-support.treesj" },
      { "treesj", opts = { use_default_keymaps = false }, keys = { { "<leader>s", "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join" } } },
      { import = "astrocommunity.editing-support.nvim-devdocs" },
      { "nvim-devdocs", opts = { previewer_cmd = nil, picker_cmd = false, wrap = true, ensure_installed = { "python-3.10", "clojure-1.11", "docker", "bash", "markdown", "http" } } },
      { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
      { import = "astrocommunity.git.blame-nvim" },
      { import = "astrocommunity.git.diffview-nvim" },
      { import = "astrocommunity.pack.bash" },
      { import = "astrocommunity.pack.clojure" },
      { import = "astrocommunity.pack.docker" },
      { import = "astrocommunity.pack.helm" },
      { import = "astrocommunity.pack.json" },
      { import = "astrocommunity.pack.lua" },
      { import = "astrocommunity.pack.markdown" },
      { import = "astrocommunity.pack.python" },
      { import = "astrocommunity.pack.yaml" },
    },

    { "tpope/vim-surround", lazy = false },
    { "tpope/vim-repeat", lazy = false },
    { "bkad/CamelCaseMotion", lazy = false },
    { "guns/vim-sexp", ft = { "clojure" }, config = function() vim.api.nvim_set_var("sexp_enable_insert_mode_mappings", 0) end },
    { "gpanders/nvim-parinfer", enabled = false },

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

    { "nvim-treesitter/nvim-treesitter" },
    { "nvim-treesitter/playground", lazy = false, dependencies = { "nvim-treesitter/nvim-treesitter" } },
    { "williamboman/mason-lspconfig.nvim" },
    { "jay-babu/mason-null-ls.nvim" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "jay-babu/mason-nvim-dap.nvim" },

    {
      "zbirenbaum/copilot-cmp",
      event = "InsertEnter",
      dependencies = { "zbirenbaum/copilot.lua" },
      config = function() require("copilot_cmp").setup {} end,
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "zbirenbaum/copilot-cmp",
      },
      opts = function(_, opts)
        local cmp = require "cmp"
        opts.sources = cmp.config.sources {
          { name = "copilot", priority = 1000 },
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
