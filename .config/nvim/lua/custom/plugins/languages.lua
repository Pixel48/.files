return {
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
  { -- Kualala
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
    },
  },
   { -- PlatformIO supprt
     "anurag3301/nvim-platformio.lua",
     dependencies = {
       { "akinsho/nvim-toggleterm.lua" },
       { "nvim-telescope/telescope.nvim" },
       { "nvim-lua/plenary.nvim" },
     },
     cond = function()
       local platformioRootDir = (vim.fn.filereadable('platformio.ini') == 1) and vim.fn.getcwd() or nil
       if platformioRootDir then
         vim.g.platformioRootDir = platformioRootDir
       elseif (vim.uv or vim.loop).fs_stat(vim.fn.stdpath('data') .. '/lazy/nvim-platformio.lua') == nil then
         vim.g.platformioRootDir = vim.fn.getcwd()
       else
         vim.api.nvim_create_user_command('Pioinit', function()
           vim.api.nvim_create_autocmd('User', {
             pattern = { 'LazyRestore', 'LazyLoad' },
             once = true,
             callback = function(args)
               if args.match == 'LazyRestore' then
                 require('lazy').restore({ plugins = { 'nvim-platformio.lua' }, show = false })
               elseif args.match == 'LazyLoad' then
                 local pio_install_status = require('platformio.utils').pio_install_check()
                 if not pio_install_status then return end
                 vim.notify('PlatformIO loaded', vim.log.levels.INFO, { title = 'PlatformIO' })
                 require("platformio").setup(vim.g.pioConfig)
                 vim.cmd('Pioinit')
               end
             end,
           })
           vim.g.platformioRootDir = vim.fn.getcwd()
           require('lazy').load({ plugins = { 'nvim-platformio.lua' } })
         end, {})
       end
       return vim.g.platformioRootDir ~= nil
     end,
   },
}