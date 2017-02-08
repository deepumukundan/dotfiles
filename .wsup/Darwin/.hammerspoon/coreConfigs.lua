-- Disable window animations (janky for iTerm)
hs.window.animationDuration = 0

-- Ensure the IPC command line client is available
hs.ipc.cliInstall()

-- Set the style of hints
-- hs.hints.fontName = "SanFranciscoDisplay-Medium"
-- hs.hints.style = "vimperator"
-- hs.fnutil.map(hs.window.visibleWindows(), ensureIsInScreenBounds) end) -- TODO - Fix this so that after arrangement windows are not extending
-- hs.hotkey.bind(hyper, ';', function() hs.fnutil.map(hs.window.visibleWindows(), hs.grid.snap) end) --TODO - Verify
