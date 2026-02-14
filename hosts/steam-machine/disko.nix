{
  disko.devices = {
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "relatime"
          "nosuid"
          "nodev"
          "size=2G"
          "mode=755"
        ];
      };
    };
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              priority = 0;
              content = {
                type = "filesystem";
                extraArgs = [
                  "-n"
                  "BOOT"
                ];
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            windows = {
              size = "100G";
              type = "0700";
              priority = 1;
            };
            nixos = {
              size = "200G";
              priority = 2;
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                  "--label nixos"
                  "--csum xxhash64"
                  "--features"
                  "block-group-tree"
                ];
                subvolumes = {
                  "nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress-force=zstd"
                      "noatime"
                      "discard=async"
                      "space_cache=v2"
                      "nodev"
                      "nosuid"
                    ];
                  };
                  "persistent" = {
                    mountpoint = "/persistent";
                    mountOptions = [
                      "compress-force=zstd"
                      "noatime"
                      "discard=async"
                      "space_cache=v2"
                    ];
                  };
                  "persistent/tmp" = {
                    mountpoint = "/tmp";
                    mountOptions = [
                      "relatime"
                      "nodev"
                      "nosuid"
                      "discard=async"
                      "space_cache=v2"
                    ];
                  };
                };
              };
            };
            game = {
              size = "100%";
              priority = 3;
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                  "--label game"
                  "--csum xxhash64"
                  "--features"
                  "block-group-tree"
                ];
                mountpoint = "/persistent/home/aaron/Game";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
            };
          };
        };
      };
    };
  };
}
