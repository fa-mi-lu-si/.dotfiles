# Abbreviations
# https://github.com/nushell/nushell/issues/5597

let abbreviations = {
    's': 'sudo'
    'ho': 'handlr open'
    'hf': 'hx ...(fzf -m | lines)'
    'fh': 'hx ...(fzf -m | lines)'
    'h.': 'hx .'
    'cl': 'clear'
    'g': 'git'
    'gp': 'git push'
    'gu': 'git pull'
    'gl': 'serie'
    'ga': 'git add'
    'ga.': 'git add .'
    'gad': 'git add .'
    'gap': 'git add --patch'
    'gaa': 'git add -A'
    'gc': 'git commit'
    'gcm': 'git commit -m ""'
    'gcam': 'git commit -a -m ""'
    'gco': 'git checkout'
    'gs': 'git status -s'
    'gss': 'git status'
    'gsw': 'git switch'
    'gd': 'git diff'
    'mp': 'mpremote'
    'ard': 'arduino-cli'
    'cr': 'cargo run'
    'nr': 'nix run nixpkgs#'
    'ns': 'nix shell nixpkgs#'
}

$env.config.show_banner = false
$env.config.filesize.unit = 'metric'
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true
$env.config.use_kitty_protocol = true
$env.config.cursor_shape.emacs = "blink_line"
$env.config.shell_integration = {
  osc2: true
  osc7: true
  osc8: true
  # osc9_9: true
  osc133: true
  osc633: true
  reset_application_mode: true
}
$env.config.rm.always_trash = true


$env.config.keybindings = [
  {
    name: resume
    modifier: control
    keycode: char_z
    mode: emacs
    event: {
      send:executehostcommand
      cmd:"job unfreeze"
    }
  }
  {
    name: exit
    modifier: control
    keycode: char_w
    mode: emacs
    event: {send: CtrlD}
  }
  {
    name: help
    modifier: control
    keycode: char_h
    mode: emacs
    event: { edit: InsertString value: '--help'}
  }
  {
    name: yazi_f9
    modifier: None
    keycode: f9
    mode: emacs
    event: {
      send: executehostcommand
      cmd: "yy"
    }
  }
  {
    name: abbr_menu
    modifier: None
    keycode: enter
    mode: [emacs, vi_normal, vi_insert]
    event: [
      { send: menu name: abbr_menu }
      { send: enter }
    ]
  }
  {
    name: abbr_menu
    modifier: None
    keycode: space
    mode: [emacs, vi_normal, vi_insert]
    event: [
      { send: menu name: abbr_menu }
      { edit: insertchar value: ' '}
    ]
  }
]


$env.config.menus = [
  {
    name: abbr_menu
    only_buffer_difference: false
    marker: none
    type: {
      layout: columnar
      columns: 1
      col_width: 20
      col_padding: 2
    }
    style: {
      text: green
      selected_text: green_reverse
      description_text: yellow
    }
    source: { |buffer, position|
      let matches = $abbreviations | columns | where $it == $buffer
      if ($matches | is-empty) {
        { value: $buffer }
      } else {
        { value: ($abbreviations | get $matches.0) }
      }
    }
  }
]

$env.TRANSIENT_PROMPT_COMMAND = {||
  match $env.LAST_EXIT_CODE {
    0 => $"(ansi green)❯(ansi reset) ",
    _ => $"(ansi red)❯(ansi reset) "
  }
}
