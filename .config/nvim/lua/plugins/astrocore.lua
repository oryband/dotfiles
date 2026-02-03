---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        title = true,
        titlestring = "%t", -- Just show the tail (filename) instead of full path
      },
      g = {
        python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python"),
        loaded_node_provider = 0, -- Disable Node provider (not needed; Mason LSPs use node from PATH via polish.lua)
        markdown_fenced_languages = { "python", "bash", "lua", "javascript", "typescript" },
        ["conjure#mapping#doc_word"] = "false",
        ["conjure#mapping#def_word"] = "false",
        ["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = "true",
      },
    },
    features = {
      autopairs = false,
    },
    diagnostics = {
      virtual_text = false,
      underline = false,
    },
    mappings = {
      n = {
        ["<Leader>s"] = { "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join" },
      },
    },
  },
}
