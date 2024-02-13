local wezterm = require 'wezterm'
local mColor = require 'base'.color
local s_left = " "  -- , , , , 
local s_right = "" -- , , , , 
local fg_bar_active = mColor.green
local bg_bar_active = mColor.black
local fg_s_active = mColor.black
local bg_s_active = mColor.green
local fg_bar_inactive = mColor.black
local bg_bar_inactive = mColor.white
local fg_s_inactive = mColor.black
local bg_s_inactive = mColor.black
local fg_bar_hover = mColor.l_black
local bg_bar_hover = mColor.white
local fg_s_hover = mColor.black
local bg_s_hover = mColor.l_black
local M = {}
local get_dir = function(s)
  local rev = string.reverse(s)
  local i, j = rev.find(rev, '/')
  rev = string.sub(rev, j + 1, string.len(rev))
  i, j = rev.find(rev, '/')
  rev = string.sub(rev, 1, i-1)
  return string.reverse(rev)
end

M.set_process_name = function(s)
   local a = string.gsub(s, "(.*[/\\])(.*)", "%2")
   return a:gsub("%.exe$", "")
end

M.set_title = function(process_name, static_title, active_title, max_width)
   local title

   if process_name:len() > 0 and static_title:len() == 0 then
      title = process_name .. " ~ " .. " "
   elseif static_title:len() > 0 then
      title = static_title .. " ~ " .. " "
   else
      title = active_title .. " ㉿ " .. " "
   end

   if title:len() > max_width then
      local diff = title:len() - max_width
      title = wezterm.truncate_right(title, title:len() - diff)
   end

   return title
end

---@param fg string
---@param bg string
---@param attribute table
---@param text string
M.push = function(bg, fg, attribute, text)
   table.insert(M.cells, { Background = { Color = bg } })
   table.insert(M.cells, { Foreground = { Color = fg } })
   table.insert(M.cells, { Attribute = attribute })
   table.insert(M.cells, { Text = text })
end

M.setup = function()
   wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
      M.cells = {}

      local bg
      local fg
      local process_name = M.set_process_name(tab.active_pane.foreground_process_name)
      -- local title = M.set_title(process_name, tab.tab_title, tab.active_pane.title, max_width)
      local t = tab.active_pane.current_working_dir
      local title = M.set_title(get_dir(t), tab.tab_title, tab.active_pane.title, max_width)

      if tab.is_active then
        -- Separator left
        M.push(bg_s_active, fg_s_active, { Intensity='Bold' }, s_right)
        -- Title
        M.push(fg_bar_active, bg_bar_active, { Intensity='Bold' }, title)
        -- Separator right
        M.push(fg_s_active, bg_s_active, { Intensity='Bold' }, s_right)
      elseif hover then
        -- Separator left
        M.push(bg_s_hover, fg_s_hover, { Intensity='Bold' }, s_right)
        -- Title
        M.push(fg_bar_hover, bg_bar_hover, { Intensity='Bold' }, title)
        -- Separator right
        M.push(fg_s_hover, bg_s_hover, { Intensity='Bold' }, s_right)
      else
        -- Separator left
        M.push(fg_s_inactive, bg_s_inactive, { Intensity='Bold' }, s_left)
        -- Title
        M.push(fg_bar_inactive, bg_bar_inactive, { Intensity='Bold' }, title)
        -- Separator right
        M.push(fg_s_inactive, bg_s_inactive, { Intensity='Bold' }, s_right)
      end

      return M.cells
   end)
end



return M
