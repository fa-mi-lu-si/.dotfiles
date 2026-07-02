{...}: {
  programs.beets = {
    enable = true;
    mpdIntegration.enableUpdate = true;
    settings = {
      directory = "~/Music";
      library = "~/Music/beets.db";

      import = {
        move = true;
        write = true;
        autotag = true;
        log = "~/Music/beetslog.txt";
        from_scratch = true;
        duplicate_action = "merge";
        # incremental = true;
      };

      plugins = [
        "musicbrainz"
        "spotify"
        # "chroma"
        "scrub"
        "lyrics"
        "lastgenre"
        # "fetchart"
        # "embedart"
        "duplicates"
      ];

      # prefer musicbrains
      musicbrainz = {
        data_source_mismatch_penalty = 0.4;
      };

      spotify = {
        data_source_mismatch_penalty = 0.5;
      };

      lyrics = {
        sources = ["lrclib"];
        force = true;
        synced = true;
      };

      lastgenre = {
        force = true;
        keep_existing = true;
        count = 5;
        source = "track";
      };

      # fetchart = {
      #   minwidth = 300;
      #   maxwidth = 1200;
      # };

      match = {
        distance_weights = {
          missing_tracks = 0; # I have alot of partial albums
          tracks = 0.1; # Some had incorrect track numbers
        };
      };
    };
  };
}
