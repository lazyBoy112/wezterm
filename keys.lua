local action = require 'wezterm'.action
local wezterm = require 'wezterm'

return {
  {
    key = 'p',
    mods = 'CTRL|SHIFT',
    action = action.ActivateCommandPalette
  },
  {
    key = 'F11',
    mods = '',
    action = action.ToggleFullScreen
  },
  {
    key = 'q',
    mods = 'CTRL|SHIFT',
    action = action.QuitApplication
  },
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
  action = action.CopyTo 'ClipboardAndPrimarySelection',
  },
  {
    key = 'b',
    mods = 'CTRL|SHIFT',
    action = action.ScrollByLine(-5)
  },
  {
    key = 'f',
    mods = 'CTRL|SHIFT',
    action = action.ScrollByLine(5)
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = action.RotatePanes 'CounterClockwise'
  },
  {
    key = 's',
    mods = 'CTRL|SHIFT',
    action = action.PaneSelect { alphabet='1234567890'}
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
  action = action.PasteFrom 'Clipboard',
  },
  {
    key = '-',
    mods = 'CTRL',
  action = action.DecreaseFontSize
  },
  {
    key = '=',
    mods = 'CTRL',
  action = action.IncreaseFontSize
  },
  {
    key = 'u',
    mods = 'CTRL|SHIFT',
    action = action.SplitHorizontal { domain='CurrentPaneDomain' }
  },
  {
    key = 'i',
    mods = 'CTRL|SHIFT',
    action = action.SplitVertical { domain='CurrentPaneDomain' }
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = action.CloseCurrentPane { confirm = true }
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = action.ActivatePaneDirection 'Left'
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = action.ActivatePaneDirection 'Right'
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = action.ActivatePaneDirection 'Down'
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = action.ActivatePaneDirection 'Up'
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = action.AdjustPaneSize { 'Left', 5 }
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = action.AdjustPaneSize { 'Right', 5 }
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = action.AdjustPaneSize { 'Up', 5 }
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = action.AdjustPaneSize { 'Down', 5 }
  },
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = action.SpawnTab 'CurrentPaneDomain'
  },
  {
    key = 'Tab',
    mods = 'CTRL|SHIFT',
    action = action.ActivateTabRelative(-1)
  },
  {
    key = 'Tab',
    mods = 'CTRL',
    action = action.ActivateTabRelative(1)
  },
  {
    key = 'F1',
    mods = '',
    action = action.TogglePaneZoomState
  },
  {
    key = 'R',
    mods = 'CTRL|SHIFT',
    action = action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}
