{ config, pkgs, lib, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    ensureDatabases = [ "b1_db" ];
    enableTCPIP = true;
    authentication = lib.mkOverride 10 ''
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
      CREATE DATABASE nixcloud;
      GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    '';
  };

  services.pgadmin = {
    enable = true;
    package = pkgs.pgadmin4; # Agar siz pgadmin4 versiyasini ishlatmoqchi bo'lsangiz
    initialEmail = "khkhamidullo@gmail.com";
    initialPasswordFile = "/var/lib/pgadmin/initial-password"; # Bu faylni yaratish kerak
    port = 5050; # Standart portni o'zgartirish (pgAdmin uchun)
    config = {
      # Agar kerak bo'lsa, qo'shimcha konfiguratsiyalar
      # Masalan, avtomatik ochilish uchun
      APP_CONFIG_DATA_DIR = "/var/lib/pgadmin";
    };
  };

  # pgAdmin uchun initial password faylini yaratish
  environment.etc."pgadmin/initial-password".text = ''
    qwer12345
  '';
}
