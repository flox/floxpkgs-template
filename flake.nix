rec {
  description = "Template using specific versions";

  inputs.capacitor.url = "git+ssh://git@github.com/flox/capacitor?ref=master";
  inputs.capacitor.inputs.root.follows = "/";

  inputs.flox.url = "git+ssh://git@github.com/flox/floxpkgs?ref=master";
  inputs.flox.inputs.capacitor.follows = "capacitor";
  inputs.flox.inputs.nixpkgs.follows = "capacitor/nixpkgs";

  nixConfig.bash-prompt = "[flox] \\[\\033[38;5;172m\\]λ \\[\\033[0m\\]";

  outputs = _:
    _.capacitor _ ({flox,auto,lib, ...}: {
      devShells.default = _.capacitor.lib.mkFloxShell _ ./flox.toml _.self.__pins;
      apps = flox.apps;
      legacyPackages = { pkgs,  ...  }: auto.automaticPkgsWith inputs ./pkgs pkgs;

      # AUTO-MANAGED AFTER THIS POINT ##################################
      # AUTO-MANAGED AFTER THIS POINT ##################################
      # AUTO-MANAGED AFTER THIS POINT ##################################
      __pins.versions = [
        (builtins.getFlake "github:NixOS/nixpkgs/43cc623340ac0723fb73c1bce244bb6d791c5bb9").legacyPackages.x86_64-linux.curl
        (builtins.getFlake "github:NixOS/nixpkgs/4d922730369d1c468cc4ef5b2fc30fd4200530e0").legacyPackages.x86_64-linux.kubernetes-helm
      ];
      __pins.vscode-extensions = [
        {
          name = "python";
          publisher = "ms-python";
          sha256 = "0dxlqyhcfmb0bqbny633g0hwcq5ac7nz5rrq1c795bs3pimm8p20";
          version = "2022.7.11541009";
        }
        {
          name = "pylint";
          publisher = "ms-python";
          sha256 = "0zca7w55v5xw69d7fva0mq5swc9ax36v598khzvrq3p4nzfjvfhk";
          version = "2022.1.11541003";
        }
      ];
    });
}
