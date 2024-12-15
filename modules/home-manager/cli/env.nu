match ($env | default $env.TERM TERM_PROGRAM | get TERM_PROGRAM) {
  WezTerm => {
    $env.EDITOR = "hx"
    $env.VISUAL = "hx"
  }
  xterm-kitty => {
    $env.EDITOR = "hx"
    $env.VISUAL = "hx"
  }
  vscode => {
    $env.EDITOR = "code -r"
    $env.VISUAL = "code -r"
  }
  _ => {
    $env.EDITOR = "hx"
    $env.VISUAL = "hx"
  }
}
