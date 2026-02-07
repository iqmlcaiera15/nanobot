#!/bin/bash
set -e

# Create config directory
mkdir -p /root/.nanobot
mkdir -p /root/.nanobot/workspace

# Generate config.json from ENV variables
cat > /root/.nanobot/config.json <<EOF
{
  "agents": {
    "defaults": {
      "workspace": "/root/.nanobot/workspace",
      "model": "${NANOBOT_MODEL:-openai/gpt-5-mini}",
      "maxTokens": ${NANOBOT_MAX_TOKENS:-2000},
      "temperature": ${NANOBOT_TEMPERATURE:-0.4},
      "maxToolIterations": ${NANOBOT_MAX_TOOL_ITERATIONS:-2}
    }
  },
  "channels": {
    "whatsapp": {
      "enabled": false,
      "bridgeUrl": "ws://localhost:3001",
      "allowFrom": []
    },
    "telegram": {
      "enabled": false,
      "token": "8366547976:AAENU2kkjCikK3LG79hVc2FagsM6tjr2Kes",
      "allowFrom": [],
      "proxy": null
    },
    "discord": {
      "enabled": false,
      "token": "",
      "allowFrom": [],
      "gatewayUrl": "wss://gateway.discord.gg/?v=10&encoding=json",
      "intents": 37377
    },
    "feishu": {
      "enabled": false,
      "appId": "",
      "appSecret": "",
      "encryptKey": "",
      "verificationToken": "",
      "allowFrom": []
    }
  },
  "providers": {
    "anthropic": {
      "apiKey": "${ANTHROPIC_API_KEY:-}",
      "apiBase": null
    },
    "openai": {
      "apiKey": "${OPENAI_API_KEY:-}",
      "apiBase": null
    },
    "openrouter": {
      "apiKey": "${OPENROUTER_API_KEY:-}",
      "apiBase": "https://openrouter.ai/api/v1"
    },
    "deepseek": {
      "apiKey": "${DEEPSEEK_API_KEY:-}",
      "apiBase": null
    },
    "groq": {
      "apiKey": "${GROQ_API_KEY:-}",
      "apiBase": null
    },
    "zhipu": {
      "apiKey": "${ZHIPU_API_KEY:-}",
      "apiBase": null
    },
    "dashscope": {
      "apiKey": "${DASHSCOPE_API_KEY:-}",
      "apiBase": null
    },
    "vllm": {
      "apiKey": "${VLLM_API_KEY:-}",
      "apiBase": "${VLLM_API_BASE:-}"
    },
    "gemini": {
      "apiKey": "${GEMINI_API_KEY:-}",
      "apiBase": null
    },
    "moonshot": {
      "apiKey": "${MOONSHOT_API_KEY:-}",
      "apiBase": null
    }
  },
  "gateway": {
    "host": "0.0.0.0",
    "port": ${NANOBOT_PORT:-18790}
  },
  "tools": {
    "web": {
      "search": {
        "apiKey": "${BRAVE_SEARCH_API_KEY:-}",
        "maxResults": ${WEB_SEARCH_MAX_RESULTS:-5}
      }
    },
    "exec": {
      "timeout": ${EXEC_TIMEOUT:-60}
    },
    "restrictToWorkspace": ${RESTRICT_TO_WORKSPACE:-false}
  }
}
EOF

echo "=== Generated nanobot config ==="
cat /root/.nanobot/config.json
echo "================================"

# Start nanobot gateway
nanobot gateway
