local create_taglist = function(s)
    local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t)
            t:view_only()
        end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end),
        awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end)
    )

    local update_tag = function(self, c3, _)
        if c3.selected then
            self:get_children_by_id("tags")[1].forced_width = dpi(50)
            self:get_children_by_id("tags")[1].bg = colors.transparent
            self:get_children_by_id("tags")[1].border_width = dpi(1)
            self:get_children_by_id("tags")[1].border_color = colors.fg
            anime.open(self:get_children_by_id("tags")[1], 0.2, 16, 50)
            awesome.connect_signal("change::theme", function()
                self:get_children_by_id("tags")[1].border_color = colors.fg
            end)
        elseif #c3:clients() == 0 then
            self:get_children_by_id("tags")[1].forced_width = dpi(16)
            self:get_children_by_id("tags")[1].bg = colors.transparent
            self:get_children_by_id("tags")[1].border_width = dpi(1)
            self:get_children_by_id("tags")[1].border_color = colors.fg
            awesome.connect_signal("change::theme", function()
                self:get_children_by_id("tags")[1].border_color = colors.fg
            end)
        else
            if c3.urgent then
                self:get_children_by_id("tags")[1].forced_width = dpi(50)
                self:get_children_by_id("tags")[1].bg = colors.red
            else
                self:get_children_by_id("tags")[1].forced_width = dpi(50)
                self:get_children_by_id("tags")[1].bg = colors.transparent
                self:get_children_by_id("tags")[1].border_width = dpi(1)
                self:get_children_by_id("tags")[1].border_color = colors.fg
                awesome.connect_signal("change::theme", function()
                    self:get_children_by_id("tags")[1].border_color = colors.fg
                end)
            end
        end
    end

    local taglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = maker.radius(0),
        },
        layout = {
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            id = "tags",
            widget = wibox.container.background,
            --forced_width = dpi(15),
            shape = gears.shape.rounded_bar,
            create_callback = function(self, c3, _)
                update_tag(self, c3, _)
            end,
            update_callback = function(self, c3, _)
                update_tag(self, c3, _)
            end,
        },

        buttons = taglist_buttons,
    })

    local the_taglist = wibox.widget({
        widget = wibox.container.background,
        forced_width = dpi(270),
        bg = colors.alt_bg,

        shape = maker.radius(6),
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            nil,
            maker.margins(taglist, 0, 0, 10, 10),
            nil,
        },
    })
    awesome.connect_signal("change::theme", function()
        the_taglist.bg = colors.alt_bg
    end)
    return maker.margins(the_taglist, 0, 0, 0, 0)
end

return create_taglist
