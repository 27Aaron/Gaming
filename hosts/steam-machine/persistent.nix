{
  preservation = {
    enable = true;
    preserveAt."/persistent" = {
      commonMountOptions = [
        "x-gvfs-hide"
        "x-gdu.hide"
      ];
      directories = [
        "/etc/NetworkManager/system-connections"

        "/var/log"
        "/var/lib/systemd"
        "/var/lib/NetworkManager"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
        {
          directory = "/var/lib/machines";
          mode = "0700";
        }
        {
          directory = "/var/lib/private";
          mode = "0700";
        }
      ];
      files = [
        # auto-generated machine ID
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      users.aaron = {
        directories = [
          # XDG Directories
          "Desktop"
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Templates"
          "Videos"

          ".ssh"

          ".cache/mesa_shader_cache"
          ".cache/radv_builtin_shaders"
          ".cache/ibus"
          ".cache/nix"
          ".cache/fontconfig"

          ".config/gtk-3.0"
          ".config/ibus"
          ".config/pulse"
          ".config/gamescope"

          ".local/share/Steam"
          ".local/share/kactivitymanagerd"
          ".local/share/baloo"
          ".local/share/klipper"
          ".local/share/krdpserver"
          ".local/share/kwalletd"
        ];
      };
    };
  };

  # systemd-machine-id-commit.service would fail, but it is not relevant
  # in this specific setup for a persistent machine-id so we disable it
  #
  # see the firstboot example below for an alternative approach
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

  # let the service commit the transient ID to the persistent volume
  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathIsMountPoint = [
      ""
      "/persistent/etc/machine-id"
    ];
    serviceConfig.ExecStart = [
      ""
      "systemd-machine-id-setup --commit --root /persistent"
    ];
  };
}
