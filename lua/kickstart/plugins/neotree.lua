return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- optional, for icons
      'MunifTanjim/nui.nvim',
    },
    init = function()
      -- disable netrw (the built-in file explorer) so it doesn’t fight Neo-tree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require('neo-tree').setup {
        close_if_last_window = true,
        popup_border_style = 'rounded',
        filesystem = {
          follow_current_file = true,
          hijack_netrw_behavior = 'open_default', -- open neo-tree when using :edit dir
        },
      }

      -- toggle with <leader>e (same vibe as Kickstart)
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Neo-tree: toggle' })

      -- auto-open Neo-tree if you start nvim with a directory
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          -- if the argument is a directory, open Neo-tree
          if vim.fn.argc() == 1 then
            local arg = vim.fn.argv(0)
            if vim.fn.isdirectory(arg) == 1 then
              vim.cmd 'Neotree filesystem reveal left'
              return
            end
          end

          -- or, if you just want it to open always on start, uncomment:
          -- vim.cmd("Neotree filesystem reveal left")
        end,
      })
    end,
  },
}
