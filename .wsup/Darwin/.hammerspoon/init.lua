local windowConfigs = require "windowConfigs"

---------------------------------- Core Config -----------------------------------
-- Ensure the IPC command line client is available
hs.ipc.cliInstall()

-- Set the style of hints
-- hs.hints.fontName = "SanFranciscoDisplay-Medium"
-- hs.hints.style = "vimperator"
-- hs.fnutil.map(hs.window.visibleWindows(), ensureIsInScreenBounds) end) -- TODO - Fix this so that after arrangement windows are not extending
-- hs.hotkey.bind(hyper, ';', function() hs.fnutil.map(hs.window.visibleWindows(), hs.grid.snap) end) --TODO - Verify

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
local hyper = {"⌘", "⌥", "⌃", "⇧"}

-- Define monitor names for layout purposes
local display_laptop = hs.screen.allScreens()[1]
local display_middle = hs.screen.allScreens()[2]
local display_left = hs.screen.allScreens()[3]

-- Defines for screen watcher
local lastNumberOfScreens = #hs.screen.allScreens()

-- Define window layouts
--   Format reminder:
--     {"App name", "Window name", "Display Name", "unitrect", "framerect", "fullframerect"},

local internal_display = {
    {"Mail", 			  nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Microsoft Outlook", nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"iTerm",             nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Google Chrome",     nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"TextWrangler",      nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Xcode",             nil,          display_laptop, hs.layout.maximized, nil, nil},
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

local triple_display = {
    {"Mail", 			  nil,          display_left,    hs.layout.left50,    nil, nil},
    {"Microsoft Outlook", nil,          display_left,    hs.layout.left50,    nil, nil},
    {"iTerm",             nil,          display_left,    hs.layout.right50,   nil, nil},
    {"Google Chrome",     nil,          display_middle,  hs.layout.maximized, nil, nil},
    {"TextWrangler",      nil,          display_middle,  hs.layout.maximized, nil, nil},
    {"Xcode",             nil,          display_middle,  hs.layout.maximized, nil, nil},
    {"Atom",              nil,          display_laptop,  hs.layout.maximized, nil, nil},
    {"HipChat",           nil,          display_laptop,  hs.layout.maximized, nil, nil},
    {"SourceTree",        nil,          display_laptop,  hs.layout.maximized, nil, nil},
    {"Calendar",          nil,          display_laptop,  hs.layout.maximized, nil, nil},
    {"Evernote",          nil,          display_laptop,  hs.layout.maximized, nil, nil},
    {"Spotify",           nil,          display_laptop,  hs.layout.maximized, nil, nil},    
    {"iTunes",            "iTunes",     display_laptop,  hs.layout.maximized, nil, nil},
    {"iTunes",            "MiniPlayer", display_laptop,  nil,                 nil, hs.geometry.rect(575, -45, 215, 45)},
    {"Finder",            nil,          display_laptop,  hs.layout.left50,    nil, nil},
}

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

-- Move the cursor to middle of focused application
function cursorToMiddle()
  	local win = hs.window.focusedWindow()  	
  	if(win ~= nil) then
		local focusedFrame = win:frame()
		local screen = win:screen()
		if(screen ~= nil) then	
			local screenFrame = screen:frame()
	
			local c = hs.mouse.getAbsolutePosition()
			c.x = focusedFrame.w/2 + (focusedFrame.x - screenFrame.x)
			c.y = focusedFrame.h/2 + (focusedFrame.y - screenFrame.y)
		
			hs.mouse.setRelativePosition(c, screen)
		end
	end
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
hs.hotkey.bind(hyper, '0', function() windowConfigs.moveWindow() end)

-- Hotkeys to trigger defined layouts
hs.hotkey.bind(hyper, '1', function() hs.layout.apply(internal_display) end)
hs.hotkey.bind(hyper, '2', function() hs.layout.apply(triple_display) end)

-- Application hotkeys
hs.hotkey.bind(hyper, 't', function() toggle_application("iTerm") end)
hs.hotkey.bind(hyper, 'g', function() toggle_application("Google Chrome") end)
hs.hotkey.bind(hyper, 'x', function() toggle_application("Xcode") end)
hs.hotkey.bind(hyper, 'e', function() toggle_application("Evernote") end)

-- Misc hotkeys
hs.hotkey.bind(hyper, 'r', hs.reload)
hs.hotkey.bind(hyper, 'y', hs.toggleConsole)
hs.hotkey.bind(hyper, 'n', function() os.execute("open ~") end)
hs.hotkey.bind(hyper, 'm', cursorToMiddle)
hs.hotkey.bind(cmd,   'e', hs.hints.windowHints)

-- Create and start our callbacks
configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.wsup/dotfiles/.wsup/Darwin/.hammerspoon/", reloadConfig)
configFileWatcher:start()

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

screenWatcher = hs.screen.watcher.new(screensChangedCallback)
screenWatcher:start()

-- Finally, show a notification that we finished loading the config successfully
hs.notify.show("Hammerspoon", "", "Locked and loaded!", "")