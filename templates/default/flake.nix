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

      # AUTO-MANAGED AFTER THIS POINT ##################################
      # AUTO-MANAGED AFTER THIS POINT ##################################
      # AUTO-MANAGED AFTER THIS POINT ##################################
      __pins.versions = {
      };
      __pins.vscode-extensions = [
      ];
    });
}
