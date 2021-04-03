.POSIX:

.DEFAULT:
	laptop

laptop:
	nixos-rebuild switch --flake .#laptop

laptop-build:
	nixFlakes build .#laptop

check:
	nixFlakes flake check

collect-garbage:
	nix-collect-garbage --delete-old
