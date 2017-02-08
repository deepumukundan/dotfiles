local coreConfigs = require "coreConfigs"
local cursorConfigs = require "cursorConfigs"
local hyperConfigs = require "hyperConfigs"
local layoutConfigs = require "layoutConfigs"
local windowConfigs = require "windowConfigs"
local utilityFunctions = require "utilityFunctions"

local alt = {"⌥"}
local cmd = {"⌘"}

-- Hotkeys to resize windows absolutely
k:bind({}, '[', nil, function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end)
k:bind({}, ']', nil, function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end)
k:bind({}, 'f', nil, function() hs.window.focusedWindow():maximize() end)

k:bind({}, 'h', nil, function() hs.window.focusedWindow():focusWindowWest() end)
k:bind({}, 'l', nil, function() hs.window.focusedWindow():focusWindowEast() end)
k:bind({}, 'k', nil, function() hs.window.focusedWindow():focusWindowNorth() end)
k:bind({}, 'j', nil, function() hs.window.focusedWindow():focusWindowSouth() end)

-- Hotkeys to trigger defined layouts & move
k:bind({}, '0', nil, function() windowConfigs.moveWindow() end)
k:bind({}, '1', nil, function() hs.layout.apply(internal_display) end)
k:bind({}, '2', nil, function() hs.layout.apply(triple_display) end)

-- Application hotkeys
k:bind({}, 't', nil, function() toggle_application("iTerm") end)
k:bind({}, 'g', nil, function() toggle_application("Google Chrome") end)
k:bind({}, 'x', nil, function() toggle_application("Xcode") end)

-- Misc hotkeys
k:bind({}, 'r', nil, hs.reload)
k:bind({}, 'y', nil, hs.toggleConsole)
k:bind({}, 'n', nil, function() os.execute("open ~") end)
k:bind({}, 'm', nil, cursorToMiddle)
k:bind({}, 'u', nil, mouseHighlight)
k:bind({}, 'e', nil, hs.hints.windowHints)

-- Finally, show a notification that we finished loading the config successfully
hs.notify.show("Hammerspoon", "", "Locked and loaded!", "")
