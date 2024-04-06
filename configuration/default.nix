{lib, ...}: let
  enumerateModules = basePath: fileName: let
    inherit (builtins) readDir;
    inherit (lib) attrNames filter filterAttrs pathExists foldl';
    inherit (lib.trivial) pipe;

    packagePaths = path: attrNames (filterAttrs (_: type: type == "directory") (readDir path));
    modulesInPackage = package: [package "${fileName}.nix"];
    renderPath = foldl' (path: elem: path + "/${elem}");

    modules = pipe (packagePaths basePath) [
      (map modulesInPackage)
      (map (renderPath basePath))
      (filter pathExists)
    ];
  in
    {...}: {
      imports = modules;
    };

  createModule = enumerateModules ./.;
in {
  nix-machine.configurations.squirmy = {
    options = createModule "options";
    nixDarwin = createModule "darwin-module";
    homeManager = createModule "hm-module";
  };
}
