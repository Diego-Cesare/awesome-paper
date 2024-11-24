require("widgets.control_center.init")
-- Create the control popup
local control = awful.popup({
    widget = wibox.container.background,
    ontop = true,
    bg = colors.bg,
    border_width = dpi(1),
    border_color = colors.fg,
    shape = maker.radius(10),
    visible = false,
    type = "dock",
    placement = function(c)
        if settings.bar_position == "top" then
            awful.placement.top_left(c, { honor_workarea = true, margins = 15 })
        else
            awful.placement.bottom_left(c, { honor_workarea = true, margins = 15 })
        end
    end,
})

-- Add widgets to the control popup
control:setup({
    widget = wibox.container.background,
    {
        forced_height = dpi(845),
        forced_width = dpi(500),
        widget = wibox.container.margin,
        margins = { top = dpi(20), bottom = dpi(10), left = dpi(20), right = dpi(20) },
        {
            layout = wibox.layout.fixed.vertical,
            {
                layout = wibox.layout.flex.horizontal,
                expand = "none",
                {
                    layout = wibox.layout.fixed.vertical,
                    maker.margins(uptime, 0, 20, 10, 10),
                    maker.margins(clock, 0, 20, 10, 10),
                },
                nil,
                maker.margins(weather, 0, 0, 10, 10),
            },
            maker.margins(calendar, 0, 0, 20, 20),
            maker.margins(volume, 0, 0, 10, 10),
            maker.margins(screenshot, 0, 0, 20, 10),
        },
    },
})

awesome.connect_signal("change::theme", function()
    control:set_bg(colors.bg)
    control.border_color = colors.fg
end)

return control
