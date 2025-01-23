{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Oluwaseun Samuel Familusi";
    userEmail = "56502184+fa-mi-lu-si@users.noreply.github.com";
    difftastic = {
      enable = true;
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
