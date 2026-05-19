{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules/custom-options.nix
  ];

  # ── TOGGLE YOUR SOFTWARE HERE ──
  mySystem = {
    desktop.hyprland = {
      enable = true;
      # Example Lua config (leave empty for regular hyprland.conf)
      luaConfig = "";
    };
    desktop.sddm.enable = true;
    desktop.hyprlock.enable = true;
    desktop.waybar.enable = true;
    desktop.rofi.enable = true;
    desktop.swaync.enable = true;
    desktop.theming.wallust.enable = true;
    desktop.theming.swww.enable = true;
    desktop.theming.nwg-look.enable = true;

    utilities.files.thunar.enable = true;
    utilities.files.yazi.enable = true;
    utilities.files.recoll.enable = true;
    utilities.files.localsend.enable = true;
    utilities.clipboard.wl-clipboard.enable = true;
    utilities.clipboard.hyprshot.enable = true;
    utilities.clipboard.satty.enable = true;
    utilities.monitoring.btop.enable = true;
    utilities.monitoring.fastfetch.enable = true;

    terminal.kitty.enable = true;
    terminal.zsh.enable = true;
    terminal.fzf.enable = true;
    terminal.bat.enable = true;

    editors.neovim.enable = true;
    editors.vscodium.enable = true;

    browser.zen-browser.enable = true;

    media.mpv.enable = true;
    media.obs-studio.enable = true;

    input.fcitx5.enable = true;

    # Development tools (enable selectively as needed)
    dev.c-cpp.compilers.llvm.enable = true;
    dev.c-cpp.compilers.gcc.enable = true;
    dev.c-cpp.build.cmake.enable = true;
    dev.c-cpp.build.make.enable = true;
    dev.c-cpp.build.ninja.enable = true;
    dev.c-cpp.debug.gdb.enable = true;
    dev.c-cpp.debug.lldb.enable = true;
    dev.c-cpp.profile.heaptrack.enable = true;
    dev.c-cpp.profile.gprofng.enable = true;
    dev.c-cpp.analysis.valgrind.enable = true;
    dev.c-cpp.analysis.strace.enable = true;
    dev.c-cpp.analysis.ltrace.enable = true;
    dev.c-cpp.tooling.clang-tools-extra.enable = true;
    dev.c-cpp.tooling.pkg-config.enable = true;

    dev.python.python.enable = true;
    dev.python.cython.enable = true;
    dev.python.numpy.enable = true;
    dev.python.pandas.enable = true;
    dev.python.reportlab.enable = true;

    dev.flutter.flutter.enable = true;
    dev.flutter.dart.enable = true;
    dev.flutter.openjdk.enable = true;
  };

  # Other system settings (hostname, network, users, etc.)
  networking.hostName = "nixos";
  users.users.user = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "24.11";   # or your current stable version
}
