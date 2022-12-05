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
        inputs.floxpkgs.plugins.catalog {
          catalogDirectory = self.outPath + "/catalog";
        }
      )
      (inputs.floxpkgs.capacitor.plugins.allLocalResources {})
    ];
}
