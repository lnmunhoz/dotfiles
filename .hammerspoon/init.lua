-- Credits to:
--  https://github.com/kkamdooong/hammerspoon-control-hjkl-to-arrow/blob/master/init.lua
--  https://gist.github.com/xpgeng/2d5df178a479b19a54d1c274b5f7ebd9

local log = hs.logger.new('main', 'info')
DEVELOPING_THIS = false -- set to true to ease debugging

-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, "F17")

-- Trigger existing hyper key shortcuts
hyper:bind({}, 'm', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'm') end)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  hyper.triggered = false
  hyper:enter()
end


-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
releasedF18 = function()
  hyper:exit()
  if not k.triggered then
    -- hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- Bind Hyper + hjkl as the arrows 
arrowKey = function(arrow, modifiers) 
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(arrow), true):post()
  event.newKeyEvent(modifiers, string.lower(arrow), false):post()
end

mapArrow = function(key, arrow, modifiers)
  hyper:bind(modifiers, key, function() arrowKey(arrow, modifiers); end, nil, function() arrowKey(arrow, modifiers); end)
end

-- focus on the last-focused window of the application given by name, or else launch it
function hyperFocusOrOpen(key, app)
  local focus = mkFocusByPreferredApplicationTitle(true, app)
  function focusOrOpen()
    return (focus() or hs.application.launchOrFocus(app))
  end
  hyper:bind({}, key, focusOrOpen)
  -- hs.hotkey.bind(HYPER, key, focusOrOpen)
end

-- focus on the last-focused window of the first application given by name
function hyperFocus(key, ...)
  hyper:bind({}, key, mkFocusByPreferredApplicationTitle(true, ...))
end


-- focus on the last-focused window of every application given by name
function hyperFocusAll(key, ...)
  hyper:bind({}, key, mkFocusByPreferredApplicationTitle(false, ...))
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

setupKeys = function()
  mapArrow('j', 'left', {})
  mapArrow('j', 'left', {'cmd'})
  mapArrow('j', 'left', {'alt'})
  mapArrow('k', 'down', {'shift'})
  mapArrow('j', 'left', {'cmd', 'shift'})
  mapArrow('j', 'left', {'alt', 'shift'})

  mapArrow('k', 'down', {})
  mapArrow('k', 'down', {'cmd'})
  mapArrow('k', 'down', {'alt'})
  mapArrow('k', 'down', {'shift'})
  mapArrow('k', 'down', {'cmd', 'shift'})
  mapArrow('k', 'down', {'alt', 'shift'})

  mapArrow('l', 'right', {})
  mapArrow('l', 'right', {'cmd'})
  mapArrow('l', 'right', {'alt'})
  mapArrow('l', 'right', {'shift'})
  mapArrow('l', 'right', {'cmd', 'shift'})
  mapArrow('l', 'right', {'alt', 'shift'})

  mapArrow('i', 'up', {})
  mapArrow('i', 'up', {'cmd'})
  mapArrow('i', 'up', {'alt'})
  mapArrow('i', 'up', {'shift'})
  mapArrow('i', 'up', {'cmd', 'shift'})
  mapArrow('i', 'up', {'alt', 'shift'})

  hyperBind(
    {}, 'space',
    {'cmd', 'ctrl', 'alt', 'shift'}, 'space' 
  )


  hotkeyBind(
    {'shift', 'alt'}, 'j', 
    {'shift', 'alt'}, 'left'
  )

  hotkeyBind(
    {'shift', 'cmd'}, 'j', 
    {'shift', 'cmd'}, 'left'
  )

  hotkeyBind(
    {'shift', 'alt'}, 'l', 
    {'shift', 'alt'}, 'right'
  )

  hotkeyBind(
    {'shift', 'cmd'}, 'l', 
    {'shift', 'cmd'}, 'right'
  )

  hotkeyBind(
    {'alt'}, 'j',
    {'alt'}, 'left'
  )

  hotkeyBind(
    {'alt'}, 'l',
    {'alt'}, 'right'
  )

  -- hotkeyBind(
  --   {'alt'}, 'i',
  --   {'alt'}, 'up'
  -- )

  -- hotkeyBind(
  --   {'alt'}, 'k',
  --   {'alt'}, 'down'
  -- )
  
end

function hotkeyBind(fromModifier, fromKey, toModifier, toKey)
  hs.hotkey.bind(fromModifier, fromKey, function() arrowKey(toKey, toModifier) end, nil, function() arrowKey(toKey, toModifier) end)
end

function hyperBind(fromModifier, fromKey, toModifier, toKey)
  hyper:bind(fromModifier, fromKey, function() arrowKey(toKey, toModifier) end, nil, function() arrowKey(toKey, toModifier) end)
end


-- App bindings
function setUpAppBindings()
  hyperFocusOrOpen('a', 'Finder')
  hyperFocusOrOpen('d', 'iTerm2')
  hyperFocus('f', 'Google Chrome', 'Brave Browser')
  hyperFocusOrOpen('c', 'Visual Studio Code')
end

setUpAppBindings()
setupKeys()
