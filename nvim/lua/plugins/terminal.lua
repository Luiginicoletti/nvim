return {
  -- Terminal plugin configuration with toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      -- General toggleterm settings
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]], -- Ctrl+\ to toggle the terminal
      hide_numbers = true, -- Hide terminal buffer line numbers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- The degree by which to darken the terminal color. Default: 1 for dark backgrounds, 3 for light.
      start_in_insert = true, -- Start terminal in insert mode
      insert_mappings = true, -- Apply mappings for insert mode
      persist_size = true,
      direction = "float", -- Options: 'vertical', 'horizontal', 'tab', 'float'
      close_on_exit = true, -- Close the terminal window when the process exits
      shell = vim.o.shell, -- Use the default shell
      -- Float configuration
      float_opts = {
        border = "curved", -- Options: 'single', 'double', 'shadow', 'curved'
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    keys = {
      -- Key mappings for terminal access
      -- Toggle specific terminal layouts
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (Float)" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal (Horizontal)" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal (Vertical)" },
      -- Quick toggle: <leader>tt toggles terminal with last configuration
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Terminal Toggle" },
      -- Open terminal in insert mode for common shells
      { "<leader>ts", "<cmd>TermSelect<cr>", desc = "Terminal Select" },
      -- Terminal navigation with custom terminal picker
      { "<leader>tk", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "Send Current Line" },
      { "<leader>tj", "<cmd>ToggleTermSendVisualSelection<cr>", mode = "v", desc = "Send Visual Selection" },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Custom function for managing numbered terminals
      -- Usage: <leader>t1, <leader>t2, etc. to toggle specific terminal instances
      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      end

      -- Auto-command to set terminal keymaps when a terminal buffer is entered
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      -- Numbered terminal management
      local Terminal = require("toggleterm.terminal").Terminal

      -- Create named lazygit terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "double",
        },
      })

      -- Function to toggle lazygit terminal
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      -- Key binding for lazygit
      vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Lazygit" })

      -- Create numbered terminals (1-5)
      for i = 1, 5 do
        local term = Terminal:new({
          count = i,
          direction = i <= 3 and "float" or "horizontal", -- First 3 are float, others horizontal
          hidden = true,
        })

        -- Create toggle function for this terminal
        _G["_TOGGLE_TERM_" .. i] = function()
          term:toggle()
        end

        -- Register keymap
        vim.api.nvim_set_keymap(
          "n",
          string.format("<leader>t%d", i),
          string.format("<cmd>lua _TOGGLE_TERM_%d()<CR>", i),
          { noremap = true, silent = true, desc = string.format("Terminal %d", i) }
        )
      end
    end,
  },

  -- Tmux integration for seamless navigation between Neovim splits and Tmux panes
  {
    "christoomey/vim-tmux-navigator",
    lazy = false, -- Load this plugin immediately (not lazy-loaded)
    config = function()
      -- Set up Tmux-Neovim navigation keybindings
      vim.g.tmux_navigator_no_mappings = 1 -- Disable default mappings to use our custom ones
      
      -- Define navigation mappings identical to the plugin defaults for consistency
      vim.api.nvim_set_keymap("n", "<C-h>", ":<C-U>TmuxNavigateLeft<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<C-j>", ":<C-U>TmuxNavigateDown<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<C-k>", ":<C-U>TmuxNavigateUp<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<C-l>", ":<C-U>TmuxNavigateRight<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<C-\\>", ":<C-U>TmuxNavigatePrevious<CR>", { noremap = true, silent = true })
      
      -- Additional configuration options
      vim.g.tmux_navigator_save_on_switch = 2 -- Automatically save current buffer when navigating
      vim.g.tmux_navigator_disable_when_zoomed = 1 -- Disable navigation when zoomed in tmux
      vim.g.tmux_navigator_preserve_zoom = 1 -- Preserve zoom state when navigating
    end,
  },
}

-- Usage Guide:
-- 
-- Terminal Management:
-- <leader>tt - Toggle last used terminal
-- <leader>tf - Toggle floating terminal
-- <leader>th - Toggle horizontal terminal
-- <leader>tv - Toggle vertical terminal
-- <leader>t1 - Toggle terminal 1 (float)
-- <leader>t2 - Toggle terminal 2 (float)
-- <leader>t3 - Toggle terminal 3 (float)
-- <leader>t4 - Toggle terminal 4 (horizontal)
-- <leader>t5 - Toggle terminal 5 (horizontal)
-- <leader>tg - Toggle lazygit in a floating terminal
-- <leader>ts - Select a terminal from a list
-- <leader>tk - Send current line to terminal
-- <leader>tj - Send visual selection to terminal (in visual mode)
-- 
-- Terminal Navigation:
-- <Esc>      - Exit terminal insert mode to normal mode
-- <C-h>      - Move to the left split/pane (works in both Neovim and Tmux)
-- <C-j>      - Move to the bottom split/pane (works in both Neovim and Tmux)
-- <C-k>      - Move to the top split/pane (works in both Neovim and Tmux)
-- <C-l>      - Move to the right split/pane (works in both Neovim and Tmux)
-- <C-\>      - Move to the previously focused split/pane (works in both Neovim and Tmux)

