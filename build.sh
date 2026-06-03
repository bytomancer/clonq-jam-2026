#! /usr/bin/env bash
echo "test"

cd godot

nix develop .. --command \
godot \
    --headless \
    --export-release "Web Release"
