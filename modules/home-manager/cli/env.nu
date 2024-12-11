match ($env | default $env.TERM TERM_PROGRAM | get TERM_PROGRAM) {
  WezTerm => {
    $env.EDITOR = "micro"
    $env.VISUAL = "micro"
  }
  vscode => {
    $env.EDITOR = "codium"
    $env.VISUAL = "codium"
  }
  _ => {
    $env.EDITOR = "micro"
    $env.VISUAL = "micro"
  }
}
