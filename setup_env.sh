#!/bin/bash

# chmod +x setup_env.sh

# .env -> .env.example
if [ -f .env ]; then
    sed 's/=.*/=/' .env > .env.example
    echo "✅ Generated .env.example from .env"
else
    echo "⚠️  .env file not found, skipping..."
fi

# config.json -> config.json.example
if [ -f config.json ]; then
    sed 's/": ".*"/": ""/g' config.json > config.example.json
    echo "✅ Generated config.json.example from config.json"
else
    echo "⚠️  config.json file not found, skipping..."
fi