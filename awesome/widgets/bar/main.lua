-- Carregar os modulos a serem usando na barra
local dock = require("widgets.bar.modules.dock")
local tools = require("widgets.bar.modules.tools")
local dynamic = require("widgets.bar.dynamic.dynamic")
local tray = require("widgets.bar.modules.tray")
local task = require("widgets.bar.modules.task")
local carrosel = require("widgets.bar.carrosel.carrosel")
local tag = require("widgets.bar.modules.tags")
local taglist = tag(awful.screen.focused())
local tasklist = task(awful.screen.focused())

-- Cria um separador fixo
-- Consulte ~/.config/awesome/utils/maker.lua
local sep = maker.margins(maker.separtor(vertical, 0.5, 0, 1, colors.fg), 10, 10, 5, 5)

-- Altura do widgets da barra
local box_height = settings.bar_height * 0.18

-- Widgets da esquerda
local left_itens = { tools, sep, taglist, sep, tasklist }
-- Widgets do centro
local center_itens = { nil }
-- Widgets da direita
local right_itens = { carrosel, sep, dynamic, sep, maker.margins(tray, 10, 5, 0, 0) }

-- Barra principal
local main = awful.wibar({
    stretch = false,
    position = settings.bar_position,
    height = settings.bar_height,
    width = settings.bar_width,
    type = "dock",
    bg = colors.bg,
    shape = maker.radius(settings.bar_radius - 2),
    opacity = 1,
    ontop = true,
    visible = true,
    -- Widgets
    widget = {
        widget = wibox.container.background,
        bg = colors.bg,
        border_width = dpi(1),
        border_color = colors.fg,
        shape = maker.radius(settings.bar_radius),
        {

            layout = wibox.layout.align.horizontal,
            expand = "none",
            -- Disposição dos widgets na barra.
            -- Cria um layout horizontal para comportar os widgets.
            -- Consulte ~/.config/awesome/utils/maker.lua
            { widget = maker.horizontal_padding_box(5, 0, box_height, box_height, left_itens) },
            { widget = maker.horizontal_padding_box(0, 0, box_height, box_height, center_itens) },
            { widget = maker.horizontal_padding_box(0, 5, box_height, box_height, right_itens) },
        },
    },
})

-- Calcular a posição da barra
local main_geometry = main:geometry()
local main_y_position = main_geometry.y
local screen_geometry = awful.screen.focused().geometry

local position_y = ""

-- Se a posição for top
if settings.bar_position == "top" then
    position_y = main_y_position + 10
    -- Se for bottom
elseif settings.bar_position == "bottom" then
    position_y = main_y_position - 10
end

-- Se a barra for flutuante
if settings.bar_floating then
    main.y = position_y
else
    -- Se for fixa
    main.y = main_y_position
    main.width = screen_geometry.width
    main.widget.shape = maker.radius(0)
    main.shape = maker.radius(0)
end

-- Altera entre fixa e flutuante
local function is_floating()
    if settings.bar_floating then
        main.y = position_y
        main.width = screen_geometry.width
        main.widget.shape = maker.radius(0)
        main.shape = maker.radius(0)
        settings.bar_floating = false
    else
        main.width = settings.bar_width
        main.widget.shape = maker.radius(settings.bar_radius)
        main.shape = maker.radius(settings.bar_radius)
        settings.bar_floating = true
        main.y = position_y
    end
end

-- Conecta o sinal e chama a função que define as condições da barra
awesome.connect_signal("float::bar", function()
    is_floating()
end)

local switch_float = function()
    local settings_path = os.getenv("HOME") .. "/.config/awesome/settings.lua"
    local file = io.open(settings_path, "r")
    local content = file:read("*all")
    file:close()

    if content:match('settings.bar_floating%s*=%s*true') then
        content = content:gsub('settings.bar_floating%s*=%s*true',
            'settings.bar_floating = false')
    elseif content:match('settings.bar_floating%s*=%s*false') then
        content = content:gsub('settings.bar_floating%s*=%s*false',
            'settings.bar_floating = true')
    end

    file = io.open(settings_path, "w")
    file:write(content)
    file:close()
end

client.connect_signal("property::maximized", function(c)
    if settings.bar_floating then
        is_floating()
        switch_float()
    elseif not settings.bar_floating then
        is_floating()
        switch_float()
    end
end)

-- Esconde a barra em modo tela cheia
local function update_ontop(c)
    main.visible = not c.fullscreen
end

client.connect_signal("property::fullscreen", update_ontop)

-- Troca as cores da barra ao clicar no botão de tema
awesome.connect_signal("change::theme", function(c)
    main:set_bg(colors.transparent)
    main.widget:set_bg(colors.bg)
    main.widget.border_color = colors.fg
end)
