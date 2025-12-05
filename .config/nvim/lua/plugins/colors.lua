return {
    "AlphaTechnolog/pywal.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Set up pywal and load the colors
        require("pywal").setup()

	vim.api.nvim_set_hl(0, "CursorLine", {
	    bg = "#3c3f41",  -- JetBrains Darcula style background for cursor line
	})
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFCC66", bold = true })
	local fg_colors = {
            Normal       = "#A9B7C6", -- texto normal
            Comment      = "#808080", -- comentarios
            Keyword      = "#CC7832", -- palabras clave
            Identifier   = "#A9B7C6", -- nombres de variables
            Function     = "#FFC66D", -- funciones
            Statement    = "#CC7832", -- declaraciones
            Type         = "#A9B7C6", -- tipos
            Constant     = "#6897BB", -- constantes
            String       = "#6A8759", -- cadenas
            Number       = "#6897BB", -- números
            Operator     = "#A9B7C6", -- operadores
        }

        for group, color in pairs(fg_colors) do
            vim.api.nvim_set_hl(0, group, { fg = color })
        end
    end,
}

