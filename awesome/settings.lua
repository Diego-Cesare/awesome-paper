_G.settings = {}                   -- Configurações
-- THEME
settings.theme = "light"            -- dark or light
-- TITLEBAR
settings.titlebar = true
settings.title_position = "top"    -- top or bottom
settings.title_size = dpi(55)      -- Tamanho do título
-- WINDOWS
settings.gaps = dpi(10)            -- Gaps
-- BAR
settings.bar_height = dpi(55)      -- Altura da barra
settings.bar_width = dpi(1900)     -- Largura da barra
settings.bar_floating = true       -- Barra flutuante
settings.bar_radius = dpi(10)      -- Raio da barra
settings.bar_position = "bottom"   -- top or bottom
-- FONT
settings.font = "Ubuntu Nerd Font" -- Fonte
-- USER
settings.name = "DiegoCesare"      -- Nome do usuário
settings.wm_name = "AwesomeWM"     -- Nome do WM
settings.host = "Arch linux"       -- Nome do host

return settings                    -- Retornar as configurações
