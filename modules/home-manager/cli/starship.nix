{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "\${env_var.YAZI_LEVEL}"
        "$directory"
        "$python"
        "$rust"
        "$nix_shell"

        "$fill"

        "\${custom.git_host}"
        "$git_branch$git_commit"
        "$git_state$git_status"
        # "\${custom.git_last_commit}"
        "$package"

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
      fill.symbol = " ";
      line_break.disabled = false;
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
        before_repo_root_style = "bold cyan";
        repo_root_style = "bold cyan";
        repo_root_format = "[ $repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        read_only = " ";

        # fish_style_pwd_dir_length = 2; # not compatible with substitutions

        substitutions = {
          "~/Documents" = "󰈙 ";
          "~/Downloads" = " ";
          "~/Vault" = "󰠮 ";
          "~/Desktop" = "󰇄 ";
          "~/Music" = "󰝚 ";
          "~/Pictures" = " ";
          "~/Projects" = " ";
          "~/Videos" = " ";
          "~/.config" = ".󰒓 ";
          "~/.dotfiles" = ". ";
        };
      };

      git_branch = {
        symbol = "";
        format = "[$symbol $branch]($style) ";
      };
      git_status = {
        format = "[($conflicted$untracked$modified$staged$renamed$deleted)($ahead_behind$stashed)]($style)";
        ahead = "⇡$count ";
        behind = "[⇣$count](red)";
        conflicted = "🏳";
        deleted = "󰗨 $count ";
        diverged = "⇕⇡$ahead_count [⇣$behind_count](red) ";
        modified = " $count ";
        renamed = "󰾵 ";
        staged = "[++$count](green) ";
        stashed = " $count ";
        untracked = "[ $count](sapphire) ";
        style = "red";
        up_to_date = "";
      };
      git_state.format = "\([$state( $progress_current/$progress_total)]($style)\) ";

      # TODO: add other languages, lua, arduino, cpp
      python = {
        symbol = " ";
        format = "[$symbol$virtualenv]($style)";
      };
      rust = {
        format = "via [$symbol]($style)";
      };
      nix_shell = {
        symbol = " ";
        heuristic = false;
        impure_msg = "~ ";
        pure_msg = "󰡱 ";
        format = "[$symbol$state]($style) ";
      };

      env_var.YAZI_LEVEL = {
        description = "Display for yazi shell";
        format = "[󰇥 ]($style)";
        style = "yellow bold";
      };

      custom = {
        git_host = {
          description = "Display symbol for remote Git server";
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
            else
                GIT_REMOTE_SYMBOL=" "
            fi

            echo "$GIT_REMOTE_SYMBOL"
            IFS=""
          '';
          when = "git rev-parse --is-inside-work-tree 2> /dev/null";
          directories = [".git"];
        };

        git_last_commit = {
          description = "Show time since last commit";
          shell = ["sh" "--norc" "--noprofile"];
          format = "[ $output]($style) ";
          style = "yellow bold";
          command = ''
            git log --pretty=format:'%cr' -1
          '';
          when = "git rev-parse --is-inside-work-tree 2> /dev/null";
          directories = [".git"];
        };
      };
    };
  };
}
