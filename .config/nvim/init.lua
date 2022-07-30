local servers = {
	"tsserver",
	"bashls",
	"clangd",
	"emmet_ls",
	"cssls",
	"pylsp",
	"rust_analyzer",
	"sumneko_lua",
	"taplo",
}

local languages = {
	"tsx",
	"fish",
	"html",
	"css",
	"bash",
	"javascript",
	"markdown",
	"vim",
	"lua",
	"cpp",
	"rust",
	"toml",
	"python",
	"typescript",
	"c",
	"json",
}

local options = {
	undofile = false,
	termguicolors = true,
	wildmenu = true,
	scrolloff = 3,
	wrap = true,
	hlsearch = false,
	ignorecase = true,
	showmode = false,
	showcmd = true,
	smartindent = true,
	smartcase = true,
	cmdheight = 1,
	mouse = "a",
	shiftwidth = 2,
	tabstop = 2,
	cursorline = true,
	number = true,
	updatetime = 100,
	expandtab = false,
	clipboard = "unnamedplus",
	laststatus = 3,
	completeopt = { "menuone", "noselect" },
	swapfile = false,
}
for k, v in pairs(options) do
	vim.opt[k] = v
end
vim.opt.shm:append("I")
vim.api.nvim_create_autocmd("filetype", { command = "set formatoptions-=cro" })

pcall(vim.cmd, "colorscheme nord")
vim.api.nvim_set_hl(0, "Pmenu", {})

vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
vim.cmd([[highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline]])
vim.cmd([[highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline]])

vim.g.loaded_perl_provider = 0

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<right>", "", opts)
keymap("n", "<left>", "", opts)
keymap("n", "<up>", "", opts)
keymap("n", "<down>", "", opts)

keymap("v", "<right>", "", opts)
keymap("v", "<left>", "", opts)
keymap("v", "<up>", "", opts)
keymap("v", "<down>", "", opts)

keymap("n", "<space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "q", "", opts)

keymap("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', opts)
keymap("n", "<a-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', opts)

keymap("n", "<F1>", "<cmd>e ~/TODO<CR>", opts)

keymap("n", "<a-/>", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("v", "<a-/>", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)

keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)

keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)
keymap("x", "H", "^", opts)
keymap("x", "L", "$", opts)
keymap("o", "H", "^", opts)
keymap("o", "L", "$", opts)

keymap("n", "<C-j>", ":m .+1<CR>==", opts)
keymap("n", "<C-k>", ":m .-2<CR>==", opts)
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)
keymap("n", "<C-s>", "<cmd>w<CR>", opts)
keymap("i", "<C-s>", "<Escape><cmd>w<CR>", opts)
keymap("n", "<C-q>", "<cmd>q<CR>", opts)
keymap("n", "<C-t>", "<cmd>enew<CR>", opts)
keymap("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", opts)
keymap("n", "<leader>v", "<cmd>FZF<CR>", opts)

keymap("n", "<Tab>", "<cmd>bn<CR>", opts)
keymap("n", "<S-Tab>", "<cmd>bp<CR>", opts)
keymap("n", "<leader>d", "<cmd>bd<CR>", opts)
keymap("n", "<leader>D", "<cmd>bd!<CR>", opts)
keymap("n", "<leader>b", "<cmd>JABSOpen<CR>", opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.txt",
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd("resize")
		end
	end,
})

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim",
	})
	vim.notify("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("arcticicestudio/nord-vim")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("L3MON4D3/LuaSnip")
	use("williamboman/nvim-lsp-installer")
	use("norcalli/nvim-colorizer.lua")
	use("numToStr/Comment.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("unblevable/quick-scope")
	use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
	use("windwp/nvim-autopairs")
	use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })
	use("jose-elias-alvarez/null-ls.nvim")
	use("RRethy/vim-illuminate")
	use("matbme/JABS.nvim")
	use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use("j-hui/fidget.nvim")
	use("folke/lua-dev.nvim")
end)

-- PLUGIN START

require("lua-dev").setup()

require("fidget").setup({
	text = {
		done = "",
	},
	fmt = {
		task = function(task_name, message, percentage) end,
	},
})

local left_pad = {
	function()
		return " "
	end,
	padding = 0,
	color = { fg = "#4c566a" },
}

local right_pad = {
	function()
		return " "
	end,
	padding = 0,
	color = { fg = "#4c566a" },
}

local left_pad_alt = {
	function()
		return " "
	end,
	padding = 0,
	color = { fg = "#4c566a" },
}

local right_pad_alt = {
	function()
		return " "
	end,
	padding = 0,
	color = { fg = "#4c566a" },
}

local lualine_buffers = {
	function()
		local cur = 0
		local current_buf = vim.api.nvim_get_current_buf()

		for _, buf in pairs(vim.api.nvim_list_bufs()) do
			if vim.fn.buflisted(buf) == 1 then
				cur = cur + 1
			end
			if buf == current_buf then
				current_buf = cur
			end
		end

		return tostring(current_buf) .. "/" .. tostring(cur)
	end,
	color = { bg = "#4c566a" },
}

local theme = require("lualine.themes.nord")

-- theme.normal.a.fg = theme.normal.a.bg
-- theme.insert.a.fg = theme.insert.a.bg
-- theme.visual.a.fg = theme.visual.a.bg
theme.normal.a.fg = "#61afef"
theme.insert.a.fg = "#d19a66"
theme.visual.a.fg = "#c678dd"
theme.normal.a.bg = "#2e3440"
theme.insert.a.bg = "#2e3440"
theme.visual.a.bg = "#2e3440"

theme.normal.b.bg = "#2e3440"

theme.normal.c.bg = "#2e3440"

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { left_pad, { "mode", color = { bg = "#4c566a" }, padding = 0 }, right_pad },
		lualine_b = {
			{
				left_pad[1],
				padding = left_pad.padding,
				color = left_pad.color,
				cond = function()
					return #vim.diagnostic.get() ~= 0
				end,
			},
			{ "diagnostics", color = { bg = "#4c566a" }, padding = 0 },
			{
				right_pad[1],
				padding = right_pad.padding,
				color = right_pad.color,
				cond = function()
					return #vim.diagnostic.get() ~= 0
				end,
			},
		},
		lualine_c = {
			left_pad_alt,
			{
				"filename",
				symbols = {
					modified = " ●",
					readonly = " ",
					unnamed = "No Name",
				},
			},
			right_pad_alt,
		},
		lualine_x = {
			{
				left_pad_alt[1],
				padding = left_pad.padding,
				color = left_pad_alt.color,
				cond = function()
					return vim.bo.filetype ~= ""
				end,
			},
			"filetype",
			{
				right_pad_alt[1],
				padding = right_pad.padding,
				color = right_pad_alt.color,
				cond = function()
					return vim.bo.filetype ~= ""
				end,
			},
		},
		lualine_y = { left_pad, lualine_buffers, right_pad },
		lualine_z = { left_pad, { "location", color = { bg = "#4c566a" }, padding = 0 }, right_pad },
	},
	extensions = { "nvim-tree" },
})

require("jabs").setup({
	position = "center",
	border = "rounded",
	preview_position = "right",
	preview = {
		width = 40,
		border = "rounded",
	},
	highlight = {
		current = "Title",
		hidden = "StatusLineNC",
		split = "WarningMsg",
		alternate = "StatusLineNC",
	},
	keymap = {
		close = "d",
		jump = "<CR>",
		h_split = "h",
		v_split = "v",
		preview = "p",
	},
})

vim.g.Illuminate_ftblacklist = { "NvimTree", "packer", "JABSwindow" }

require("null-ls").setup({
	debug = false,
	sources = {
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.code_actions.shellcheck,
	},
})

require("todo-comments").setup({
	signs = true,
	keywords = {
		FIX = { icon = "" },
		TODO = { icon = "" },
		HACK = { icon = "" },
		WARN = { icon = "" },
		PERF = { icon = "" },
		NOTE = { icon = "" },
	},
})

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_unnamed_buffer_when_opening = true,
	hijack_netrw = true,
	hijack_cursor = true,
	update_cwd = true,
	open_on_setup = false,
	renderer = {
		icons = {
			webdev_colors = false,
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	filters = {
		dotfiles = true,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	git = {
		enable = false,
	},
	view = {
		width = 30,
		height = 30,
		side = "left",
		hide_root_folder = true,
		mappings = {
			custom_only = false,
			list = {},
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

require("colorizer").setup({
	"*",
	"!packer",
	"!NvimTree",
	"!JABSwindow",
	css = { css = true },
}, { names = true })

require("nvim-lsp-installer").setup({
	automatic_installation = true,
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})
keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

function Toggle_format_on_save()
	if FormatOnSave == nil then
		FormatOnSave = vim.api.nvim_create_autocmd("BufWritePre", {
			command = "lua vim.lsp.buf.formatting_sync()",
		})
		vim.notify("Enabled format on save")
	else
		vim.api.nvim_del_autocmd(FormatOnSave)
		FormatOnSave = nil
		vim.notify("Disabled format on save")
	end
end

Toggle_format_on_save()

vim.cmd([[command! LspToggleAutoFormat execute 'lua Toggle_format_on_save()']])

local on_attach = function(client, bufnr)
	local bufkeymap = vim.api.nvim_buf_set_keymap
	bufkeymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	bufkeymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	bufkeymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	bufkeymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- bufkeymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	bufkeymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	require("illuminate").on_attach(client)

	if client.name == "tsserver" or client.name == "sumneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end
end

local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, server in pairs(servers) do
	if server == "sumneko_lua" then
		lsp["sumneko_lua"].setup(require("lua-dev").setup({
			lspconfig = {
				capabilities = capabilities,
				on_attach = on_attach,
			},
		}))
	else
		lsp[server].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end
end

local signs = {
	{ name = "DiagnosticSignError", text = " " },
	{ name = "DiagnosticSignWarn", text = " " },
	{ name = "DiagnosticSignHint", text = " " },
	{ name = "DiagnosticSignInfo", text = " " },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	signs = {
		active = signs,
	},
	float = {
		focusable = false,
		border = "rounded",
		style = "minimal",
		header = "",
		prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-w>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	}),
	experimental = {
		ghost_text = true,
	},
	window = {
		documentation = {
			border = "rounded",
		},
		completion = {
			border = "rounded",
		},
	},
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
	window = {
		completion = {
			border = "none",
		},
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "path" },
	},
	window = {
		completion = {
			border = "none",
		},
	},
})

require("nvim-autopairs").setup()
cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	ensure_installed = languages,
})

require("Comment").setup({
	mappings = {
		basic = false,
		extra = false,
	},
	pre_hook = function(ctx)
		local U = require("Comment.utils")

		local location = nil
		if ctx.ctype == U.ctype.block then
			location = require("ts_context_commentstring.utils").get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = require("ts_context_commentstring.utils").get_visual_start_location()
		end

		return require("ts_context_commentstring.internal").calculate_commentstring({
			key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
			location = location,
		})
	end,
})
