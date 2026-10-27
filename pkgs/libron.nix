{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation {
  pname = "libron";
  version = "latest";

  src = fetchzip {
    url = "https://github.com/nicoverbruggen/libron/releases/latest/download/Libron_H.zip";
    stripRoot = false;
    hash = "sha256-nFFJsGLqFW3EQexDBdQUbzYZsHQf1zjiYsZNAP7XRos=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 Libron_H-Regular.ttf \
      $out/share/fonts/truetype/Libron/Libron_H-Regular.ttf
    install -Dm644 Libron_H-Bold.ttf \
      $out/share/fonts/truetype/Libron/Libron_H-Bold.ttf
    install -Dm644 Libron_H-Italic.ttf \
      $out/share/fonts/truetype/Libron/Libron_H-Italic.ttf
    install -Dm644 Libron_H-BoldItalic.ttf \
      $out/share/fonts/truetype/Libron/Libron_H-BoldItalic.ttf

    runHook postInstall
  '';

  meta = {
    description = "Libron hinted TrueType fonts";
    homepage = "https://github.com/nicoverbruggen/libron";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
}
