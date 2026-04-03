#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${ROOT_DIR}/FIRST CALL/Assets.xcassets/AppLogo.imageset/logo-1024.png"
OUT="${ROOT_DIR}/FirstCall/Assets.xcassets/AppIcon.appiconset"

if [[ ! -f "$SRC" ]]; then
  echo "Missing $SRC. Generate it first with: xcrun swift tools/generate_logo.swift" >&2
  exit 1
fi

mkdir -p "$OUT"

gen() {
  local size=$1; local filename=$2
  echo "→ $filename ($size px)"
  /usr/bin/sips -s format png -z "$size" "$size" "$SRC" --out "$OUT/$filename" >/dev/null
}

# iPhone
gen 40  appicon-20@2x.png
gen 60  appicon-20@3x.png
gen 58  appicon-29@2x.png
gen 87  appicon-29@3x.png
gen 80  appicon-40@2x.png
gen 120 appicon-40@3x.png
gen 120 appicon-60@2x.png
gen 180 appicon-60@3x.png

# iPad
gen 20  appicon-ipad-20@1x.png
gen 40  appicon-ipad-20@2x.png
gen 29  appicon-ipad-29@1x.png
gen 58  appicon-ipad-29@2x.png
gen 40  appicon-ipad-40@1x.png
gen 80  appicon-ipad-40@2x.png
gen 76  appicon-ipad-76@1x.png
gen 152 appicon-ipad-76@2x.png
gen 167 appicon-ipad-83.5@2x.png

# Marketing
cp "$SRC" "$OUT/appicon-marketing-1024.png"

echo "AppIcon images written to $OUT"

