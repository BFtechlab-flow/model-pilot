#!/usr/bin/env bash
# Builds dist/model-pilot.zip for upload to the Claude app (Customize > Skills).
# The ZIP contains the model-pilot/ skill folder with SKILL.md inside it.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/dist"
rm -f "$ROOT/dist/model-pilot.zip"
cd "$ROOT/skills"
zip -r -X "$ROOT/dist/model-pilot.zip" model-pilot -x '*.DS_Store'
echo "Built $ROOT/dist/model-pilot.zip"
