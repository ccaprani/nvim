return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "ranjithshegde/ccls.nvim",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      -- Diagnostic keymaps
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<space>i", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<space>e", vim.diagnostic.setloclist, opts)

      -- LSP on_attach keybindings (applied globally via vim.lsp.config '*')
      vim.lsp.config("*", {
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<space>F", function() vim.lsp.buf.format({ async = true }) end, bufopts)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
        end,
      })

      -- Enable pyright and texlab
      vim.lsp.config("pyright", {
        flags = { debounce_text_changes = 150 },
      })
      vim.lsp.config("texlab", {
        flags = { debounce_text_changes = 150 },
      })
      vim.lsp.enable({ "pyright", "texlab" })

      -- CCLS (C/C++) — still uses its own plugin setup
      require("ccls").setup({
        lsp = {
          server = {
            name = "ccls",
            cmd = { "ccls" },
            args = {},
            offset_encoding = "utf-32",
            root_dir = vim.fs.dirname(
              vim.fs.find({ "compile_commands.json", ".git" }, { upward = true })[1]
            ),
            init_options = {
              index = { threads = 0 },
              clang = { excludeArgs = { "-frounding-math" } },
            },
          },
        },
        filetypes = { "c", "cpp" },
      })

      -- LSP signature help
      require("lsp_signature").setup()
    end,
  },
}
