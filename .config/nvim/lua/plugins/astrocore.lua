---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      g = {
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
