.POSIX:

.DEFAULT:
	laptop


laptop:
	nixos-rebuild switch --flake .#laptop

laptop-build:
	nixFlakes build .#laptop

check:
	nixFlakes flake check

update-packages:
	nixflk flake update --override-input customPkgs ./packages/plugins/vim

collect-garbage:
	nix-collect-garbage --delete-old
