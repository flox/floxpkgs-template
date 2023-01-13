{
  

  # Declaration of external resources
  # =================================

  # =================================


  description = "Floxpkgs/Project Template";
  nixConfig.bash-prompt = "[flox] \\[\\033[38;5;172m\\]λ \\[\\033[0m\\]";

  # Template DO NOT EDIT
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  inputs.flox-floxpkgs.url = "github:flox/floxpkgs";
  outputs = args @ {flox-floxpkgs, ...}: flox-floxpkgs.capacitor args (import ./flox.nix);
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}
