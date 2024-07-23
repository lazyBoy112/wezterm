local M = {}
local wezterm = require 'wezterm'
local nf = wezterm.nerdfonts

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
  local is_win = require'wezterm'.target_triple:find "windows" ~= nil
  local is_linux = require'wezterm'.target_triple:find "linux" ~= nil
  local is_mac = require'wezterm'.target_triple:find "apple" ~= nil
  local os = is_win and "windows" or is_linux and "linux" or is_mac and "mac" or "unknown"
  return { os = os, is_win = is_win, is_linux = is_linux, is_mac = is_mac }
end

M.prog_icon = {
  ["C:\\WINDOWS\\system32\\cmd.exe"] = nf.md_console_line,
  ["Topgrade"] = nf.md_rocket_launch,
  ["bash"] = nf.cod_terminal_bash,
  ["btm"] = nf.md_chart_donut_variant,
  ["cargo"] = nf.dev_rust,
  ["curl"] = nf.mdi_flattr,
  ["docker"] = nf.linux_docker,
  ["docker-compose"] = nf.linux_docker,
  ["fish"] = nf.md_fish,
  ["gh"] = nf.dev_github_badge,
  ["git"] = nf.dev_git,
  ["go"] = nf.seti_go,
  ["htop"] = nf.md_chart_areaspline,
  ["btop"] = nf.md_chart_areaspline,
  ["kubectl"] = nf.linux_docker,
  ["kuberlr"] = nf.linux_docker,
  ["lazydocker"] = nf.linux_docker,
  ["lua"] = nf.seti_lua,
  ["python"] = nf.seti_python,
  ["perl"] = nf.seti_perl,
  ["make"] = nf.seti_makefile,
  ["node"] = nf.md_nodejs,
  ["nvim"] = nf.custom_neovim,
  ["pacman"] = "󰮯 ",
  ["paru"] = "󰮯 ",
  ["psql"] = nf.dev_postgresql,
  ["pwsh.exe"] = nf.md_console,
  ["ruby"] = nf.cod_ruby,
  ["sudo"] = nf.fa_hashtag,
  ["vim"] = nf.dev_vim,
  ["wget"] = nf.mdi_arrow_down_box,
  ["zsh"] = nf.dev_terminal,
  ["lazygit"] = nf.cod_github,
}

M.sep_icon = {
  block = "█",
  sb = {
    left = nf.pl_left_hard_divider,
    right = nf.pl_right_hard_divider,
    modal = nf.ple_forwardslash_separator,
  },
  tb = {
    leftmost = "▐",
    left = nf.ple_upper_right_triangle,
    right = nf.ple_lower_left_triangle,
  },
}

function M.basename(path)
  local trimmed_path = path:gsub("[/\\]*$", "")
  local index = trimmed_path:find "[^/\\]*$"
  return index and trimmed_path:sub(index) or trimmed_path
end


return M
