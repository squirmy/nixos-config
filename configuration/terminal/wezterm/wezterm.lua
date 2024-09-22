-- Credit: theopn
-- https://github.com/theopn/dotfiles/blob/main/wezterm/wezterm.lua

local wezterm = require('wezterm')
local k = require('utils/keys')
local act = wezterm.action

local config = wezterm.config_builder()

-- Required until this issue is fixed: https://github.com/wez/wezterm/issues/5990
config.front_end = 'WebGpu'

config.color_scheme = 'Snazzy (Gogh)'

config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Medium' })
config.font_size = 13.0
config.line_height = 1.1

config.window_decorations = 'RESIZE'
config.window_close_confirmation = 'AlwaysPrompt'
config.scrollback_lines = 3000
config.default_workspace = 'main'

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5,
}

-- Keys
--config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  k.cmd_key('q', k.multiple_actions(':qa!')),

  k.cmd_to_tmux_prefix('1', '1'), -- switch to window by number
  k.cmd_to_tmux_prefix('2', '2'),
  k.cmd_to_tmux_prefix('3', '3'),
  k.cmd_to_tmux_prefix('4', '4'),
  k.cmd_to_tmux_prefix('5', '5'),
  k.cmd_to_tmux_prefix('6', '6'),
  k.cmd_to_tmux_prefix('7', '7'),
  k.cmd_to_tmux_prefix('8', '8'),
  k.cmd_to_tmux_prefix('9', '9'),
  k.cmd_to_tmux_prefix('`', 'n'), -- next window (doesn't seem to work)
  k.cmd_to_tmux_prefix('C', 'C'), -- customize options
  k.cmd_to_tmux_prefix('d', 'D'), -- detach from session
  k.cmd_to_tmux_prefix('l', 'L'), -- sesh (last session)
  k.cmd_to_tmux_prefix('k', 'K'), -- sesh connect
  k.cmd_to_tmux_prefix('n', '%'), -- split pane horizontal
  k.cmd_to_tmux_prefix('N', '"'), -- split pane vertical
  k.cmd_to_tmux_prefix('t', 'c'), -- new window
  k.cmd_to_tmux_prefix('w', 'x'), -- close pane / window
  k.cmd_to_tmux_prefix('z', 'z'), -- toggle pane zoom
  k.cmd_to_tmux_prefix('T', 'B'), -- break pane into new window
  k.cmd_ctrl_to_tmux_prefix('t', 'J'), -- join pane back to the window it broke out of

  k.cmd_key(
    'R',
    act.Multiple({
      act.SendKey({ key = '\x1b' }), -- escape
      k.multiple_actions(':source %'),
    })
  ),

  k.cmd_key(
    's',
    act.Multiple({
      act.SendKey({ key = '\x1b' }), -- escape
      k.multiple_actions(':w'),
    })
  ),

  {
    mods = 'CTRL',
    key = 'Tab',
    action = act.Multiple({
      act.SendKey({ mods = 'CTRL', key = 'b' }),
      act.SendKey({ key = 'n' }),
    }),
  },

  {
    mods = 'CTRL|SHIFT',
    key = 'Tab',
    action = act.Multiple({
      act.SendKey({ mods = 'CTRL', key = 'b' }),
      act.SendKey({ key = 'n' }),
    }),
  },

  {
    mods = 'CMD',
    key = '~',
    action = act.Multiple({
      act.SendKey({ mods = 'CTRL', key = 'b' }),
      act.SendKey({ key = 'p' }),
    }),
  },
}

-- Tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
config.enable_tab_bar = false
wezterm.on('update-status', function(window, pane)
  -- Workspace name
  local stat = window:active_workspace()
  local stat_color = '#f7768e'
  -- It's a little silly to have workspace name all the time
  -- Utilize this to display LDR or current key table name
  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = '#7dcfff'
  end
  if window:leader_is_active() then
    stat = 'LDR'
    stat_color = '#bb9af7'
  end

  local basename = function(s)
    -- Nothing a little regex can't fix
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
  end

  -- Current working directory
  local cwd = pane:get_current_working_dir()
  if cwd then
    cwd = basename(cwd.file_path)
  else
    cwd = ''
  end

  -- Current command
  local cmd = pane:get_foreground_process_name()
  -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
  cmd = cmd and basename(cmd) or ''

  -- Time
  local time = wezterm.strftime('%H:%M')

  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Foreground = { Color = stat_color } },
    { Text = '  ' },
    { Text = wezterm.nerdfonts.oct_table .. '  ' .. stat },
    { Text = ' |' },
  }))

  -- Right status
  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    { Text = wezterm.nerdfonts.md_folder .. '  ' .. cwd },
    { Text = ' | ' },
    { Foreground = { Color = '#e0af68' } },
    { Text = wezterm.nerdfonts.fa_code .. '  ' .. cmd },
    'ResetAttributes',
    { Text = ' | ' },
    { Text = wezterm.nerdfonts.md_clock .. '  ' .. time },
    { Text = '  ' },
  }))
end)

return config
