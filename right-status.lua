local wezterm = require('wezterm')
local M = {}
local mColor = require 'base'.color
local s_left = ""

M.separator_char = ' '

M.colors = {
   date_fg = '#c0ff28',
   date_bg = '#181825',
   battery_fg = '#c0ff28',
   battery_bg = '#181825',
   separator_fg = '#dccb00',
   separator_bg = '#181825',
}

M.cells = {} -- wezterm FormatItems (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)

local function executeCommand(command)
  local handle = io.popen(command)
  if handle ~= nil then
    local result = handle:read("*a")
    handle:close()
    return result
  end
  return ''
end

local get_memory = function()
  local cmd1 = executeCommand('wmic ComputerSystem get TotalPhysicalMemory /value')
  local cmd2 = executeCommand('wmic OS get FreePhysicalMemory /value')
  if not cmd1 or not cmd2 then
    return 'hello'
  end
  local total = cmd1:match('TotalPhysicalMemory=(%d+)')
  local free = cmd2:match('FreePhysicalMemory=(%d+)')
  total = tonumber(total)
  total = total /1024 /1024
  free = tonumber(free)
  free = free /1024
  return string.format('%.1f', 100 - free*100/total)
end

---@param text string
---@param icon string
---@param fg string
---@param bg string
---@param separate boolean
M.push = function(text, icon, fg, bg)
   table.insert(M.cells, { Foreground = { Color = fg } })
   table.insert(M.cells, { Background = { Color = bg } })
   table.insert(M.cells, { Attribute = { Intensity = 'Bold' } })
   table.insert(M.cells, { Text = icon..text  })

   table.insert(M.cells, 'ResetAttributes')
end

M.setup = function()
   wezterm.on('update-right-status', function(window, _pane)
    M.cells = {}
    local str = _pane:get_current_working_dir()
    str = string.sub(str, 9, string.len(str))
    M.push('', s_left, mColor.blue, mColor.black)
    -- M.push(str, '', mColor.black, mColor.blue)
    M.push('lazyBoy112', '', mColor.black, mColor.blue)

    window:set_right_status(wezterm.format(M.cells))
   end)
end

return M
