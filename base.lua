local M = {}
local wezterm = require 'wezterm'

M.color = {
  none = 'none',

  black = '#001618',
  l_black = '#363062',

  red = '#bf616a',
  l_red = '#e06c75',

  green = '#a3be8c',
  l_green = '#b5bd68',

  yellow = '#ebcb8b',
  l_yellow = '#f0c674', -- 

  blue = '#81a2be',
  l_blue = '#88c0d0',

  magenta = '#b48ead',
  l_magenta = '#dc8cc3',

  cyan = '#3f868f',
  l_cyan = '#56b6c2',

  white = '#8fa1b3',
  l_white = '#c0c5ce',
}

function M.is_found(str, pattern)
   return string.find(str, pattern) ~= nil
end

function M.platform()
   return {
      is_win = M.is_found(wezterm.target_triple, 'windows'),
      is_linux = M.is_found(wezterm.target_triple, 'linux'),
      is_mac = M.is_found(wezterm.target_triple, 'apple'),
   }
end


return M
