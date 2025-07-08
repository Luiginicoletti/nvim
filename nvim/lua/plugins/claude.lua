return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },

    -- Custom key mappings managed here (internal plugin mappings are disabled below)
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<CR>",          desc = "Toggle Claude Code",        mode = { "n" } },
      { "<C-,>",     "<cmd>ClaudeCode<CR>",          desc = "Toggle Claude Code",        mode = { "n", "t" } },
      { "<leader>cC", "<cmd>ClaudeCodeContinue<CR>",  desc = "Claude Code – Continue",   mode = { "n" } },
      { "<leader>cV", "<cmd>ClaudeCodeVerbose<CR>",   desc = "Claude Code – Verbose",    mode = { "n" } },
    },

    -- Full set of options with defaults so you can tweak them freely
    opts = {
      -----------------------------------------------------------------------------
      -- Terminal window settings
      -----------------------------------------------------------------------------
      window = {
        split_ratio = 0.3,      -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
        position     = "botright", -- "botright", "topleft", "vertical", "float", etc.
        enter_insert = true,     -- Enter insert mode automatically when opening Claude Code
        hide_numbers = true,     -- Hide line numbers in the Claude Code terminal
        hide_signcolumn = true,  -- Hide the sign column in the terminal window

        -- Floating window configuration (only applies when position = "float")
        float = {
          width    = "80%",   -- Width: absolute columns or percentage string
          height   = "80%",   -- Height: absolute rows or percentage string
          row      = "center", -- Row position: number, "center", or percentage string
          col      = "center", -- Column position: number, "center", or percentage string
          relative = "editor", -- "editor" or "cursor"
          border   = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
        },
      },

      -----------------------------------------------------------------------------
      -- File refresh settings
      -----------------------------------------------------------------------------
      refresh = {
        enable            = true,   -- Enable file change detection
        updatetime        = 100,    -- `updatetime` while Claude Code is active (ms)
        timer_interval    = 1000,   -- How often to poll for file changes (ms)
        show_notifications = true,  -- Notify when buffers are auto-reloaded
      },

      -----------------------------------------------------------------------------
      -- Git project settings
      -----------------------------------------------------------------------------
      git = {
        use_git_root = true, -- Set CWD to git root when opening Claude Code (if in git project)
      },

      -----------------------------------------------------------------------------
      -- Shell-specific settings
      -----------------------------------------------------------------------------
      shell = {
        separator  = "&&",   -- Command separator used in shell commands
        pushd_cmd  = "pushd", -- Push directory onto stack (e.g. "pushd" for bash/zsh)
        popd_cmd   = "popd",  -- Pop directory from stack (e.g. "popd" for bash/zsh)
      },

      -----------------------------------------------------------------------------
      -- Command used to launch Claude Code and its variants
      -----------------------------------------------------------------------------
      command = "claude",
      command_variants = {
        -- Conversation management
        continue = "--continue", -- Resume the most recent conversation
        resume   = "--resume",   -- Display interactive conversation picker

        -- Output options
        verbose  = "--verbose",  -- Enable verbose logging with full turn-by-turn output
      },

      -----------------------------------------------------------------------------
      -- Internal plugin keymaps (disabled – we manage mappings above)
      -----------------------------------------------------------------------------
      keymaps = {
        toggle = {
          normal   = false, -- Disable default normal-mode toggle mapping
          terminal = false, -- Disable default terminal-mode toggle mapping
          variants = {
            continue = false, -- Disable default "continue" variant mapping
            verbose  = false, -- Disable default "verbose"  variant mapping
          },
        },
        window_navigation = true,  -- <C-h/j/k/l> between windows
        scrolling         = true,  -- <C-f>/<C-b> page-wise scrolling
      },
    },
  },
} 