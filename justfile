default:
	@just --list

# Update a single flake input using a nice little tool created by vimjoyer
single-update:
	nix run github:gignsky/nix-update-input
