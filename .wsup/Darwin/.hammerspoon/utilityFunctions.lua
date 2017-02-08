-- Things we need to clean up at reload
local configFileWatcher = nil
local appWatcher = nil
local wifiWatcher = nil
local screenWatcher = nil

-- Defines for screen watcher
local lastNumberOfScreens = #hs.screen.allScreens()

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
    hyper.trigerred = true
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

-- Create and start our callbacks
configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.wsup/dotfiles/.wsup/Darwin/.hammerspoon/", reloadConfig)
configFileWatcher:start()

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

screenWatcher = hs.screen.watcher.new(screensChangedCallback)
screenWatcher:start()
