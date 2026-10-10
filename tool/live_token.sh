#!/usr/bin/env bash
# Prints a Supabase access token for a seeded local account (dev only).
# Usage: tool/live_token.sh customer@rove.test
set -euo pipefail
EMAIL="${1:-customer@rove.test}"
ENV_FILE="$(dirname "$0")/../../rove-backend/.env.example"
ANON=$(grep '^SUPABASE_ANON_KEY=' "$ENV_FILE" | cut -d= -f2)
PASS=$(grep '^SEED_USER_PASSWORD=' "$ENV_FILE" | cut -d= -f2)
curl -s -X POST "http://127.0.0.1:54321/auth/v1/token?grant_type=password" \
  -H "apikey: $ANON" -H "Content-Type: application/json" \
  -d "{\"email\":\"$EMAIL\",\"password\":\"$PASS\"}" |
  python3 -c "import json,sys;print(json.load(sys.stdin)['access_token'])"
