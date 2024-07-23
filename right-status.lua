local wezterm = require('wezterm')
local M = {}
local mColor = require 'base'.color
local s_left = ""

---@param cell table cell
---@param text string chuỗi hiển thị
---@param fg string màu chữ
---@param bg string màu nền
---@return table cell trả về
local add_element = function(cell, text, fg, bg)
  table.insert(cell, { Background = { Color = bg } })
  table.insert(cell, { Foreground = { Color = fg } })
  table.insert(cell, { Attribute = { Intensity = 'Bold' } })
  table.insert(cell, { Text = text  })
  return cell
end

M.setup = function()
  wezterm.on('update-right-status', function(window, pane)
    local cells = {}
    local cols = pane:get_dimensions().pixel_width/require'config'.options.font_size
    local max_size = math.floor(cols * 0.3)
    local bg_name  = mColor.l_red
    local fg_name  = mColor.black
    local bg_time  = mColor.l_red
    local fg_time  = mColor.black
    local bg_bar   = mColor.black


    if max_size > 10 then
      local date = wezterm.strftime '%H:%M'
      cells = add_element(cells, '', bg_time, bg_bar)
      cells = add_element(cells, '󰄉 '..date, fg_time, bg_time) -- 8
      -- cells = add_element(cells, '', bg_name, bg_time)
      -- cells = add_element(cells, 'lazyBoy112', fg_name, bg_name)
      cells = add_element(cells, ' 󰒲 ', fg_time, bg_time)

    else
      cells = {}
    end

    window:set_right_status(wezterm.format(cells))
   end)
end

return M
