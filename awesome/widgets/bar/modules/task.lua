local create_tasklist = function(s)
    local main = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.alltags,
        buttons = {
            awful.button({}, 1, function(c)
                if c == client.focus then
                    c.minimized = true
                else
                    c:emit_signal("request::activate", "tasklist", { raise = true })
                    c.first_tag:view_only()
                end
            end),
            awful.button({}, 3, function()
                awful.menu.client_list({
                    theme = {
                        width = 250,
                        height = 50,
                        bg_normal = colors.alt_bg,
                        bg_focus = colors.bg,
                        fg_normal = colors.fg,
                        fg_focus = colors.fg,
                    }
                })
            end),
        },
        layout = {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(7),
        },
        widget_template = {
            widget = wibox.container.background,
            --bg = colors.alt_bg,
            id = "c_container",
            {
                layout = wibox.layout.align.vertical,
                nil,
                {
                    widget = wibox.container.margin,
                    margins = { left = dpi(8), right = dpi(8) },
                    {
                        widget = wibox.container.constraint,
                        strategy = "max",
                        width = 300,
                        {
                            widget = wibox.widget.textbox,
                            font = settings.font .. " Regular 11",
                            id = "c_name"
                        }
                    }
                },
            }
        }
    }

    local function c_callback(widget, client)
        local c_container = widget:get_children_by_id("c_container")[1]
        local c_name = widget:get_children_by_id("c_name")[1]

        c_name.text = client.class
        --c_container.bg = colors.alt_bg
        if client.minimized then
            c_container.fg = colors.fg .. "50"
            awesome.connect_signal("change::theme", function()
                c_container.fg = colors.fg .. "50"
            end)
        else
            c_container.fg = colors.fg
            awesome.connect_signal("change::theme", function()
                c_container.fg = colors.fg
            end)
        end
    end

    main.widget_template.create_callback = function(widget, client)
        c_callback(widget, client)
    end

    main.widget_template.update_callback = function(widget, client)
        c_callback(widget, client)
    end

    return main
end




return create_tasklist
