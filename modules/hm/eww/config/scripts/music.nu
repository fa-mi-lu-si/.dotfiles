export def info [] {
 def safe_playerctl [player: string, ...args] {
    try {
      playerctl -s -p $player ...$args
    } catch {
      ""
    }
  }

  let players = playerctl -l | lines

  $players
  | each {
    {
      name: $in
      title: (safe_playerctl $in metadata title)
      artist: (safe_playerctl $in metadata artist)
      artUrl: (safe_playerctl $in metadata mpris:artUrl)
      status: (safe_playerctl $in status)
    }
  }
  | to json
}

def main [] {
  (interleave
    {playerctl --all-players status --follow | lines -s}
    {playerctl --all-players metadata --follow | lines -s})
  | each {info}
}
