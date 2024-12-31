# Please refactor this file to move sections into separate files

def frontmatter [] {
  # Parse markdown into a record
  lines
  | split list '---'
  | do { |lst|
    let fm = $lst.0
    | to text | from yaml
    | into value
    | into record
    {
      frontmatter: $fm
      content: ($lst | skip 1 | to text | str trim)
    }
  } $in
}

# Abbreviations
# https://github.com/nushell/nushell/issues/5597

let abbreviations = {
    s: 'sudo'
    ho: 'handlr open'
    hf: 'hx ...(fzf -m | lines)'
    cl: 'clear'
    g: 'git'
    ga: 'git add'
    gc: 'git commit'
    gcm: 'git commit -m ""'
    gs: 'git status'
    gd: 'git diff'
}

$env.config.filesize.metric = true
$env.config.show_banner = false
$env.config.use_kitty_protocol = true
$env.config.shell_integration = {
  osc2: true
  osc7: true
  osc8: true
  # osc9_9: true
  osc133: true
  osc633: true
  reset_application_mode: true
}


# TODO: more robust handling of edge cases
let argc_completer = {|args|
    argc --argc-compgen nushell "" ...$args
        | split row "\n"
        | each { |line| $line | split column "\t" value description }
        | flatten 
}

# TODO: don't rely on imperative install, or wait for argc-completions to be packaged
$env.ARGC_COMPLETIONS_ROOT = '/home/samy/Projects/argc-completions'
$env.ARGC_COMPLETIONS_PATH = ($env.ARGC_COMPLETIONS_ROOT + '/completions/linux:' + $env.ARGC_COMPLETIONS_ROOT + '/completions')
$env.PATH = ($env.ARGC_COMPLETIONS_ROOT + '/bin:' + $env.PATH)

# let fish_completer = {|spans|
#   fish --command $'complete "--do-complete=($spans | str join " ")"'
#   | $"value(char tab)description(char newline)" + $in
#   | from tsv --flexible --no-infer
#   | each {|x| {value: $x.value, description: $"(ansi i)($x.description)(ansi reset)"}}
# }

let zoxide_completer = {|context|
  # Context includes the command as well. There are issues if there is a space in the command name, but I think most people use `z`.
  let search = (
    $context
    | str trim
    | split row ' ' | skip 1 | str join ' '
    | str trim
  )
  let ls_paths = (
    ls
    | where type ==  dir
    | get name
    | each {|x| $x | str trim}
    | each {|x| if ($x | str contains " ") {['"' $x '"'] | str join } else {$x}} # Wrap in quotes if the string contains spaces
    | each {|x| {value: $x, description: ''}}
  )
  # We want to avoid regex, and as I understand it, using `find -i` enables regex
  let ls_lower = ($ls_paths | each {|x| $x.value | str downcase})

  # Check if query exists, and if it does, add get zoxide results *only* if they don't exist within the current directory as well
  let z_paths = if ($search | str length) > 0 {
    (
      [] | append (
        zoxide query $search --list --exclude $env.PWD | str trim -r | split row -r '\n'
        | each {|x| {
          value: ($x | str downcase | split row (char psep) | last 1 | get 0), 
          description: (
            if ($x | str starts-with $env.HOME) {
              $"(ansi i)~($x | str substring ($env.HOME | str length)..)(ansi reset)"
            } else {
              $"(ansi i)$x(ansi reset)"
            }
          ),
        # This is slightly hacky, but `find` includes substrings, so ensuring length is the same makes sure we have exact match
        } } | where {|x| not ($ls_lower | find $x.value | any {|z| ($z | str length) == ($x.value | str length)}) }
      )
    )
  } else {
    []
  }
  # Remove duplicates, since with completions I don't think there's an easy way to 
  # add more context for zoxide
  mut true_z_paths = []
  for path in $z_paths {
    if not ($true_z_paths.value | find $path.value | any {|z| ($z | str length) == ($path.value | str length)}) {
      $true_z_paths = ($true_z_paths | append $path)
    } 
  }
  # Combine together, giving priority to zoxide
  $true_z_paths | append $ls_paths 
}


let external_completer = {|spans|
  let expanded_alias = scope aliases
  | where name == $spans.0
  | get -i 0.expansion

  let spans = if $expanded_alias != null {
    $spans
    | skip 1
    # | prepend ($expanded_alias | split row ' ' | take 1)
    | prepend ($expanded_alias | split row ' ')
  } else {
    $spans
  }

  match $spans.0 {
    # nu => $fish_completer
    # fish completes commits and branch names in a nicer way
    # git => $fish_completer
    # use zoxide completions for zoxide commands
    __zoxide_z | __zoxide_zi => $zoxide_completer
    # argc_completer by default
    _ => $argc_completer
  } | do $in $spans
}

$env.config.completions = {
  case_sensitive: false
  quick: true
  partial: true
  algorithm: "prefix"

  external: {
    enable: true
    max_results: 100
    completer: $external_completer
  }
}

$env.config.keybindings = [
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
    name: yazi
    modifier: control
    keycode: char_f
    mode: emacs
    event: {
      send: executehostcommand
      cmd: "yy"
    }
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
      # TODO
      # make this work in pipelines or wherever a command is expected
      # match against a substring
      let matches = $abbreviations | columns | where $it == $buffer
      if ($matches | is-empty) {
        { value: $buffer }
      } else {
        { value: ($abbreviations | get $matches.0) }
      }
    }
  }
]

# Transient prompt for starship
$env.TRANSIENT_PROMPT_COMMAND = {||
  (
    starship module
    --cmd-duration $env.CMD_DURATION_MS
    $"--status=($env.LAST_EXIT_CODE)"
    --terminal-width (term size).columns
    character
  )
}
