#!/bin/bash

# Exit if any command fails
set -e

# Step 1: Create the directory and download scripts
mkdir -p ~/.githooks
cd ~/.githooks

# Download commit-msg and pre-commit scripts using curl
echo -e "Downloading commit-msg"
if ! curl -o commit-msg --fail "https://gs-dev-qa-ui-cdn.s3.amazonaws.com/githooks/commit-msg"; then
    echo "Error: Failed to download commit-msg script"
    echo "  Please Check if you have access to 'https://gs-dev-qa-ui-cdn.s3.amazonaws.com/githooks/commit-msg'"
    echo -e "  Git Hooks Set Up Failed \n"
    exit 1
fi

echo -e "\nDownloading pre-commit"
if ! curl -o  pre-commit --fail "https://raw.githubusercontent.com/ksripraveena/Test_Gitleaks/main/Testsfile"; then
    echo "Error: Failed to download pre-commit script"
    echo "  Please Check if you have access to 'https://raw.githubusercontent.com/ksripraveena/Test_Gitleaks/main/Testsfile'"
    echo -e "  Git Hooks Set Up Failed \n"
    exit 1
fi

# Set permissions
echo -e "\nMaking the scripts executable"
chmod +x commit-msg pre-commit
echo -e "Permissions Changed Successfully\n"

# Step 2: Configure Git Globally
echo -e "Modifying Global .gitconfig file"
if ! git config --global core.hooksPath ~/.githooks; then
    echo "Error: Failed to configure Git hooks globally"
    echo "  Git Hooks Set Up Failed"
    exit 1
fi
echo -e "Global git config updated successfully \n"

echo -e "Git hooks setup completed! \n"
