local coreConfigs = require "coreConfigs"
local windowConfigs = require "windowConfigs"
local cursorConfigs = require "cursorConfigs"
local hyperConfigs = require "hyperConfigs"
local layoutConfigs = require "layoutConfigs"

----------------------------------- Variables ------------------------------------

-- Things we need to clean up at reload
local configFileWatcher = nil
local appWatcher = nil
local wifiWatcher = nil
local screenWatcher = nil

-- Define some keyboard modifier variables
-- (Node: Capslock disabled normal function and bound to cmd+alt+ctrl+shift via Seil and Karabiner)
local alt = {"⌥"}
local cmd = {"⌘"}

-- Defines for screen watcher
local lastNumberOfScreens = #hs.screen.allScreens()

-------------------------------- Utility Methods ---------------------------------

-- Function to toggle an application between being the frontmost app, and being hidden
function toggle_application(_appName)
    local app = hs.appfinder.appFromName(_appName)
    if not app then
        hs.application.launchOrFocus(_appName)
        return
    end
    local mainwin = app:mainWindow()
    if mainwin == hs.window.focusedWindow() then
        mainwin:application():hide()
    else
        mainwin:application():activate(true)
        mainwin:application():unhide()
        mainwin:focus()
    end
end

-- Callback function for application events
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if(appName ~= nil) then
        	cursorToMiddle()
        end
        if (appName == "Finder") then
            -- Bring all Finder windows forward when one gets activated
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        end
    end
end

-- Callback function for changes in screen layout
function screensChangedCallback()
    newNumberOfScreens = #hs.screen.allScreens()

    if lastNumberOfScreens ~= newNumberOfScreens then
        if newNumberOfScreens == 1 then
            hs.layout.apply(internal_display)
        elseif newNumberOfScreens == 3 then
            hs.layout.apply(triple_display)
        end
    end

    lastNumberOfScreens = newNumberOfScreens
end

-- Reload config automatically
function reloadConfig()
    configFileWatcher:stop()
    configFileWatcher = nil

    appWatcher:stop()
    appWatcher = nil

    screenWatcher:stop()
    screenWatcher = nil

    hs.reload()
end

function fullScreenWindows()
	for win in hs.window.visibleWindows() do
		hs.alert(win)
	end
	--hs.window:ensureIsInScreenBounds())
end

----------------------------- Actual Config Methods ------------------------------
-- Hotkeys to resize windows absolutely
hs.hotkey.bind(hyper, '[', function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end)
hs.hotkey.bind(hyper, ']', function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end)
hs.hotkey.bind(hyper, 'f', function() hs.window.focusedWindow():maximize() end)

hs.hotkey.bind(hyper, 'h', function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(hyper, 'l', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(hyper, 'k', function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(hyper, 'j', function() hs.window.focusedWindow():focusWindowSouth() end)

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

-- Create and start our callbacks
configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.wsup/dotfiles/.wsup/Darwin/.hammerspoon/", reloadConfig)
configFileWatcher:start()

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

screenWatcher = hs.screen.watcher.new(screensChangedCallback)
screenWatcher:start()

-- Finally, show a notification that we finished loading the config successfully
hs.notify.show("Hammerspoon", "", "Locked and loaded!", "")
