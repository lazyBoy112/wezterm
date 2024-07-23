local wezterm = require 'wezterm'
local mColor = require'base'.color
local M = {}

-- , 
local left_bar_icon = ''
-- , 
local right_bar_icon = ''

---@param bar table đối tượng được thêm vào
---@param fg string màu chữ
---@param bg string màu nền
---@return table đối tượng trả về
local add_element = function(bar, bg, fg, title, att)
  table.insert(bar, { Background = { Color = bg } })
  table.insert(bar, { Foreground = { Color = fg } })
  table.insert(bar, { Attribute = att })
  table.insert(bar, { Text = title })
  return bar
end

--@param tab table đối tượng tab
--@return string chuỗi title
local tab_title = function(tab)
  local title = tab.tab_title
  if title and #title > 0 then
    return title
  end
  return tab.active_pane.title
end

function M.setup()
  wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
      -- local cols = panes[1].width
      local max_w_tab = require'config'.options.tab_max_width - 2
      local title = tab_title(tab)
      title = string.gsub(title, '%.exe$', '')
      if #title > max_w_tab then
        title = string.sub(title, 1, max_w_tab)
      end
      local bar = {}
      local bg_bar = mColor.black
      local bg_active = mColor.green
      local fg_active = mColor.black
      local bg_inactive = mColor.l_black
      local fg_inactive = mColor.white

      if tab.is_active then
        bar = add_element(bar, bg_bar, bg_active, left_bar_icon, {Intensity="Normal"})
        bar = add_element(bar, bg_active, fg_active, ' '..title, {Intensity="Bold"})
        bar = add_element(bar, bg_bar, bg_active, right_bar_icon, {Intensity="Normal"})
      elseif hover then
        bar = add_element(bar, bg_bar, fg_inactive, left_bar_icon, {Intensity="Normal"})
        bar = add_element(bar, fg_inactive, bg_inactive, ' '..title, {Intensity="Bold"})
        bar = add_element(bar, bg_bar, fg_inactive, right_bar_icon, {Intensity="Normal"})
      else
        bar = add_element(bar, bg_bar, bg_inactive, left_bar_icon, {Intensity="Normal"})
        bar = add_element(bar, bg_inactive, fg_inactive, ' '..title, {Intensity="Normal"})
        bar = add_element(bar, bg_bar, bg_inactive, right_bar_icon, {Intensity="Normal"})
      end
      return bar
    end
  )
end

return M
