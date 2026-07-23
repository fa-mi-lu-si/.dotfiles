{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    (pkgs.writeScriptBin "timer"
      #nu
      ''
        #! /usr/bin/env nu

        def main [
          time: duration,
          --fullscreen(-f),
          --name(-n): string,
          --format: string = "24h"
        ] {
          ${lib.getExe pkgs.timer} ...(
            []
            | append (if $fullscreen { "--fullscreen" } else { [] })
            | append (if ($name | is-not-empty) { ["--name" $name] } else { [] })
            | append ["--format" $format]
            | append (($time / 1sec) | math round)
          )
          pw-play ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/complete.oga
        }
      '')

    (pkgs.writeShellApplication {
      name = "send-screenshot-kdeconnect";
      text = ''
        #!/bin/sh
        timestamp=$(date +%Y-%m-%d_%H-%M-%S)
        screenshot_path="$(mktemp --tmpdir niri_"$timestamp"_XXXX.png)"
        # trap 'rm -f "$screenshot_path"' EXIT
        echo "$screenshot_path"

        niri msg action screenshot --path "$screenshot_path"

        # Wait for the file to be created and have content
        timeout=150
        elapsed=0
        while [ ! -s "$screenshot_path" ] && [ $elapsed -lt $timeout ]; do
            sleep 0.1
            elapsed=$((elapsed + 1))
        done

        if [ -s "$screenshot_path" ]; then
            # TODO: rework this so the script takes the device id as an argument,
            # to correctly handle when we have multiple connected devices
            kdeconnect-cli -d "$(kdeconnect-cli -a --id-only)" --share "$screenshot_path"
        else
            kdeconnect-cli -d "$(kdeconnect-cli -a --id-only)" --ping-msg "Screenshot timed out or was cancelled"
        fi
      '';
    })
  ];
}
