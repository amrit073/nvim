vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- empty setup using defaults
return require('packer').startup(function(use)
  -- Packer can manage itself
use 'wbthomason/packer.nvim'
require("nvim-tree").setup()
	vim.opt.termguicolors = true
	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
 	use 'neovim/nvim-lspconfig'
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
		--	filetype = 'ChadTree'

			}
    		},
  		}
	}
end)




