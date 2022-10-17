vim.keymap.set('n', '<Leader>th',  function () require("nvterm.terminal").toggle "horizontal" end )
vim.keymap.set('n', '<Leader>tv',  function () require("nvterm.terminal").toggle "vertical" end )
vim.keymap.set('n', '<Leader>tf',  function () require("nvterm.terminal").toggle "float" end )
require("nvim-tree").setup({
disable_netrw = true,
hijack_netrw = true,
})

--require("nvim-tree").setup()
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
  "NvChad/nvterm",
  config = function ()
    require("nvterm").setup()
  end,
}
vim.opt.termguicolors = true
use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
require("bufferline").setup{
	options = {
		diagnostics = {
			enable = false,
		},
    diagnostics_indicator = function ()
      return ' '
    end,
    git = {
	    enable = true
    },
    log = {
  enable = true,
  truncate = true,
  types = {
    git = true,
    profile = true,
  },
},
    offsets = {
      {
         filetype = 'NvimTree',
	-- filetype = 'chadtree'

      }
    },
  }
}
end
)




