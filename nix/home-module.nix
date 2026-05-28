flake: { config, lib, pkgs, ... }:

let
  cfg = config.programs.broccoli;

  aliasSet =
    (lib.optionalAttrs cfg.aliases.done { done = "todo do"; })
    // (lib.optionalAttrs cfg.aliases.undo { undo = "todo undo"; });

  package = if cfg.todoFilePath == null
    then cfg.package
    else pkgs.symlinkJoin {
      name = "${cfg.package.name}-wrapped";
      paths = [ cfg.package ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/todo \
          --set-default TODO_FILE_PATH ${lib.escapeShellArg cfg.todoFilePath}
      '';
    };
in
{
  options.programs.broccoli = {
    enable = lib.mkEnableOption "improved-broccoli, a tiny cli todo app";

    package = lib.mkOption {
      type = lib.types.package;
      default = flake.packages.${pkgs.stdenv.hostPlatform.system}.broccoli;
      defaultText = lib.literalExpression "inputs.broccoli.packages.\${system}.broccoli";
      description = "the broccoli package to use.";
    };

    todoFilePath = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "/home/you/notes/todo.md";
      description = ''
        absolute path to the todo file. when set, baked into the wrapped
        todo binary in a shell-agnostic way. can still be overridden
        per-invocation by setting TODO_FILE_PATH in your shell. when null,
        broccoli's default of todo.md in the current directory is used.
      '';
    };

    aliases = {
      done = lib.mkEnableOption "a `done` shell alias for `todo do`";
      undo = lib.mkEnableOption "an `undo` shell alias for `todo undo`";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ package ];
    home.shellAliases = aliasSet;
  };
}
