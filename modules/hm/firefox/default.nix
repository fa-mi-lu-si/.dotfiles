{config, ...}: {
  programs.firefox = {
    enable = true;
    profiles."default" = {
      name = "samy";
      isDefault = true;
      settings = {
        # Mandatory
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;

        "ui.key.menuAccessKeyFocuses" = false; # Remove ALT menu

        # Performance
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.dmabuf.force-enabled" = true;

        # Disable useless things
        "browser.aboutConfig.showWarning" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.tabs.tabmanager.enabled" = false;
        "reader.parse-on-load.enabled" = false;
        "browser.translations.enable" = false;
        "identity.fxaccounts.enabled" = false;
        "browser.vpn_promo.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.tabs.allow_transparent_browser" = false;

        # Enable cool bahavior
        "browser.urlbar.trim" = true; # Trim https!
        "browser.startup.page" = 3; # Restore session
        "extensions.autoDisableScopes" = 0; # Auto-enable extesions
        "browser.tabs.loadBookmarksInTabs" = true; # Load bookmarks in newtabs
        "browser.search.openintab" = true; # Load search items in new tabs
      };
      # TODO: better spacing and proportions, floating url bar
      userChrome = with config.lib.stylix.colors.withHashtag;
        builtins.replaceStrings
        ["BASE00" "BASE01" "BASE02"]
        [base00 base01 base02]
        (builtins.readFile ./userChrome.css);
    };
  };
  stylix.targets.firefox.profileNames = ["default"];
}
