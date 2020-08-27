-- Define monitor names for layout purposes
-- display_laptop = hs.screen.allScreens()[3]
display_laptop = hs.screen.findByName("Color LCD")
display_middle = hs.screen.findByName("DELL U3415W")
display_vertic = hs.screen.findByName("DELL U2419H")
display_primee = display_laptop or display_middle

-- Define window layouts
--   Format reminder:
--     {"App name", "Window name", "Display Name", "unitrect", "framerect", "fullframerect"},

single_display = {
    {"Microsoft Outlook", nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"iTerm2",            nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"Google Chrome",     nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"Code",              nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"Xcode",             nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"ReadKit",           nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"Charles",           nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"Slack",             nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"zoom.us",           nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"Sourcetree",        nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"GitHub Desktop",    nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"Calendar",          nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"Notes",             nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"Spotify",           nil,          display_primee, hs.layout.maximized,    nil, nil},
    {"iTunes",            "MiniPlayer", display_primee, nil,                    nil, hs.geometry.rect(575, -45, 215, 45)},
    {"Finder",            nil,          display_primee, hs.layout.maximized,    nil, nil},
}

single_display_split = {
    {"Microsoft Outlook", nil,          display_primee, hs.layout.left50,       nil, nil},
    {"iTerm2",            nil,          display_primee, hs.layout.left50,       nil, nil},
    {"Google Chrome",     nil,          display_primee, hs.layout.right50,      nil, nil},
    {"Code",              nil,          display_primee, hs.layout.left50,       nil, nil},
    {"Xcode",             nil,          display_primee, hs.layout.left50,       nil, nil},
    {"ReadKit",           nil,          display_primee, hs.layout.right50,      nil, nil},
    {"Charles",           nil,          display_primee, hs.layout.right50,      nil, nil},
    {"Slack",             nil,          display_primee, hs.layout.right50,      nil, nil},
    {"zoom.us",           nil,          display_primee, hs.layout.left50,       nil, nil},
    {"Sourcetree",        nil,          display_primee, hs.layout.right50,      nil, nil},
    {"GitHub Desktop",    nil,          display_primee, hs.layout.right50,      nil, nil},
    {"Calendar",          nil,          display_primee, hs.layout.right50,      nil, nil},
    {"Notes",             nil,          display_primee, hs.layout.right50,      nil, nil},
    {"Spotify",           nil,          display_primee, hs.layout.right50,      nil, nil},
    {"iTunes",            "MiniPlayer", display_primee, nil,                    nil, hs.geometry.rect(575, -45, 215, 45)},
    {"Finder",            nil,          display_primee, hs.layout.maximized,    nil, nil},
}

double_display = {
    {"Microsoft Outlook", nil,          display_vertic, hs.layout.maximized,    nil, nil},
    {"iTerm2",            nil,          display_vertic, hs.layout.maximized,    nil, nil},
    {"Google Chrome",     nil,          display_middle, hs.layout.right50,      nil, nil},
    {"Code",              nil,          display_middle, hs.layout.left50,       nil, nil},
    {"Xcode",             nil,          display_middle, hs.layout.left50,       nil, nil},
    {"ReadKit",           nil,          display_vertic, hs.layout.maximized,    nil, nil},
    {"Charles",           nil,          display_middle, hs.layout.right50,      nil, nil},
    {"Slack",             nil,          display_vertic, hs.layout.maximized,    nil, nil},
    {"zoom.us",           nil,          display_primee, hs.layout.left50,       nil, nil},
    {"Sourcetree",        nil,          display_middle, hs.layout.right50,      nil, nil},
    {"GitHub Desktop",    nil,          display_middle, hs.layout.right50,      nil, nil},
    {"Calendar",          nil,          display_middle, hs.layout.right50,      nil, nil},
    {"Notes",             nil,          display_middle, hs.layout.right50,      nil, nil},
    {"Spotify",           nil,          display_vertic, hs.layout.maximized,    nil, nil},
    {"iTunes",            "MiniPlayer", display_middle, nil,                    nil, hs.geometry.rect(575, -45, 215, 45)},
    {"Finder",            nil,          display_middle, hs.layout.right50,      nil, nil},
}

triple_display = {
    {"Microsoft Outlook", nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"iTerm2",            nil,          display_vertic, hs.layout.maximized,    nil, nil},
    {"Google Chrome",     nil,          display_middle, hs.layout.right50,      nil, nil},
    {"Code",              nil,          display_middle, hs.layout.left50,       nil, nil},
    {"Xcode",             nil,          display_middle, hs.layout.left50,       nil, nil},
    {"ReadKit",           nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"Charles",           nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"Slack",             nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"zoom.us",           nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"Sourcetree",        nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"GitHub Desktop",    nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"Calendar",          nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"Notes",             nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"Spotify",           nil,          display_laptop, hs.layout.maximized,    nil, nil},
    {"iTunes",            "MiniPlayer", display_laptop, nil,                    nil, hs.geometry.rect(575, -45, 215, 45)},
    {"Finder",            nil,          display_laptop, hs.layout.left50,       nil, nil},
}
