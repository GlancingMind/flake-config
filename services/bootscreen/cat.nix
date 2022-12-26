{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "PlymouthTheme-Cat";
  version = "6e7300145fed6b482ac48a5c05edebc404aeb289";

  src = fetchFromGitHub {
    owner = "krishnan793";
    repo = pname;
    rev = version;
    sha256 = "sha256-Eyims+CnMYgO+G8C6tiisj7orDwRf0liq01SuqKo6Bw=";
  };

  installPhase = let
    themeOutputPath = "$out/share/plymouth/themes/PlymouthTheme-Cat";
  in ''
    mkdir -p ${themeOutputPath}
    cp -r ./ ${themeOutputPath}
    cat PlymouthTheme-Cat.plymouth | sed  "s@\/usr\/@$out\/@" > ${themeOutputPath}/PlymouthTheme-Cat.plymouth
  '';
}
