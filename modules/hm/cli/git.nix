{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Oluwaseun Samuel Familusi";
    userEmail = "56502184+fa-mi-lu-si@users.noreply.github.com";
    difftastic = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";

      help.autocorrect = "prompt";

      column.ui = "auto";

      branch.sort = "-committerdate";
      tag.sort = "version:refname";

      # diff = {
      #   algorithm = "histogram";
      #   colorMoved = "plain";
      #   mnemonicPrefix = true;
      #   renames = true;
      # };

      push.autoSetupRemote = true;
      push.followTags = true;

      fetch.prune = true;
      fetch.pruneTags = true;
      fetch.all = true;

      commit.verbose = true;

      interactive.singlekey = true;
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      prompt = "enabled";
    };
    extensions = with pkgs; [
      gh-eco
      gh-markdown-preview
    ];
  };

  programs.gh-dash = {
    enable = true;
  };
}
