local wezterm = require 'wezterm'
local base = require 'base'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Option
local options = require 'config'.options
for k, v in pairs(options) do
  config[k] = v
end

-- Keys
local keys = require 'keys'
config.keys = keys
config.mouse_bindings = {
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'CTRL|SHIFT',
    action = wezterm.action.StartWindowDrag,
  },
-- Disable the default click behavior
    {
      event = { Up = { streak = 1, button = "Left"} },
      mods = "NONE",
      action = wezterm.action.DisableDefaultAssignment, -- You may want a different option here. See /u/Brian's comment below
    },
    -- Ctrl-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
    -- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
    {
        event = { Down = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = wezterm.action.Nop,
    },
}

-- set default process
if require 'base'.platform().is_win then
  config.default_prog = { 'pwsh', '-NoLogo', '-ExecutionPolicy', 'RemoteSigned', '-NoProfileLoadTime'}
  config.launch_menu = {
    {
      label = base.prog_icon['pwsh.exe']..' PowerShell V7',
      args = { 'pwsh', '-NoLogo', '-ExecutionPolicy', '-RemoteSigned', '-NoProfileLoadTime' },
      cwd = '~',
    },
    {
      label = base.prog_icon['pwsh.exe']..' PowerShell V5',
      args = { 'powershell' },
      cwd = '~',
    },
    { label = 'Cmd', args = { 'cmd.exe' }, cwd = '~' },
    { label = base.prog_icon['git']..' Git bash', args = { 'sh', '-l' }, cwd = '~' },
  }
end


-- Setup
require 'right-status'.setup()
require 'bar'.setup()

-- Colors
config.colors = require 'config'.colors











return config
