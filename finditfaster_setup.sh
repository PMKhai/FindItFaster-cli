#!/bin/zsh

# FindItFaster Installation Script

# Path to finditfaster.sh file
FINDITFASTER_PATH="$(pwd)/finditfaster.sh"

# Check if finditfaster.sh file exists
if [ ! -f "$FINDITFASTER_PATH" ]; then
  echo "❌ finditfaster.sh file not found at $(pwd)"
  exit 1
fi

# Check if required tools are installed
MISSING_TOOLS=""
for tool in fzf rg bat; do
  if ! command -v $tool >/dev/null 2>&1; then
    MISSING_TOOLS="$MISSING_TOOLS $tool"
  fi
done

if [ -n "$MISSING_TOOLS" ]; then
  echo "❌ The following tools are not installed:$MISSING_TOOLS"
  echo "Please install them using Homebrew:"
  echo "brew install$MISSING_TOOLS"
  exit 1
fi

# Add source line to .zshrc if it doesn't exist
if ! grep -q "source $FINDITFASTER_PATH" ~/.zshrc; then
  echo "\n# Add FindItFaster\nsource $FINDITFASTER_PATH" >> ~/.zshrc
  echo "✅ Added FindItFaster to ~/.zshrc"
else
  echo "ℹ️ FindItFaster is already configured in ~/.zshrc"
fi

# Apply changes
echo "🔄 Applying changes..."
source ~/.zshrc 2>/dev/null || echo "⚠️ Could not reload .zshrc automatically. Please run 'source ~/.zshrc' to apply changes."

echo "\n🎉 FindItFaster installation complete!"
echo "📚 See usage instructions at: $(pwd)/finditfaster.md"
echo "💡 Type 'finditfaster_help' to see available commands"
