return {
   enabled = false,
   "folke/todo-comments.nvim",
   dependencies = { "nvim-lua/plenary.nvim" },

   event = 'VeryLazy',

   opts = {
      signs = false,
   },

   config = true,
}
