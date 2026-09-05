{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";
    services-flake.url = "github:juspay/services-flake";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    flake-parts,
    process-compose-flake,
    services-flake,
    ...
  }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        process-compose-flake.flakeModule
      ];

      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            ruby
            libyaml
            postgresql_16
          ];

          PGHOST = "127.0.0.1";
          PGPORT = "8286";
          DATABASE_URL = "postgresql://127.0.0.1:8286/tatracker_development";
          RAILS_ENV = "development";
        };

        process-compose.default = {
          imports = [
            services-flake.processComposeModules.default
          ];

          services.postgres."pg" = {
            enable = true;
            package = pkgs.postgresql_16;

            listen_addresses = "127.0.0.1";
            port = 8286;

            initialDatabases = [
              { name = "tatracker_development"; }
              { name = "tatracker_test"; }
            ];
          };

          settings.processes = {
            setup = {
              command = "bin/rails db:prepare";

              depends_on.pg.condition = "process_healthy";

              availability = {
                restart = "no";
              };
            };

            server = {
              command = "bin/rails server";

              depends_on.setup.condition = "process_completed_successfully";
            };
          };
        };

        packages.default = self.packages.${pkgs.system}.dev;

        packages.dev = process-compose-flake.lib.mkProcessCompose {
          inherit pkgs;
          modules = [
            self.process-compose.${pkgs.system}.default
          ];
        };
      };
    };
}