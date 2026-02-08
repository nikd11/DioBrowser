#!/bin/bash

# DioBrowser GitHub Setup Script
# This script authenticates with GitHub and creates the DioBrowser repository

set -e

echo "🔧 DioBrowser GitHub Setup Script"
echo "=================================="
echo ""

# Step 1: Authenticate with GitHub
echo "Step 1: Authenticating with GitHub..."
echo ""

if gh auth status 2>/dev/null | grep -q "Logged in"; then
    echo "✅ Already authenticated with GitHub!"
else
    echo "Starting GitHub authentication..."
    echo ""
    echo "IMPORTANT: A browser window will open for authentication."
    echo "1. You'll see a one-time code"
    echo "2. Go to https://github.com/login/device"
    echo "3. Enter the code"
    echo "4. Authorize GitHub CLI"
    echo ""
    echo "Press Enter when you've completed authentication..."
    read -r
    
    gh auth login --hostname github.com
fi

echo ""
echo "✅ Authentication complete!"
echo ""

# Step 2: Verify authentication
echo "Step 2: Verifying authentication..."
if ! gh auth status 2>/dev/null | grep -q "Logged in"; then
    echo "❌ Authentication failed. Please try again."
    exit 1
fi
echo "✅ Verified!"
echo ""

# Step 3: Create repository
echo "Step 3: Creating DioBrowser repository..."

cd /Users/dandroid/.openclaw/workspace/DioBrowser

if gh repo view DioBrowser &>/dev/null; then
    echo "ℹ️ Repository DioBrowser already exists!"
    echo "✅ Remote is already set up."
else
    echo "Creating new repository..."
    gh repo create DioBrowser \
        --public \
        --description="Fast, private, simple iOS browser" \
        --source=. \
        --push
    
    echo ""
    echo "✅ Repository created and code pushed!"
fi

echo ""
echo "=================================="
echo "🎉 SETUP COMPLETE!"
echo "=================================="
echo ""
echo "Repository: https://github.com/dandroid/DioBrowser"
echo ""
echo "Next steps:"
echo "1. Open Codespaces: https://github.com/dandroid/DioBrowser → Code → Codespaces"
echo "2. Build in cloud with Xcode Cloud"
echo "3. Submit to App Store!"
echo ""
