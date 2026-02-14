{
  preservation = {
    preserveAt."/persistent" = {
      users.aaron = {
        directories = [
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
}
