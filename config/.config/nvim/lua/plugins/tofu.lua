return {
  -- conform config to use tofu_fmt
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      hcl = { "packer_fmt" },
      terraform = { "tofu_fmt" },
      tf = { "tofu_fmt" },
      ["terraform-vars"] = { "tofu_fmt" },
    },
  },
  -- treesitter config ?
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "terraform", "hcl" } },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "tofu-ls", "tflint" } },
  },
  -- tofu_ls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tofu_ls = {},
      },
    },
  },
}
