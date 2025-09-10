return {
  { -- mason-tool-installer
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = require("custom").tools,
      automatic_installation = true,
      auto_update = true,
      run_on_start = true,
      debounce_hours = 48,
    },
  },
  { -- mason-lspconfig
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    lazy = false,
    opts = {
      ensure_installed = require("custom").lsps,
      automatic_installation = true,
    },
  },
  { -- lspconfig
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    config = function()
      -- require "configs.lspconfig"
      require("nvchad.configs.lspconfig").defaults()

      local lspconfig = require "lspconfig"

      local servers = require("custom").lsps
      local nvlsp = require "nvchad.configs.lspconfig"
      local on_attach = nvlsp.on_attach
      local on_init = nvlsp.on_init
      local capabilities = nvlsp.capabilities

      -- lsps with default config
      for _, lsp in ipairs(servers) do
        if lspconfig[lsp] then
          lspconfig[lsp].setup {
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
          }
        else
          vim.notify(lsp .. "not available in lspconfig", vim.log.level.WARN)
        end
      end

      lspconfig.terraformls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "terraform", "terraform-vars", "tf" },
      }
    end,
  },
  { -- ansible.nvim
    "mfussenegger/nvim-ansible",
    ft = { "yaml", "yml" },
    keys = {
      {
        "<leader>ta",
        function()
          require("ansible").run()
        end,
        desc = "Run Ansible Playbook/Role",
        silent = true,
      },
    },
  },
  { -- conform
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- css = { "prettier" }, html = { "prettier" },
      },
      format_on_save = { -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  { -- rust
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  { -- Kualala
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
    },
  },
  { -- PlatformIO supprt
    "anurag3301/nvim-platformio.lua",
    name = "PlatformIO",
    dependencies = {
      { "akinsho/nvim-toggleterm.lua" },
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    ft = "cpp",
  },
  { -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "terraform",
        "hcl",
        "bash",
        "yaml",
        "c",
        "cpp",
        "glsl",
        "haskell",
      },
    },
  },
  { -- YAML
    "cuducos/yaml.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "folke/snacks.nvim",
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
  },
  { -- UFO
    "kevinhwang91/nvim-ufo",
    name = "ufo",
    dependencies = {
      { "kevinhwang91/promise-async" },
    },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
      mappings = {
        scrollU = "<C-u>",
        scrollD = "<C-d>",
        jumpTop = "[",
        jumpBot = "]",
      },
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },
  },
  { -- Flash
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = false,
        },
        char = {
          jump_labels = true,
        },
      },
    },
    keys = {
      {
        "<C-;>",
        mode = { "n", "x" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<S-C-;>",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "<C-;>",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "<S-C-;>",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<C-space>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  { -- coc
    "neoclide/coc.nvim",
    branch = "master",
    enabled = false,
  },
  { -- coc-ansible
    "yaegassy/coc-ansible",
    enabled = false,
  },
  { -- Makrdown
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    ft = { "markdown", "vimwiki" },
    opts = {
      enabled = true,
    },
  },
  { -- diffview
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>dg", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
  },
}
