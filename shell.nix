{ mkShellNoCC, git, gnumake, rnix-lsp }:

mkShellNoCC {
  name = "system-setup-shell";

  buildInputs = [
    git # required by flake
    gnumake
    rnix-lsp
  ];
}
