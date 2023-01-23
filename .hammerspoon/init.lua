-- Mike Solomon @msol 2019

local log = hs.logger.new('main', 'info')
DEVELOPING_THIS = false -- set to true to ease debugging

HYPER = {'ctrl', 'shift', 'alt', 'cmd'}

-- App bindings
function setUpAppBindings()
  --   hyperFocusAll('w', 'React Native Debugger', 'Simulator', 'qemu-system-x86_64')
  --   hyperFocusOrOpen('e', 'Notes')
  --   hyperFocus('i', 'IntelliJ IDEA', 'IntelliJ IDEA-EAP', 'Xcode', 'Android Studio', 'Atom', 'Code')
  -- hyperFocusOrOpen('d', 'iTerm2')
  -- hyperFocusOrOpen('a', 'Finder')
  hyperFocus('f', 'Google Chrome', 'Brave Browser')
  hyperFocus('c', 'RubyMine', 'Visual Studio Code')
  hyperFocus('y', 'Spotify')
  hyperFocus('t', 'Telegram')
  hyperFocusOrOpen('v', 'Visual Studio Code')
  hyperFocusOrOpen('d', 'iTerm2')
  hyperFocusOrOpen('m', 'Activity Monitor')
  hyperFocusOrOpen('r', 'MongoDB Compass')
end

-- focus on the last-focused window of the application given by name, or else launch it
function hyperFocusOrOpen(key, app)
  local focus = mkFocusByPreferredApplicationTitle(true, app)
  function focusOrOpen()
    return (focus() or hs.application.launchOrFocus(app))
  end
  hs.hotkey.bind(HYPER, key, focusOrOpen)
end

-- focus on the last-focused window of the first application given by name
function hyperFocus(key, ...)
  hs.hotkey.bind(HYPER, key, mkFocusByPreferredApplicationTitle(true, ...))
end


-- focus on the last-focused window of every application given by name
function hyperFocusAll(key, ...)
  hs.hotkey.bind(HYPER, key, mkFocusByPreferredApplicationTitle(false, ...))
end


-- creates callback function to select application windows by application name
function mkFocusByPreferredApplicationTitle(stopOnFirst, ...)
  local arguments = {...} -- create table to close over variadic args
  return function()
    local nowFocused = hs.window.focusedWindow()
    local appFound = false
    for _, app in ipairs(arguments) do
      if stopOnFirst and appFound then break end
      log:d('Searching for app ', app)
      local application = hs.application.get(app)
      if application ~= nil then
        log:d('Found app', application)
        local window = application:mainWindow()
        if window ~= nil then
          log:d('Found main window', window)
          if window == nowFocused then
            log:d('Already focused, moving on', application)
          else
            window:focus()
            appFound = true
          end
        end
      end
    end
    return appFound
  end
end


function maybeEnableDebug()
  if DEVELOPING_THIS then
    log.setLogLevel('debug')
    log.d('Loading in development mode')
    -- automatically reload changes when we're developing
    hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', hs.reload):start()
    hs.alert('Hammerspoon config reloaded')
    log:d('Hammerspoon config reloaded')
  end
end

maybeEnableDebug()
setUpAppBindings()
