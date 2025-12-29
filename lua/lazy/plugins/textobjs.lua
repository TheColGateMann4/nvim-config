return {
  {
    "kana/vim-textobj-user",
    lazy = false,
    config = function()
      vim.cmd("source " .. vim.fn.stdpath("config") .. "\\lua\\depends\\textobjs.vim")
    end,
  },
}
