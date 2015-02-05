---------------------------------- Core Config -----------------------------------
hs.window.animationDuration = 0  -- Disable window animations (janky for iTerm)

----------------------------------- Variables ------------------------------------
--
--		saved.win 		The window last moved.
--		saved.winframe The frame for the window before moving.
--
saved = {}
saved.win = {}
saved.winframe = {}
local hyper = {"⌘", "⌥", "⌃", "⇧"}

----------------------------------- Methods ------------------------------------
function returnLast()
	if(saved.win ~= {}) then
		saved.win:setFrame(saved.winframe)
	end
end

function leftThirds()
   saved.win = hs.window.focusedWindow()
   saved.winframe = saved.win:frame()
   hs.grid.set(saved.win, {x = 0, y = 0, w = 1, h = 3}, hs.screen.mainScreen())
end

function rightThirds()
   saved.win = hs.window.focusedWindow()
   saved.winframe = saved.win:frame()
   hs.grid.set(hs.window.focusedWindow(), {x = 1, y = 0, w = 2, h = 3}, hs.screen.mainScreen())
end

function moveWindow()
   saved.win = hs.window.focusedWindow()
   saved.winframe = saved.win:frame()
   saved.win:moveToScreen(hs.screen.allScreens()[1])
end


--
-- Function:         snapWindow
--
-- Description:      Move the current window to the closes area in the
--                   window matrix.
--
function snapWindow()
	saved.win = hs.window.focusedWindow()
	saved.winframe = saved.win:frame()
	hs.grid.snap(hs.window.focusedWindow())
end

--
-- Function:		setgrid
--
-- Description:	This function sets the current window to
--						the specified grid location.
--
function setgrid( sx, sy, sw, sh)
   saved.win = hs.window.focusedWindow()
   saved.winframe = saved.win:frame()
	hs.grid.set(hs.window.focusedWindow(), {x = sx, y = sy, w = sw, h = sh}, hs.screen.mainScreen())
end

--
-- Global Variables
--
--		expose.wins 		A list of windows exposed
-- 		expose.size 		The number of windows in expose.wins
-- 		expose.winsSize		The frame for each window exposed
--								original location and size.
--		expose.sX			The size of the grid in the X for expose
--		expose.sY 			The size of the grid in the Y for expose
--
expose = {}
expose.wins = {}
expose.size = 0
expose.winsSize = {}
expose.sX = 0
expose.sY = 0

--
-- Function:		exposeStart
--
-- Description:	This function starts a window expose. It
--              gets the name of the application to expose.
--
function exposeStart( appName )
	saveWidth = hs.grid.GRIDWIDTH
	saveHeight = hs.grid.GRIDHEIGHT
	app = hs.appfinder.appFromName( appName )
	app:activate(true)
	expose.wins = app:allWindows()
	expose.size = 0
	for Index, win in pairs( expose.wins ) do
		expose.size = expose.size + 1
		expose.winsSize[ Index ] = win:frame()
	end
	if expose.size == 1 then
		expose.wins[1]:focus()
	else
		sX = math.ceil(math.sqrt(expose.size))
		sY = math.ceil(expose.size / sX)
		hs.grid.GRIDWIDTH = sX
		hs.grid.GRIDHEIGHT = sY
		for index, win in pairs(expose.wins) do
			index = index - 1
			iY = math.floor(index / sX)
			iX = index - (iY * sX)
			hs.grid.set(win, { x=iX, y=iY, w=1, h=1}, hs.screen.mainScreen())
		end
		expose.sX = sX
		expose.sY = sY
		hs.grid.GRIDWIDTH = saveWidth
		hs.grid.GRIDHEIGHT = saveHeight
	end
	print(expose.size)
end

--
-- Function:		exposeStop
--
-- Description:	This function puts all the windows back to
--              their original location and focus' on the
--              window given by it's col, row address in the
--              expose.
--
function exposeStop( col, row )
	exWin = ""
	for Index, win in pairs( expose.wins ) do
		win:setFrame(expose.winsSize[ Index ])
		if( Index == (expose.sX*row + col + 1)) then
			exWin = win
		end
	end
	exWin:focus()
end

--
-- Function:        runningApps
--
-- Description:     This function lists all applications running
--                  and visible from the AppBar.
--
function runningApps( )
    apps = hs.application.runningApplications()
    for index, app in pairs( apps ) do
        if app:kind() == 1 then
            wins = app:visibleWindows()
        	size = 0
        	for Index, win in pairs( wins ) do
        		size = size + 1
        	end
        	if size >= 1 then
                print( app:title() )
            end
        end
	end
end

--- osexec(command[, with_user_env]) -> output, status, type, rc
--- Function
--- Runs a shell command and returns stdout as a string (may include a trailing newline), followed by true or nil indicating if the command completed successfully, the exit type ("exit" or "signal"), and the result code.
---
---  If `with_user_env` is `true`, then invoke the user's default shell as an interactive login shell in which to execute the provided command in order to make sure their setup files are properly evaluated so extra path and environment variables can be set.  This is not done, if `with_user_env` is `false` or not provided, as it does add some overhead and is not always strictly necessary.
function osexec(command, user_env)
    local f
    if user_env then
        f = io.popen(os.getenv("SHELL").." -l -i -c \""..command.."\"", 'r')
    else
        f = io.popen(command, 'r')
    end
    local s = f:read('*a')
    local status, exit_type, rc = f:close()
    return s, status, exit_type, rc
end