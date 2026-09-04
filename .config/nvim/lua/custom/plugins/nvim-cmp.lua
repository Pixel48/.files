return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"

      opts.mapping["<Up>"] = cmp.mapping.select_prev_item()
      opts.mapping["<Down>"] = cmp.mapping.select_next_item()

      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })

      return opts
    end,
  },
}