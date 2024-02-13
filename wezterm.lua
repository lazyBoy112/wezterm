local wezterm = require 'wezterm'

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

-- Setup
require 'right-status'.setup()
require 'bar'.setup()

-- Colors
config.colors = require 'config'.colors











return config
