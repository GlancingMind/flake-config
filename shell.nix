{ mkShellNoCC, git, gnumake }:

mkShellNoCC {
  name = "system-setup-shell";

  buildInputs = [
    git # required by flake
    gnumake
  ];
}
