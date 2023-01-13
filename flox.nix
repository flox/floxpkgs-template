{
  self,
  inputs,
  lib,
  ...
}:
# Define package set structure
{

  # Template Configuration:
  # DO NOT EDIT
  config.extraPlugins = [
      (
        inputs.flox-floxpkgs.plugins.catalog {
          catalogDirectory = self.outPath + "/catalog";
        }
      )
      (inputs.flox-floxpkgs.capacitor.plugins.allLocalResources {})
    ];
}
