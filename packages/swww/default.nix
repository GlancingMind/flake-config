{ fetchFromGitHub, rustPlatform, pkg-config, lz4 , libxkbcommon, ... }:

rustPlatform.buildRustPackage rec {
  pname = "swww";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "Horus645";
    repo = pname;
    rev = "21eddb27d81184e3e3713f43505915c99ebd2a24";
    sha256 = "sha256-9qTKaLfVeZD8tli7gqGa6gr1a2ptQRj4sf1XSPORo1s=";
  };
  cargoSha256 = "sha256-OWe+r8Vh09yfMFBjVH66i+J6RtHo1nDva0m1dJPZ4rE=";
  buildInputs = [ lz4 libxkbcommon ];
  doCheck = false; # Integration tests do not work in sandbox enviroment
  nativeBuildInputs = [ pkg-config ];
}

