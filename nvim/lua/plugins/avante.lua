-- In ~/.config/nvim/lua/plugins/avante.lua
return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "markdown", "norg", "rmd", "org", "Avante" },
		},
		opts = {
			provider = "openai",
			auto_suggestions_provider = "openai",
			openai = {
				api_base_url = "http://192.168.15.128:1234/v1",
				endpoint = "http://192.168.15.128:1234/v1",
				-- model = "deepseek-r1-distill-llama-8b",
				-- model = "qwen2.5-7b-instruct-1m",
				-- model = "qwen2.5-coder-14b-intruct",
				model = "deepseek-coder-v2-lite-instruct",
				api_key = "OPENAI_API_KEY",
				temperature = 0.7,
				max_tokens = 2048,
				headers = {}, -- headers vazios para evitar validações desnecessárias
				["local"] = true,
			},
			behaviour = {
				auto_suggestions = true,
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
			},
			windows = {
				position = "right",
				wrap = true,
				width = 30,
				sidebar_header = {
					enabled = true,
					align = "center",
					rounded = true,
				},
			},
		},
	},
}
