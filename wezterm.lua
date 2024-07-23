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
