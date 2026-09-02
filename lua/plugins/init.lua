return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- NOTE: deliberately no "rust-analyzer" here. Mason's bin dir is prepended to
        -- nvim's PATH, so a Mason RA shadows the rustup proxy (~/.cargo/bin/rust-analyzer)
        -- and breaks proc-macro ABI matching against a pinned rust-toolchain.toml.
        -- For a minimal-profile pin: rustup component add rust-analyzer --toolchain <X>
        "stylua",
        "haskell-language-server",
        "marksman",
        "typescript-language-server",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(
        opts.ensure_installed,
        { "rust", "toml", "haskell", "ocaml", "ocaml_interface", "typescript", "tsx" }
      )
      opts.auto_install = true

      -- nvim-treesitter's frozen `master` branch doesn't support Neovim 0.12+;
      -- its markdown code-fence injection directive crashes the highlighter on
      -- Shift+K hovers. Drop markdown injections until NvChad moves to `main`.
      vim.treesitter.query.set("markdown", "injections", "")
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        -- filename first, dir path after — the filename is never truncated away
        path_display = { "filename_first" },
      },
    },
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {},
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    opts = {},
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPost",
    opts = {},
  },

  {
    -- right-edge scrollbar with git-hunk / diagnostic / search ticks (reads gitsigns data)
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewFileHistory",
      "DiffviewRefresh",
    },
    opts = {},
  },

  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "botright"
    end,
  },

  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {},
  },

  {
    "arnamak/stay-centered.nvim",
    config = function()
      require("stay-centered").setup()
    end,
    lazy = false,
  },
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {},
  },
}
