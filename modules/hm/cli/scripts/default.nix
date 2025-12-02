{pkgs, ...}: {
  home.packages = [
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
            kdeconnect-cli -d "$(kdeconnect-cli -a --id-only)" --share "$screenshot_path"
        else
            kdeconnect-cli -d "$(kdeconnect-cli -a --id-only)" --ping-msg "Screenshot timed out or was cancelled"
        fi
      '';
    })
  ];
}
