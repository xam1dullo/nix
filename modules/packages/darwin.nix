{ pkgs, ... }:
with pkgs; [
  # Ensure `uv` (CLI installed by the upstream project) is available on Darwin systems
  uv
]
