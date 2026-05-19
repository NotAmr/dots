{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.mySystem;
in {
  options.mySystem = {

    desktop.hyprland = {
      enable = mkEnableOption "Hyprland 0.55.2 (Wayland compositor)";
      luaConfig = mkOption {
        type = types.lines;
        default = "";
        description = "Lua configuration content (optional)";
      };
    };
    desktop.sddm.enable = mkEnableOption "SDDM display manager";
    desktop.hyprlock.enable = mkEnableOption "Hyprlock screen locker";
    desktop.waybar.enable = mkEnableOption "Waybar status bar";
    desktop.rofi.enable = mkEnableOption "Rofi launcher (Wayland)";
    desktop.swaync.enable = mkEnableOption "SwayNC notification center";
    desktop.theming.wallust.enable = mkEnableOption "Wallust colour generator";
    desktop.theming.swww.enable = mkEnableOption "SWWW animated wallpapers";
    desktop.theming.nwg-look.enable = mkEnableOption "nwg-look GTK theme tool";

    utilities.files.thunar.enable = mkEnableOption "Thunar file manager";
    utilities.files.yazi.enable = mkEnableOption "Yazi terminal file manager";
    utilities.files.recoll.enable = mkEnableOption "Recoll full-text search";
    utilities.files.localsend.enable = mkEnableOption "LocalSend LAN sharing";
    utilities.clipboard.wl-clipboard.enable = mkEnableOption "wl-clipboard tools";
    utilities.clipboard.hyprshot.enable = mkEnableOption "Hyprshot screenshot";
    utilities.clipboard.satty.enable = mkEnableOption "Satty screenshot annotation";
    utilities.monitoring.btop.enable = mkEnableOption "btop system monitor";
    utilities.monitoring.fastfetch.enable = mkEnableOption "fastfetch";

    terminal.kitty.enable = mkEnableOption "Kitty terminal";
    terminal.zsh.enable = mkEnableOption "Zsh shell";
    terminal.fzf.enable = mkEnableOption "fzf fuzzy finder";
    terminal.bat.enable = mkEnableOption "bat (syntax-highlighted cat)";

    editors.neovim.enable = mkEnableOption "Neovim editor";
    editors.vscodium.enable = mkEnableOption "VSCodium IDE";

    browser.zen-browser.enable = mkEnableOption "Zen browser";

    media.mpv.enable = mkEnableOption "mpv media player";
    media.obs-studio.enable = mkEnableOption "OBS Studio";

    input.fcitx5.enable = mkEnableOption "Fcitx5 IME (JP/CN/KR)";

    dev.c-cpp.compilers.llvm.enable = mkEnableOption "LLVM + Clang";
    dev.c-cpp.compilers.gcc.enable = mkEnableOption "GCC";
    dev.c-cpp.build.cmake.enable = mkEnableOption "CMake";
    dev.c-cpp.build.make.enable = mkEnableOption "GNU Make";
    dev.c-cpp.build.ninja.enable = mkEnableOption "Ninja";
    dev.c-cpp.debug.gdb.enable = mkEnableOption "GDB";
    dev.c-cpp.debug.lldb.enable = mkEnableOption "LLDB";
    dev.c-cpp.profile.heaptrack.enable = mkEnableOption "Heaptrack";
    dev.c-cpp.profile.gprofng.enable = mkEnableOption "gprofng";
    dev.c-cpp.analysis.valgrind.enable = mkEnableOption "Valgrind";
    dev.c-cpp.analysis.strace.enable = mkEnableOption "strace";
    dev.c-cpp.analysis.ltrace.enable = mkEnableOption "ltrace";
    dev.c-cpp.tooling.clang-tools-extra.enable = mkEnableOption "clang-tools (clangd, tidy, etc.)";
    dev.c-cpp.tooling.pkg-config.enable = mkEnableOption "pkg-config";

    dev.python.python.enable = mkEnableOption "Python interpreter";
    dev.python.cython.enable = mkEnableOption "Cython";
    dev.python.numpy.enable = mkEnableOption "NumPy";
    dev.python.pandas.enable = mkEnableOption "Pandas";
    dev.python.reportlab.enable = mkEnableOption "ReportLab";

    dev.flutter.flutter.enable = mkEnableOption "Flutter SDK";
    dev.flutter.dart.enable = mkEnableOption "Dart SDK";
    dev.flutter.openjdk.enable = mkEnableOption "OpenJDK (for Android)";
  };

  # ── System‑level activation (runs when toggles are true) ─────
  config = mkMerge [
    # --- Desktop environment ---
    (mkIf cfg.desktop.hyprland.enable {
      programs.hyprland.enable = true;
      # Lua config file and environment variable
      environment.etc."hypr/hyprland.lua".text =
        optionalString (cfg.desktop.hyprland.luaConfig != "") cfg.desktop.hyprland.luaConfig;
      environment.variables.HYPRLAND_CONFIG =
        if cfg.desktop.hyprland.luaConfig != "" then "/etc/hypr/hyprland.lua" else "";
    })

    (mkIf cfg.desktop.sddm.enable {
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;
    })

    (mkIf cfg.desktop.hyprlock.enable {
      programs.hyprlock.enable = true;
    })

    (mkIf cfg.desktop.waybar.enable {
      programs.waybar.enable = true;
    })

    (mkIf cfg.desktop.rofi.enable {
      programs.rofi.enable = true;
    })

    (mkIf cfg.desktop.swaync.enable {
      services.swaync.enable = true;
    })

    # --- Input method ---
    (mkIf cfg.input.fcitx5.enable {
      i18n.inputMethod.enabled = "fcitx5";
      i18n.inputMethod.fcitx5.addons = with pkgs; [
        fcitx5-mozc          # Japanese
        fcitx5-chinese-addons # Chinese
        fcitx5-hangul        # Korean
      ];
    })

    # --- Media (OBS Studio has its own system module) ---
    (mkIf cfg.media.obs-studio.enable {
      programs.obs-studio.enable = true;
    })
  ];
}
