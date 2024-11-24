local week = wibox.widget({
    widget = wibox.widget.textclock,
    valign = "center",
    halign = "center",
    format = maker.text(colors.fg, " Regular 10", "%B, %Y"),
})

local day = wibox.widget({
    widget = wibox.widget.textclock,
    valign = "center",
    halign = "center",
    format = maker.text(colors.fg, " Regular 60", "%d"),
})

-- Função para criar widgets de texto com tamanho de fonte 7
local function createTextWidget(text, color)
    return wibox.widget({
        markup = color and ("<span color='" .. color .. "'>" .. text .. "</span>") or text,
        align = "center",
        valign = "center",
        font = " Bold 10",
        widget = wibox.widget.textbox,
    })
end

-- Função para criar um widget com fundo escuro e borda arredondada para o dia corrente
local function createTodayWidget(day)
    local text_widget = createTextWidget(day, colors.bg)
    -- Cria o widget
    local widget = wibox.widget({
        {
            --createTextWidget(day, colors.bg),
            text_widget,
            widget = wibox.container.place,
        },
        bg = colors.fg,             -- Cor de fundo inicial
        shape = gears.shape.circle, -- Borda com raio de 100%
        widget = wibox.container.background,
        forced_width = dpi(20),     -- Largura fixa para o círculo
        forced_height = dpi(20),    -- Altura fixa para o círculo
    })

    -- Conecta ao sinal para mudar a cor do fundo
    awesome.connect_signal("change::theme", function()
        widget.bg = colors.fg
        text_widget:set_markup(maker.text(colors.bg, "Regular 12", day))
    end)

    return widget
end

-- Atualiza o calendário
local function updateCalendar(date, monthView)
    monthView:reset()

    -- Tabela para armazenar os widgets
    local dayWidgets = {}

    -- Criação inicial dos widgets
    for _, w in ipairs({ "D", "S", "T", "Q", "Q", "S", "S" }) do
        local widget = createTextWidget(w, colors.fg)
        monthView:add(widget)
        table.insert(dayWidgets, widget) -- Armazena o widget na tabela
    end

    -- Atualiza os widgets existentes quando o tema mudar
    awesome.connect_signal("change::theme", function()
        for _, widget in ipairs(dayWidgets) do
            widget:set_markup(maker.text(colors.fg, " Regular 12", widget.text))
        end
    end)

    local firstDate = os.date("*t", os.time({ day = 1, month = date.month, year = date.year }))
    local lastDate = os.date("*t", os.time({ day = 0, month = date.month + 1, year = date.year }))
    local days_to_add_at_month_start = firstDate.wday - 1
    local col = firstDate.wday

    local actualDate = os.date("*t")

    -- Adiciona os dias do mês anterior
    local previous_month_last_day = os.date("*t", os.time({ year = date.year, month = date.month, day = 0 })).day
    for day = previous_month_last_day - days_to_add_at_month_start + 1, previous_month_last_day do
        monthView:add(createTextWidget(day, "gray"))
    end

    -- Adiciona os dias do mês atual
    for day = 1, lastDate.day do
        if date.day == day and date.month == actualDate.month and date.year == actualDate.year then
            monthView:add(createTodayWidget(day))
        else
            local color = (col == 1 or col == 7) and "gray" or nil
            monthView:add(createTextWidget(day, color))
        end
        col = col % 7 + 1
    end
end

-- Atualiza o texto do widget week
local function updateWeek(date)
    week.format = maker.text(colors.fg, " Regular 10", os.date("%B, %Y", os.time(date)))
end

-- Configura o calendário
local function up_calendar()
    local monthView = wibox.widget({
        --homogeneous = true,
        --expand = true,
        spacing              = 0, -- Define espaçamento zero entre as colunas
        minimum_column_width = 30,
        minimum_row_height   = 0,
        forced_num_cols      = 7,
        layout               = wibox.layout.grid,
    })

    local current_date = os.date("*t")

    gears.timer({
        timeout = 60,
        call_now = true,
        autostart = true,
        callback = function()
            updateCalendar(current_date, monthView)
            updateWeek(current_date)
        end,
    })

    widget = wibox.widget({
        widget = wibox.container.background,
        bg = colors.alt_bg,
        fg = colors.fg,
        forced_height = dpi(250),
        shape = maker.radius(6),
        border_width = dpi(1),
        border_color = colors.fg,
        {
            widget = wibox.container.place,
            halign = "center",
            valign = "center",

            {
                layout = wibox.layout.align.horizontal,
                expanded = "none",
                {
                    widget = wibox.container.place,
                    halign = "center",
                    valign = "center",
                    {
                        layout = wibox.layout.fixed.vertical,
                        maker.margins(week, 20, 10, 10, 0),
                        maker.margins(day, 20, 10, 0, 0)
                    },
                },
                nil,
                {
                    maker.margins(monthView, 20, 0, 20, 20),
                    widget = wibox.container.background,
                },
            },
        },
    })

    -- Função para mudar o mês
    local function change_month(step)
        current_date.month = current_date.month + step
        if current_date.month > 12 then
            current_date.month = 1
            current_date.year = current_date.year + 1
        elseif current_date.month < 1 then
            current_date.month = 12
            current_date.year = current_date.year - 1
        end
        updateCalendar(current_date, monthView)
        updateWeek(current_date)
    end

    -- Conecta os sinais de rolagem do mouse
    widget:connect_signal("button::press", function(_, _, _, button)
        if button == 4 then
            change_month(1)  -- Scroll up
        elseif button == 5 then
            change_month(-1) -- Scroll down
        end
    end)

    return widget
end

awesome.connect_signal("change::theme", function()
    widget:set_bg(colors.alt_bg)
    widget:set_fg(colors.fg)
    widget.border_color = colors.fg
    day.format = maker.text(colors.fg, " Regular 60", "%d")
    week.format = maker.text(colors.fg, " Regular 11", "%B, %Y")
end)

return up_calendar()
