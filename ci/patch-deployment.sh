#!/usr/bin/env bash
#
# ci/patch-deployment.sh <build_version> [github_id] [repo_name]
#
# Exemple d'utilisation :
#   ./ci/patch-deployment.sh V1.0 dines2593 demo-java-app

BUILD_VERSION="\${1:-V1.0}"
GITHUB_ID="\${2:-dines2593}"
REPO="\${3:-demo-java-app}"
TEMPLATE="helm/app/templates/deployment.yaml"

if [ ! -f "\$TEMPLATE" ]; then
  echo "❌ Fichier \$TEMPLATE introuvable"
  exit 1
fi

# On cherche la première occurence de "image:" et on remplace le reste de la ligne
# par githubID/repo:version
sed -i -E "0,/image:/ s|(image:[[:space:]]*).+|\1\${GITHUB_ID}/\${REPO}:\${BUILD_VERSION}|" "\$TEMPLATE"

echo "✅ \$TEMPLATE patché en image=\${GITHUB_ID}/\${REPO}:\${BUILD_VERSION}"
