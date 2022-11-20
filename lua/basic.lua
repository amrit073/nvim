vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- empty setup using defaults
return require('packer').startup(function(use)
  -- Packer can manage itself
use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}
	use 'wbthomason/packer.nvim'
	use 'mfussenegger/nvim-dap'
	local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}
	require("nvim-tree").setup()
	vim.opt.termguicolors = true
	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
 	use 'neovim/nvim-lspconfig'
	require("bufferline").setup{
		options = {
		diagnostics = "coc",
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




