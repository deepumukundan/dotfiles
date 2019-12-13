-- Define monitor names for layout purposes
local display_left = hs.screen.allScreens()[2]
local display_middle = hs.screen.allScreens()[3]
local display_laptop = hs.screen.allScreens()[1]

-- Define window layouts
--   Format reminder:
--     {"App name", "Window name", "Display Name", "unitrect", "framerect", "fullframerect"},

internal_display = {
    {"Microsoft Outlook", nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"iTerm2",            nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Google Chrome",     nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Code",              nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Xcode",             nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"ReadKit",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Charles",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Slack",             nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Sourcetree",        nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Calendar",          nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Notes",             nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Spotify",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"iTunes",            "iTunes",     display_laptop, hs.layout.maximized, nil, nil},
    {"iTunes",            "MiniPlayer", display_laptop, nil,                 nil, hs.geometry.rect(575, -45, 215, 45)},
    {"Finder",            nil,          display_laptop, hs.layout.maximized, nil, nil},
}

triple_display = {
    {"Microsoft Outlook", nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"iTerm2",            nil,          display_left,   hs.layout.maximized, nil, nil},
    {"Google Chrome",     nil,          display_middle, hs.layout.right50,   nil, nil},
    {"Code",              nil,          display_middle, hs.layout.left50,    nil, nil},
    {"Xcode",             nil,          display_middle, hs.layout.left50,    nil, nil},
    {"ReadKit",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Charles",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Slack",             nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Sourcetree",        nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Calendar",          nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Notes",             nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Spotify",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"iTunes",            "iTunes",     display_laptop, hs.layout.maximized, nil, nil},
    {"iTunes",            "MiniPlayer", display_laptop, nil,                 nil, hs.geometry.rect(575, -45, 215, 45)},
    {"Finder",            nil,          display_laptop, hs.layout.left50,    nil, nil},
}
