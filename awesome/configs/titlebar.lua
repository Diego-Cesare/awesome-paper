client.connect_signal("request::titlebars", function(c)
    local icon_size = settings.title_size * 0.45

    local close_button = wibox.widget({
        widget = wibox.widget.imagebox,
        image = icons.close_icon,
        valign = "center",
        halign = "center",
        resize = true,
        forced_width = dpi(icon_size),
        buttons = awful.button({}, 1, function() c:kill() end)
    })

    local maximize_button = wibox.widget({
        widget = wibox.widget.imagebox,
        image = icons.maximize,
        valign = "center",
        halign = "center",
        resize = true,
        forced_width = dpi(icon_size),
        buttons = awful.button({}, 1,
                               function() c.maximized = not c.maximized end)
    })

    local minimize_button = wibox.widget({
        widget = wibox.widget.imagebox,
        image = icons.minimize,
        valign = "center",
        halign = "center",
        resize = true,
        forced_width = dpi(icon_size),
        buttons = gears.table.join(awful.button({}, 1, function()
            gears.timer.delayed_call(function() c.minimized = true end)
        end))
    })

    local buttons = {
        awful.button({}, 1, function()
            c:activate{context = "titlebar", action = "mouse_move"}
        end), awful.button({}, 3, function()
            c:activate{context = "titlebar", action = "mouse_resize"}
        end)
    }

    local actions = wibox.widget {
        widget = wibox.container.background,
        bg = colors.transparent,
        shape = maker.radius(6),
        {
            widget = wibox.container.place,
            valign = "center",
            halign = "center",
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(10),
                close_button,
                maximize_button,
                minimize_button
            }
        }
    }

    local widgets_box = {maker.margins(actions, 10, 10, 10, 10)}

    local titlebuttons = wibox.widget {
        widget = wibox.container.background,
        bg = colors.alt_bg,
        {
            layout = wibox.layout.align.horizontal,
            {
                widget = wibox.container.background,
                align = "center",
                maker.horizontal_padding_box(0, 0, 0, 0, widgets_box)
            },
            nil,
            {buttons = buttons, widget = wibox.container.background}
        }
    }

    local titlebar = awful.titlebar(c, {
        size = dpi(settings.title_size),
        position = settings.title_position,
        bg = colors.bg
    })

    titlebar:setup{widget = maker.margins(titlebuttons, 0, 0, 0, 0)}

    awesome.connect_signal("theme::colors", function()
        titlebuttons:set_bg(colors.alt_bg)
        actions:set_bg(colors.alt_bg)
    end)

    awesome.connect_signal("theme::icons", function(icons)
        close_button:set_image(icons.close_icon)
        maximize_button:set_image(icons.maximize)
        minimize_button:set_image(icons.minimize)
    end)
end)
