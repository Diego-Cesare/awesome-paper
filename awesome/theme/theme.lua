local function load_colors()         -- Carregar as cores do tema
    local colors = {}                -- Criar um objeto para guardar as cores
    if settings.theme == "dark" then -- Se o tema for dark
        colors = {
            bg = "#000000",
            fg = "#F9F5F6",
            alt_bg = "#090909",
            black = "#fffffc",
            white = "#f6f6f4",
            red = "#FF9EAA",
            green = "#DCE4C9",
            yellow = "#FFE6A5",
            orange = "#FFBF61",
            blue = "#7EACB5",
            magenta = "#FFB4C2",
            purple = "#B2A4FF",
            cyan = "#AEE2FF",
            gray = "#c7c7c7",
            transparent = "#00000000",
        }
    elseif settings.theme == "light" then -- Se o tema for light
        colors = {
            bg = "#ffffff",
            fg = "#484f5d",
            alt_bg = "#f1f1f1",
            black = "#050810",
            white = "#212128",
            red = "#FF8A8A",
            green = "#658147",
            yellow = "#dfb25c",
            orange = "#FF7777",
            blue = "#667BC6",
            magenta = "#DA7297",
            purple = "#B2A4FF",
            cyan = "#8CABFF",
            gray = "#c7c7c7",
            transparent = "#ffffff00",
        }
    elseif settings.theme == "gruvbox" then -- Se o tema for gruvbox
        colors = {
            bg = "#282828",
            fg = "#eddbb2",
            alt_bg = "#1d2021",
            black = "#282828",
            white = "#fbf1c7",
            red = "#fb4934",
            green = "#b8bb26",
            yellow = "#fabd2f",
            orange = "#fe8019",
            blue = "#83a598",
            magenta = "#d3869b",
            purple = "#b16286",
            cyan = "#8ec07c",
            gray = "#928374",
            transparent = "#ffffff00",
        }
    elseif settings.theme == "rosepine" then -- Se o tema for rosepine
        colors = {
            bg = "#191724",
            fg = "#e0def4",
            alt_bg = "#403d52",
            black = "#26233a",
            white = "#e0def4",
            red = "#eb6f92",
            green = "#31748f",
            yellow = "#f6c177",
            orange = "#ce800f",
            blue = "#9ccfd8",
            magenta = "#c4a7e7",
            purple = "#b16286",
            cyan = "#ebbcba",
            gray = "#6e6a86",
            transparent = "#ffffff00",
        }
    end

    return colors
end

awesome.connect_signal("change::theme", function() -- Quando o tema mudar
    local colors = load_colors()                   -- Carregar as cores do tema
    awesome.emit_signal("theme::colors", colors)   -- Emitir a cor do tema
end)

return load_colors() -- Retornar as cores do tema
