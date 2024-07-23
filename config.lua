local M = {}
M.options = {
  window_background_opacity = 0.95,
  status_update_interval = 1000,
  disable_default_key_bindings = true,
  -- default_prog = { 'powershell.exe', '-NoLogo' },
  -- default_prog = { 'pwsh' },
  force_reverse_video_cursor = true,
  bold_brightens_ansi_colors = 'BrightAndBold',
   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = true,
   use_fancy_tab_bar = false,
   tab_bar_at_bottom = true,
   tab_max_width = 20,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   -- cursor
   default_cursor_style = "BlinkingBlock",
   cursor_blink_ease_in = "Constant",
   cursor_blink_ease_out = "Constant",
   cursor_blink_rate = 500,
   -- cursor_blink_rate_rapid = 250,

   -- skip confirmation
   skip_close_confirmation_for_processes_named = {
     'bash',
     'sh',
     'zsh',
     'fish',
     'tmux',
     'nu',
     'cmd.exe',
     'pwsh.exe',
     'powershell.exe',
   },

   -- window
   window_decorations = 'RESIZE',
   -- window_decorations = "INTEGRATED_BUTTONS|RESIZE",
   -- integrated_title_button_style = "Windows", -- Windows, Gnome
   -- integrated_title_button_color = "auto",
   -- integrated_title_button_alignment = "Right",
   initial_cols = 80,
   initial_rows = 20,
   window_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
   },
   font = require 'wezterm'.font('FiraCode Nerd Font', {weight='Medium', stretch='Normal'}),
   adjust_window_size_when_changing_font_size = false,
   font_size = 14,
    freetype_load_target = 'Normal', -- 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   -- window_close_confirmation = 'AlwaysPrompt',
   window_frame = {
      active_titlebar_bg = '#090909',
      font = require 'wezterm'.font('FiraCode Nerd Font'),
      -- font_size = fonts.font_size,
   },
   inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
}

local mColor = require 'base'.color
M.colors = {
  foreground = mColor.l_white,
  background = mColor.black,
  tab_bar = {
    background  = mColor.black,
    new_tab = {
      bg_color = mColor.black,
      fg_color = mColor.yellow
    },
    new_tab_hover = {
      bg_color = mColor.yellow,
      fg_color = mColor.black
    },
  },
}

return M
