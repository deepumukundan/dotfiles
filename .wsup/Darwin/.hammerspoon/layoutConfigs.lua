-- Define monitor names for layout purposes
local display_left = hs.screen.allScreens()[1]
local display_middle = hs.screen.allScreens()[3]
local display_laptop = hs.screen.allScreens()[2]

-- Define window layouts
--   Format reminder:
--     {"App name", "Window name", "Display Name", "unitrect", "framerect", "fullframerect"},

internal_display = {
    {"Mail", 			        nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Airmail", 		      nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Microsoft Outlook", nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"iTerm2",            nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Google Chrome",     nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"TextWrangler",      nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Xcode",             nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"ReadKit",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Atom",              nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"HipChat",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"SourceTree",        nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Calendar",          nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Evernote",          nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Spotify",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"iTunes",            "iTunes",     display_laptop, hs.layout.maximized, nil, nil},
    {"iTunes",            "MiniPlayer", display_laptop, nil,                 nil, hs.geometry.rect(575, -45, 215, 45)},
    {"Finder",            nil,          display_laptop, hs.layout.maximized, nil, nil},
}

triple_display = {
    {"Mail", 			  nil,                display_left,   hs.layout.left50,    nil, nil},
    {"Airmail", 		  nil,              display_left, 	hs.layout.left50,    nil, nil},
    {"Microsoft Outlook", nil,          display_left,   hs.layout.left50,    nil, nil},
    {"iTerm2",            nil,          display_left,   hs.layout.right50,   nil, nil},
    {"Google Chrome",     nil,          display_middle, hs.layout.maximized, nil, nil},
    {"TextWrangler",      nil,          display_middle, hs.layout.maximized, nil, nil},
    {"Xcode",             nil,          display_middle, hs.layout.maximized, nil, nil},
    {"ReadKit",           nil,          display_middle, hs.layout.maximized, nil, nil},
    {"Atom",              nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"HipChat",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"SourceTree",        nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Calendar",          nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Evernote",          nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Spotify",           nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"iTunes",            "iTunes",     display_laptop, hs.layout.maximized, nil, nil},
    {"iTunes",            "MiniPlayer", display_laptop, nil,                 nil, hs.geometry.rect(575, -45, 215, 45)},
    {"Finder",            nil,          display_laptop, hs.layout.left50,    nil, nil},
}
