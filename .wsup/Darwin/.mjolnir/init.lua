-------------------------------- Imports section --------------------------------

-- Load Extensions
local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local screen = require "mjolnir.screen"
local fnutils = require "mjolnir.fnutils"
local keycodes = require "mjolnir.keycodes"
local alert = require "mjolnir.alert"
local window = require "mjolnir.window"

-- User packages
local grid = require "mjolnir.bg.grid"
local hints = require "mjolnir.th.hints"
local appfinder = require "mjolnir.cmsj.appfinder"
local cursor = require "mjolnir.jstevenson.cursor"

----------------------------------- Variables ------------------------------------

local definitions = nil
local hyper = nil
hyper = {"cmd", "alt", "ctrl","shift"}
auxWin = nil
local hotkeys = {}

------------------------------------ Utility -------------------------------------

local gridset = function(frame)
	return function()
		local win = window.focusedwindow()
		if win then
			grid.set(win, frame, win:screen())
		else
			alert.show("No focused window.")
		end
	end
end

function saveFocus()
  auxWin = window.focusedwindow()
  alert.show("Window '" .. auxWin:title() .. "' saved.")
end

function focusSaved()
  if auxWin then
    auxWin:focus()
  end
end

function createHotkeys()
  for key, fun in pairs(definitions) do
    local mod = hyper
    if string.len(key) == 2 and string.sub(key,2,2) == "c" then
      mod = {"cmd"}
    end

    local hk = hotkey.new(mod, string.sub(key,1,1), fun)
    table.insert(hotkeys, hk)
    hk:enable()
  end
end

function rebindHotkeys()
  for i, hk in ipairs(hotkeys) do
    hk:disable()
  end
  hotkeys = {}
  createHotkeys()
  alert.show("Rebound Hotkeys")
end

function applyPlace(win, place)
  local scrs = screen:allscreens()
  local scr = scrs[place[1]]
  grid.set(win, place[2], scr)
end

function applyLayout(layout)
  return function()
    for appName, place in pairs(layout) do
      local app = appfinder.app_from_name(appName)
      if app then
        for i, win in ipairs(app:allwindows()) do
          applyPlace(win, place)
        end
      end
    end
  end
end

function cursorMiddle()
	local x = screen.mainscreen():fullframe().w
	local y = screen.mainscreen():fullframe().h
	cursor.warptopoint(x/2, y/2)
end

function init()
  createHotkeys()
  keycodes.inputsourcechanged(rebindHotkeys)
  alert.show("Mjolnir, at your service.")
end

----------------------- Actual Config Methods --------------------------

-- Window Hints
hotkey.bind({"cmd"},"e",hints.windowHints)

-- Set grid size.
grid.GRIDWIDTH  = 6
grid.GRIDHEIGHT = 8
grid.MARGINX = 0
grid.MARGINY = 0
local gw = grid.GRIDWIDTH
local gh = grid.GRIDHEIGHT

local gomiddle = {x = 1, y = 1, w = 4, h = 6}
local goleft = {x = 0, y = 0, w = gw/2, h = gh}
local goright = {x = gw/2, y = 0, w = gw/2, h = gh}
local gobig = {x = 0, y = 0, w = gw, h = gh}

local layout1 = {
  iTerm = {1, gobig},
  ["Microsoft Outlook"] = {1, gobig},
  ["Google Chrome"] = {1, gobig},
  TextWrangler = {1, gobig},
  Spotify = {1, gobig},
  SourceTree = {1, gobig},
  HipChat = {1, gobig},
}
local layout2 = {
  iTerm = {1, goleft},
  ["Microsoft Outlook"] = {1, goright},
  ["Google Chrome"] = {2, gobig},
  TextWrangler = {2, gobig},
  Spotify = {3, gomiddle},
  SourceTree = {3, gomiddle},
  HipChat = {3, gomiddle},
}
local fullApps = {
  "Safari","Xcode","Google Chrome","TextWrangler"
}
fnutils.each(fullApps, function(app) layout1[app] = {1, gobig} end)

definitions = {
  [";"] = saveFocus,
  a = focusSaved,

  ["1"] = grid.maximize_window,
  ["2"] = gridset(goleft),
  ["3"] = gridset(goright),
  ["4"] = gridset(gomiddle),
  m = cursorMiddle,
  
  o = applyLayout(layout1),
  p = applyLayout(layout2),

  d = grid.pushwindow_nextscreen,
  r = mjolnir.reload,
--  q = function() appfinder.app_from_name("Mjolnir"):kill() end,
--  k = function() hints.appHints(appfinder.app_from_name("Emacs")) end,
--  j = function() hints.appHints(window.focusedwindow():application()) end,
  ec = hints.windowHints
}

-- launch and focus applications
fnutils.each({
  { key = "g", app = "Google Chrome" },
  { key = "i", app = "iTerm" },
  { key = "x", app = "Xcode-Beta" },
}, function(object)
    definitions[object.key] = function() application.launchorfocus(object.app) end
end)

init()