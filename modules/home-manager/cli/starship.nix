{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "\${env_var.YAZI_LEVEL}"
        "$directory"
        "$nix_shell"
        "$rust"
        "$lua"
        "\${custom.arduino}"
        "$python"

        "$fill"

        # "$package"
        "\${custom.git_host}"
        "$git_branch$git_commit"
        "$git_state$git_status"
        # "\${custom.git_last_commit}"

        "$line_break"

        "$username"
        "$hostname"
        "$character"
      ];

      right_format = lib.concatStrings [
        "$sudo"
        "$jobs"
        "$battery"
      ];

      battery.display = [
        {
          threshold = 30;
          discharging_symbol = "󰂃 ";
          charging_symbol = "󰂄 ";
        }
      ];

      sudo = {
        disabled = false;
        format = "[$symbol]($style)";
        symbol = "󱑷 ";
      };

      hostname = {
        ssh_symbol = "󰣀 ";
        format = "[$ssh_symbol$hostname]($style)";
        style = "yellow";
      };

      fill.symbol = " ";
      line_break.disabled = false;

      directory = {
        truncation_length = 2;
        # truncation_symbol = "…/";
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
        before_repo_root_style = "bold cyan";
        repo_root_style = "bold cyan";
        repo_root_format = "[ $repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        read_only = "  ";

        fish_style_pwd_dir_length = 2; # not compatible with substitutions

        # substitutions = {
        #   "~/Documents" = "󰈙 ";
        #   "~/Books" = " ";
        #   "~/Downloads" = " ";
        #   "~/Vault" = "󰠮 ";
        #   "~/Desktop" = "󰇄 ";
        #   "~/Music" = "󰝚 ";
        #   "~/Pictures" = " ";
        #   "~/Projects" = " ";
        #   "~/Videos" = " ";
        #   "~/.config" = ".󰒓 ";
        #   "~/.dotfiles" = ". ";
        # };
      };

      package = {
        format = "[$symbol$version]($style) ";
        style = "yellow";
      };

      git_branch = {
        symbol = " ";
        format = "[$symbol$branch]($style) ";
      };
      git_status = {
        format = "[($conflicted$untracked$modified$staged$renamed$deleted)($ahead_behind$stashed)]($style)";
        ahead = "󰄿 ";
        behind = "[󰄼](red) ";
        conflicted = "🏳 ";
        deleted = "[󰗨 $count](red) ";
        diverged = "⇕󰄿[󰄼](red) ";
        modified = "[ $count](red) ";
        renamed = "󰾵 ";
        staged = "[++$count](green) ";
        stashed = "󰏖 ";
        untracked = "[?$count](bold red) ";
        style = "";
        up_to_date = "";
      };
      git_state.format = "\([$state( $progress_current/$progress_total)]($style)\) ";

      python = {
        symbol = " ";
        format = "[$symbol$virtualenv]($style) ";
      };
      rust = {
        symbol = "󱘗 ";
        format = "[$symbol]($style) ";
      };
      lua = {
        symbol = "󰢱 ";
        format = "[$symbol]($style) ";
      };
      custom.arduino = {
        symbol = " ";
        format = "[$symbol]($style) ";
        detect_extensions = ["ino"];
        detect_files = ["sketch.yaml"];
        style = "blue";
      };
      nix_shell = {
        symbol = " ";
        heuristic = false;
        impure_msg = "~";
        pure_msg = "󰡱";
        format = "[$symbol$state]($style) ";
      };

      custom.mpremote = {
        description = "Connected Micropython Device";
        shell = ["sh" "--norc" "--noprofile"];
        format = "[$output]($style)";
        style = "";
        when = "mpremote --version";
        command = ''
          GREEN="\033[0;32m"
          RED="\033[0;31m"
          NC="\033[0m" # No Color
          if [ "$(mpremote connect list 2>/dev/null | grep -c "MicroPython")" -gt 0 ]; then
              echo -e "$GREEN  $NC" # Green connected symbol
          else
              echo -e "$RED  $NC" # Red disconnected symbol
          fi
        '';
      };

      custom.probe-rs = {
        description = "Connected Debug probe";
        shell = ["sh" "--norc" "--noprofile"];
        format = "[$output]($style)";
        style = "";
        when = "probe-rs --version";
        command = ''
          # ANSI color codes
          GREEN="\033[0;32m"
          RED="\033[0;31m"
          NC="\033[0m" # No Color
          if [[ $(probe-rs list) =~ \[0\]:\ (.+)\ --\  ]]; then
              echo -e "$GREEN  $NC"
          else
              echo -e "$RED  $NC"
          fi
        '';
      };

      env_var.YAZI_LEVEL = {
        description = "Display for yazi shell";
        format = "[󰇥 ]($style)";
        style = "yellow bold";
      };

      custom.git_host = {
        description = "Remote Git server";
        shell = ["sh" "--norc" "--noprofile"];
        format = "[$output]($style) ";
        style = "white bold";
        command = ''
          IFS="/"
          GIT_REMOTE=$(command git ls-remote --get-url 2> /dev/null)
          read -ra GIT_HOST <<< "$GIT_REMOTE"

          if [[ "$GIT_REMOTE" =~ "github" ]]; then
              GIT_REMOTE_SYMBOL=" "
          elif [[ "$GIT_REMOTE" =~ "gitlab" ]]; then
              GIT_REMOTE_SYMBOL=" "
          elif [[ "$GIT_REMOTE" =~ "bitbucket" ]]; then
              GIT_REMOTE_SYMBOL=" "
          elif [[ "$GIT_REMOTE" =~ "git" ]]; then
              GIT_REMOTE_SYMBOL=" "
          elif [[ "$GIT_REMOTE" =~ "codeberg" ]]; then
              GIT_REMOTE_SYMBOL=" "
          else
              GIT_REMOTE_SYMBOL=" "
          fi

          echo "$GIT_REMOTE_SYMBOL"
          IFS=""
        '';
        # when = "git rev-parse --is-inside-work-tree 2> /dev/null";
        require_repo = true;
        when = true;
        # directories = [".git"];
      };

      custom.git_last_commit = {
        description = "Time since last commit";
        shell = ["sh" "--norc" "--noprofile"];
        format = "[ $output]($style) ";
        style = "yellow bold";
        command = ''
          git log --pretty=format:'%cr' -1
        '';
        # when = "git rev-parse --is-inside-work-tree 2> /dev/null";
        require_repo = true;
        when = true;
        # directories = [".git"];
      };
    };
  };
}
