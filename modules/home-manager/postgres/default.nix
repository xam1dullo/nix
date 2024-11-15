{ pkgs, config, makeEnable, realUsers, ... }:
makeEnable config "myModules.postgres" true {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    ensureDatabases = [ "railbird" "public" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  CIDR-ADDRESS auth-method
      local all       all                  trust
      host  all       all     0.0.0.0/0    trust
      host  all       all     ::1/128      trust
    '';
    ensureUsers = map
      (username: {
        name = username;
        ensureClauses = {
          superuser = true;
          createrole = true;
          createdb = true;
        };
      })
      realUsers;
    # initialScript = pkgs.writeText "init-sql-script" ''
    #   CREATE DATABASE IF NOT EXISTS railbird;
    #   \c railbird
    #   CREATE SCHEMA IF NOT EXISTS railbird;
    # '';
  };
  services.pgadmin = {
    enable = false;
    initialEmail = "khkhamidullo@gmail.com";
    initialPasswordFile = (builtins.toFile "qwer12345" "This is the content of the file.");
  };
}
