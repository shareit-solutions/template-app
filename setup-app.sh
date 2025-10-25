#!/bin/bash

# Script para configurar uma nova aplicação usando este template
# Uso: ./setup-app.sh <app-name> <repo-url> <image-repo> <image-tag> <domain>

set -e

if [ $# -ne 5 ]; then
    echo "Uso: $0 <app-name> <repo-url> <image-repo> <image-tag> <domain>"
    echo "Exemplo: $0 minha-app https://github.com/user/repo.git myregistry/myapp latest example.com"
    exit 1
fi

APP_NAME=$1
REPO_URL=$2
IMAGE_REPO=$3
IMAGE_TAG=$4
DOMAIN=$5

echo "Configurando aplicação: $APP_NAME"
echo "Repositório: $REPO_URL"
echo "Imagem: $IMAGE_REPO"
echo "Tag da imagem: $IMAGE_TAG"
echo "Domínio: $DOMAIN"

# Escapar caracteres especiais para sed
ESCAPED_REPO_URL=$(echo "$REPO_URL" | sed 's/[[\.*^$()+?{|]/\\&/g')
ESCAPED_IMAGE_REPO=$(echo "$IMAGE_REPO" | sed 's/[[\.*^$()+?{|]/\\&/g')

# Substituir variáveis nos arquivos
echo "Substituindo variáveis nos arquivos..."

# IMPORTANTE: Substituir IMAGE_REPOSITORY_TAG antes de IMAGE_REPOSITORY para evitar conflitos
find . -type f \( -name "*.yaml" -o -name "*.yml" \) -exec sed -i "s/IMAGE_REPOSITORY_TAG/$IMAGE_TAG/g" {} \;
find . -type f \( -name "*.yaml" -o -name "*.yml" \) -exec sed -i "s/APP_NAME/$APP_NAME/g" {} \;
find . -type f \( -name "*.yaml" -o -name "*.yml" \) -exec sed -i "s|REPO_URL|$ESCAPED_REPO_URL|g" {} \;
find . -type f \( -name "*.yaml" -o -name "*.yml" \) -exec sed -i "s|IMAGE_REPOSITORY|$ESCAPED_IMAGE_REPO|g" {} \;
find . -type f \( -name "*.yaml" -o -name "*.yml" \) -exec sed -i "s/DOMAIN/$DOMAIN/g" {} \;

echo "Configuração concluída!"
echo ""
echo "Próximos passos:"
echo "1. Revise e ajuste os valores em charts/app/values*.yaml"
echo "2. Personalize os templates em charts/app/templates/ conforme necessário"
echo "3. Commit as mudanças no seu repositório Git"
echo "4. Aplique as aplicações ArgoCD:"
echo "   kubectl apply -f argocd/application-stg.yaml"
echo "   kubectl apply -f argocd/application-prd.yaml"