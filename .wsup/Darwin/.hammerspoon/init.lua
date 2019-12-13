local coreConfigs = require "coreConfigs"
local cursorConfigs = require "cursorConfigs"
local hyperConfigs = require "hyperConfigs"
local layoutConfigs = require "layoutConfigs"
local windowConfigs = require "windowConfigs"
local utilityFunctions = require "utilityFunctions"

-- local alt = {"⌥"}
-- local cmd = {"⌘"}

-- Hotkeys to resize windows absolutely
hyper:bind({}, '[', nil, function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end)
hyper:bind({}, ']', nil, function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end)
hyper:bind({}, 'z', nil, function() hs.window.focusedWindow():maximize() end)

-- Hotkeys to trigger defined layouts & move
hyper:bind({}, '0', nil, 
function() 
    windowConfigs.moveWindow() 
end)

hyper:bind({}, '1', nil,
function()
    hs.layout.apply(internal_display)
    hs.notify.show("Display Switch", "", "Internal Display Configuration", "")
end)

hyper:bind({}, '2', nil,
function()
    hs.layout.apply(triple_display)
    hs.notify.show("Display Switch", "", "Triple Display Configuration", "")
end)

-- Hotkeys
hyper:bind({}, 'e', nil, hs.hints.windowHints)
hyper:bind({}, 'f', nil, function() os.execute("open ~") end)
hyper:bind({}, 'g', nil, function() toggle_application("Google Chrome") end)
hyper:bind({}, 'k', nil, function() toggle_application("ReadKit") end)
hyper:bind({}, 'l', nil, function() toggle_application("Slack") end)
hyper:bind({}, 'm', nil, cursorToMiddle)
hyper:bind({}, 'o', nil, function() toggle_application("Outlook") end)
hyper:bind({}, 'r', nil, hs.reload)
hyper:bind({}, 's', nil, function() toggle_application("Sourcetree") end)
hyper:bind({}, 't', nil, function() toggle_application("iTerm") end)
hyper:bind({}, 'u', nil, mouseHighlight)
hyper:bind({}, 'v', nil, function() toggle_application("Code") end)
hyper:bind({}, 'x', nil, function() toggle_application("Xcode") end)
hyper:bind({}, 'y', nil, hs.toggleConsole)

-- Trigger another keystroke
--- hyper:bind({}, 'l', nil, function() hs.eventtap.keyStroke({'⌃'}, 'l'); k.triggered = true; end)

-- Finally, show a notification that we finished loading the config successfully
hs.notify.show("Hammerspoon", "", "Locked and loaded!", "")
