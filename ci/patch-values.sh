#!/usr/bin/env bash
set -euo pipefail

BUILD_VERSION="${1:?usage: $0 <version> <github_id> <repo>}"
GITHUB_ID="${2:?usage: $0 <version> <github_id> <repo>}"
REPO="${3:?usage: $0 <version> <github_id> <repo>}"

VALUES="helm/app/values.yaml"

echo "⏳ cwd=$(pwd) — vérification de l'existence de : \$VALUES"
if [ ! -f "\$VALUES" ]; then
  echo "❌ Fichier '\$VALUES' introuvable"
  exit 1
fi

echo "🔧 Application du patch dans '\$VALUES'…"
sed -i -E "s|^(  githubID:).*|\1 $GITHUB_ID|" "\$VALUES"
sed -i -E "s|^(  repository:).*|\1 $REPO|"     "\$VALUES"
sed -i -E "s|^(  tag:).*|\1 $BUILD_VERSION|"    "\$VALUES"

echo "✅ Patch appliqué dans '\$VALUES' :"
echo "   image.githubID = $GITHUB_ID"
echo "   image.repository = $REPO"
echo "   image.tag        = $BUILD_VERSION"
