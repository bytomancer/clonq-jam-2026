# Development

This development environment is setup for NixOS.

```bash
nix develop -c codium .
```

Or, if you prefer to work from a terminal multiplexer, I would suggest

```bash
nix develop -c zellij
```

## godot

Once you have a terminal, launch godot:

```bash
godot godot/project.godot
```

or launch libresprite:

```bash
libresprite
```

# Layout

```
output/       - HTML output of the project
assets/       - raw assets, these will not be distributed in the project's output
godot/        - godot project root
godot/ass/    - assets for godot
godot/ext/    - external assets, attribution per folder as well!
godot/scn/    - godot sublicense
godot/src/    - where all gd scripts live
```

# Attribution

## Font

Spleen 2.2.0 - https://sourceforge.net/projects/spleen.mirror/
