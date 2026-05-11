-- 1. Descarga lazy.nvim automáticamente si no existe en tu equipo
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 2. Instalación de plugins
require("lazy").setup({
    
	{  ----- TEMA COLORSCHEME NEOSOLARIZADO --------
		"Tsuzat/NeoSolarized.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd([[ colorscheme NeoSolarized ]])
		end,
	},
	{ ------ BUSQUEDA DE ARCHIVOS Y TEXTO -----------
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local fzf = require("fzf-lua")

			-- Configuración opcional para ajustar el tamaño de la ventana
			fzf.setup({
				winopts = {
					height = 0.85,
					width = 0.80,
				},
			})
			vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Buscar archivos" })
			vim.keymap.set("n", "<C-f>", fzf.live_grep, { desc = "Buscar texto" })
			vim.keymap.set("n", "<C-A-p>", fzf.commands, { desc = "Paleta de comandos" })
		end,
	},
	{ ----- BARRA ESTADO INFERIOR -----------
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto", -- Toma automáticamente los colores de tu colorscheme
					globalstatus = true, -- Usa una sola barra si divides la pantalla en varios archivos
				},
			})
		end,
	},
	{ ----- ASIGNADOR DE FORMATEADORES DE CODIGO ------
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				-- Define qué formateador usar según el lenguaje
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					html = { "prettier" },
					python = { "black" }, -- o "autopep8"
					sql = { "sqlfluff" },
					lua = { "stylua" },
				},
			})

			-- Crear el atajo de teclado Shift + Alt + F (<A-S-f>)
			vim.keymap.set({ "n", "v" }, "<A-S-f>", function()
				require("conform").format({ lsp_fallback = true })
			end, { desc = "Formatear archivo" })
		end,
	},
	{ ------ INSTALADOR DE SERVIDORES LENGUAJE Y FORMATERS
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
})

-- 3. Configuraciones generales Nvim

vim.opt.number = true -- Muestra el número de la línea actual en la que estás
vim.opt.relativenumber = true -- Muestra la distancia (saltos) hacia las otras líneas
vim.opt.tabstop = 3 -- Tamaño visual del tabulador
