.POSIX:

.DEFAULT:
	laptop


laptop:
	nixos-rebuild switch --flake .#laptop

laptop-build:
	nix build .#nixosConfigurations.laptop.config.system.build.toplevel

check:
	nix flake check

version-changes:
	#Source: https://www.reddit.com/r/NixOS/comments/r0o829/is_there_a_way_to_fetch_changelogs_from_each/hlvmrs9/?utm_source=reddit&utm_medium=web2x&context=3
	nix build .#laptop
	nix store diff-closures /var/run/current-system ./result

update-packages:
	nix flake update --override-input customPkgs ./packages/plugins/vim

collect-garbage:
	nix-collect-garbage --delete-old
