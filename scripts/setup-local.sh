#!/bin/bash
set -e

echo "🎮 Setting up Number Game Platform..."

# Check prerequisites
command -v kubectl >/dev/null 2>&1 || { echo "kubectl required but not installed. Aborting." >&2; exit 1; }
command -v helm >/dev/null 2>&1 || { echo "helm required but not installed. Aborting." >&2; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "docker required but not installed. Aborting." >&2; exit 1; }

echo "✅ Prerequisites checked"

# Create namespace
kubectl create namespace number-game-dev --dry-run=client -o yaml | kubectl apply -f -

# Install nginx ingress if needed
if ! kubectl get ingressclass nginx >/dev/null 2>&1; then
    echo "📥 Installing nginx ingress..."
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml
    kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=300s
fi

# Add to /etc/hosts
if ! grep -q "game.local" /etc/hosts; then
    echo "127.0.0.1 game.local" | sudo tee -a /etc/hosts
fi

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. ./scripts/build.sh"
echo "2. helm install number-game ./helm -f helm/values/development.yaml -n number-game-dev"
echo "3. Open http://game.local"