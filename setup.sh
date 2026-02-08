#!/bin/bash

# Light Browser - Setup Script
# This script sets up the development environment

echo "🚀 Light Browser Setup"
echo "====================="
echo ""

# Check for Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode not found!"
    echo "   Please install Xcode from Mac App Store"
    echo "   Then run: xcode-select --install"
    exit 1
fi

echo "✅ Xcode found: $(xcodebuild -version | head -1)"

# Check for XcodeGen
if ! command -v xcodegen &> /dev/null; then
    echo "📦 Installing XcodeGen..."
    brew install xcodegen
else
    echo "✅ XcodeGen found: $(xcodegen --version)"
fi

echo ""
echo "🔧 Generating Xcode project..."
cd "$(dirname "$0")"
xcodegen generate

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Project generated successfully!"
    echo ""
    echo "📱 To run the app:"
    echo "   1. Open LightBrowser.xcodeproj"
    echo "   2. Select a simulator or device"
    echo "   3. Press Cmd+R to build and run"
    echo ""
    echo "🏪 To submit to App Store:"
    echo "   1. Set up Apple Developer Account"
    echo "   2. Configure signing in Xcode"
    echo "   3. Product → Archive → Upload"
else
    echo ""
    echo "❌ Failed to generate project"
    exit 1
fi
