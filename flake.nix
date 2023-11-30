{
  description = "Sleep then notify";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux.alarm = pkgs.writeShellScriptBin "alarm" ''
      sleep $*

      ${pkgs.libnotify}/bin/notify-send \
        --app-name alarm \
        --urgency critical \
        --expire-time 3600000 \
        "Alarm $*"
    '';
    packages.x86_64-linux.default = self.packages.x86_64-linux.alarm;
  };
}
