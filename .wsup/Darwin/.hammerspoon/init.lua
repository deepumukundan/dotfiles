local coreConfigs = require "coreConfigs"
local cursorConfigs = require "cursorConfigs"
local hyperConfigs = require "hyperConfigs"
local layoutConfigs = require "layoutConfigs"
local windowConfigs = require "windowConfigs"
local utilityFunctions = require "utilityFunctions"

local alt = {"⌥"}
local cmd = {"⌘"}

-- Hotkeys to resize windows absolutely
hyper:bind({}, '[', nil, function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end)
hyper:bind({}, ']', nil, function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end)
hyper:bind({}, 'f', nil, function() hs.window.focusedWindow():maximize() end)

-- Hotkeys to trigger defined layouts & move
hyper:bind({}, '0', nil, function() windowConfigs.moveWindow() end)

hyper:bind({}, '1', nil,
function()
    hs.layout.apply(internal_display)
    hs.notify.show("Display Switch", "", "Internal Display Configuration", "")
end)

hyper:bind({}, '2', nil,
function()
    hs.layout.apply(triple_display)
    hs.notify.show("Display Switch", "", "Triple Monitor Configuration", "")
end)

-- Application hotkeys
hyper:bind({}, 't', nil, function() toggle_application("iTerm") end)
hyper:bind({}, 'g', nil, function() toggle_application("Google Chrome") end)
hyper:bind({}, 'x', nil, function() toggle_application("Xcode") end)

-- Misc hotkeys
hyper:bind({}, 'r', nil, hs.reload)
hyper:bind({}, 'y', nil, hs.toggleConsole)
hyper:bind({}, 'f', nil, function() os.execute("open ~") end)
hyper:bind({}, 'm', nil, cursorToMiddle)
hyper:bind({}, 'u', nil, mouseHighlight)
hyper:bind({}, 'e', nil, hs.hints.windowHints)

-- Trigger another keystroke
--- hyper:bind({}, 'l', nil, function() hs.eventtap.keyStroke({'⌃'}, 'l'); k.triggered = true; end)

-- Finally, show a notification that we finished loading the config successfully
hs.notify.show("Hammerspoon", "", "Locked and loaded!", "")
