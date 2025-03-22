local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.default_prog = { 'nu' }
config.enable_kitty_keyboard = true

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.default_cursor_style = 'BlinkingBar'
config.warn_about_missing_glyphs = false

-- config.visual_bell = {
--   fade_in_function = 'EaseIn',
--   fade_in_duration_ms = 150,
--   fade_out_function = 'EaseOut',
--   fade_out_duration_ms = 150,
-- }
config.audible_bell = "SystemBeep"

config.quick_select_alphabet = "tnseriaoq;wyfupl"

config.disable_default_key_bindings = true
config.keys = {
  { key = 'T',          mods = 'CTRL|SHIFT',       action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'W',          mods = 'CTRL|SHIFT',       action = act.CloseCurrentTab { confirm = true } },
  { key = 'w',          mods = 'CTRL|SUPER',       action = act.CloseCurrentPane { confirm = true } },
  { key = 'R',          mods = 'CTRL|SHIFT',       action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, }, },

  { key = 'PageDown',   mods = 'CTRL|SUPER',       action = act.ActivateTabRelative(1), },
  { key = 'PageUp',     mods = 'CTRL|SUPER',       action = act.ActivateTabRelative(-1), },
  { key = 'PageDown',   mods = 'SUPER|CTRL|SHIFT', action = act.MoveTabRelative(1), },
  { key = 'PageUp',     mods = 'SUPER|CTRL|SHIFT', action = act.MoveTabRelative(-1), },
  { key = 'RightArrow', mods = 'SUPER|CTRL',       action = act.ActivatePaneDirection 'Right' },
  { key = 'LeftArrow',  mods = 'SUPER|CTRL',       action = act.ActivatePaneDirection 'Left' },
  { key = 'UpArrow',    mods = 'SUPER|CTRL',       action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'SUPER|CTRL',       action = act.ActivatePaneDirection 'Down' },
  { key = 'Tab',        mods = 'SUPER|CTRL',       action = act.PaneSelect },
  { key = 'Tab',        mods = 'SUPER|CTRL|SHIFT', action = act.PaneSelect { mode = "SwapWithActiveKeepFocus" } },
  { key = 'RightArrow', mods = 'SUPER|CTRL|SHIFT', action = act.SplitPane { direction = 'Right' } },
  { key = 'LeftArrow',  mods = 'SUPER|CTRL|SHIFT', action = act.SplitPane { direction = 'Left' } },
  { key = 'UpArrow',    mods = 'SUPER|CTRL|SHIFT', action = act.SplitPane { direction = 'Up' } },
  { key = 'DownArrow',  mods = 'SUPER|CTRL|SHIFT', action = act.SplitPane { direction = 'Down' } },

  { key = 'UpArrow',    mods = 'ALT|CTRL|SHIFT',   action = act.ScrollToPrompt(-1) },
  { key = 'DownArrow',  mods = 'ALT|CTRL|SHIFT',   action = act.ScrollToPrompt(1) },

  { key = 'F11',        mods = 'CTRL|SHIFT',       action = act.ToggleFullScreen },

  { key = 'Copy',       mods = 'NONE',             action = act.CopyTo 'Clipboard' },
  { key = 'Paste',      mods = 'NONE',             action = act.PasteFrom 'Clipboard' },
  { key = 'C',          mods = 'CTRL|SHIFT',       action = act.CopyTo 'Clipboard' },
  { key = 'V',          mods = 'CTRL|SHIFT',       action = act.PasteFrom 'Clipboard' },

  { key = ')',          mods = 'CTRL',             action = act.ResetFontSize },
  { key = ')',          mods = 'SHIFT|CTRL',       action = act.ResetFontSize },
  { key = '+',          mods = 'CTRL',             action = act.IncreaseFontSize },
  { key = '+',          mods = 'SHIFT|CTRL',       action = act.IncreaseFontSize },
  { key = '-',          mods = 'CTRL',             action = act.DecreaseFontSize },
  { key = '-',          mods = 'SHIFT|CTRL',       action = act.DecreaseFontSize },
  { key = '0',          mods = 'CTRL',             action = act.ResetFontSize },
  { key = '0',          mods = 'SHIFT|CTRL',       action = act.ResetFontSize },
  { key = '=',          mods = 'CTRL',             action = act.IncreaseFontSize },
  { key = '=',          mods = 'SHIFT|CTRL',       action = act.IncreaseFontSize },
  { key = '_',          mods = 'CTRL',             action = act.DecreaseFontSize },
  { key = '_',          mods = 'SHIFT|CTRL',       action = act.DecreaseFontSize },

  { key = 'F',          mods = 'CTRL|SHIFT',       action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'L',          mods = 'CTRL|SHIFT',       action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'I',          mods = 'CTRL|SHIFT',       action = act.ShowDebugOverlay },
  { key = 'E',          mods = 'CTRL|SHIFT',       action = act.ActivateCommandPalette },
  { key = 'X',          mods = 'CTRL|SHIFT',       action = act.ActivateCopyMode },
  { key = 'u',          mods = 'CTRL|SUPER',       action = act.TogglePaneZoomState },
  { key = 'F5',         mods = 'CTRL|SHIFT',       action = act.ReloadConfiguration },
  { key = 'Space',      mods = 'CTRL|SHIFT',       action = act.QuickSelect },
}

config.key_tables = {
  resize_pane = {
    { key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'UpArrow',    action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'DownArrow',  action = act.AdjustPaneSize { 'Down', 1 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape',     action = 'PopKeyTable' },
    { key = 'phys:Space', action = 'PopKeyTable' },
    { key = 'Enter',      action = 'PopKeyTable' },
  },
}

return config
