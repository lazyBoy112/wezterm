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

local function clean_process_name(proc)
   local a = string.gsub(proc, '(.*[/\\])(.*)', '%2')
   return a:gsub('%.exe$', '')
end

local function basename(path)
  local base = path:match("([^/\\]+)$")
  if (base == nil) then
    return '/'
  else
    return base
  end
end

--@param tab table đối tượng tab
--@return string chuỗi title
local tab_title = function(tab)
  local process_name = clean_process_name(tab.active_pane.foreground_process_name)
  local title = tab.tab_title
  if process_name:len() > 0 then
    title = process_name..' ~ '..basename(tab.active_pane.title)
  else
    title = tab.tab_title
  end
  return title
end

function M.setup()
  wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
      -- local cols = panes[1].width
      local max_w_tab = require'config'.options.tab_max_width - 4
      local title = tab_title(tab)
      title = string.gsub(title, '%.exe$', '')
      if title:len() > max_w_tab then
        title = title:sub(1, title:len() - (title:len() - max_w_tab))
      else
        title = title..string.rep(' ', max_w_tab - title:len())
      end
      local bar = {}
      local bg_bar = mColor.black
      local bg_active = mColor.green
      local fg_active = mColor.black
      local bg_inactive = mColor.l_black
      local fg_inactive = mColor.white
      print(title)

      if tab.is_active then
        bar = add_element(bar, bg_bar, bg_active, left_bar_icon, {Intensity="Normal"})
        bar = add_element(bar, bg_active, fg_active, ' '..title, {Intensity="Bold"})
        bar = add_element(bar, bg_bar, bg_active, right_bar_icon, {Intensity="Normal"})
      elseif hover then
        bar = add_element(bar, bg_bar, fg_inactive, left_bar_icon, {Intensity="Normal"})
        bar = add_element(bar, fg_inactive, bg_inactive, ' '..title..' ', {Intensity="Bold"})
        bar = add_element(bar, bg_bar, fg_inactive, right_bar_icon, {Intensity="Normal"})
      else
        bar = add_element(bar, bg_bar, bg_inactive, left_bar_icon, {Intensity="Normal"})
        bar = add_element(bar, bg_inactive, fg_inactive, ' '..title..' ', {Intensity="Normal"})
        bar = add_element(bar, bg_bar, bg_inactive, right_bar_icon, {Intensity="Normal"})
      end
      return bar
    end
  )
end

return M
