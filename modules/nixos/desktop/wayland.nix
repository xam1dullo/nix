{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  # Displey menejeri sifatida GDM (GNOME Display Manager) ni ishlatamiz
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
    nvidiaWayland = true;
  };

  # Grafik muhit sifatida GNOME ni yoqamiz
  services.xserver.desktopManager.gnome.enable = true;

}
