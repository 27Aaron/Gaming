# List all available commands
list:
    @just --list

# Build and switch to current configuration
switch:
    @sudo nixos-rebuild --flake .# switch

# Check flake syntax
check:
    @nix flake check

# Update flake lock file
update:
    @nix flake update

# Garbage collect unused store paths
gc:
    @sudo nix store gc --debug
    @sudo nix-collect-garbage --delete-old

# View system profile history
history:
    @nix profile history --profile /nix/var/nix/profiles/system

# Clean profile history older than 3 days
clean:
    @sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
