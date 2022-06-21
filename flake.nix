rec {
  description = "Template using specific versions";

  inputs.capacitor.url = "git+ssh://git@github.com/flox/capacitor?ref=master";
  inputs.capacitor.inputs.root.follows = "/";

  inputs.flox.url = "git+ssh://git@github.com/flox/floxpkgs?ref=master";
  inputs.flox.inputs.nixpkgs.follows = "capacitor/nixpkgs";

  nixConfig.bash-prompt = "[flox] \\[\\033[38;5;172m\\]λ \\[\\033[0m\\]";

  outputs = _:
    _.capacitor _ ({flox,auto,lib, ...}: {
      apps = flox.apps;
      legacyPackages = { pkgs, system, ...  }: {
        default = auto.automaticPkgsWith inputs ./pkgs pkgs;
        flox = flox.legacyPackages.${system}.flox;
      };

      templates = {
        default = {
          path = ./templates/default;
          description = "Example developer environment";
        };
      };
    });
}
