#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <url-or-domain>" >&2
  exit 1
fi

input="$1"
if [[ "$input" =~ ^https?:// ]]; then
  base="$input"
else
  base="https://$input"
fi

base="${base%/}"
domain="${base#http://}"
domain="${domain#https://}"
domain="${domain%%/*}"
origin="https://$domain"

ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

fetch_status() {
  url="$1"
  tmp=$(mktemp)
  status=$(curl -L -sS -o "$tmp" -w "%{http_code}" "$url" 2>/dev/null || true)
  if [ -z "$status" ] || [ "$status" = "000" ]; then
    status="Unknown / fetch failed"
  fi
  printf '%s\t%s\n' "$status" "$tmp"
}

printf '# Static GEO Checks: %s\n\n' "$domain"
printf '- Run date: %s\n' "$ts"
printf '- Evidence status: Observed when fetched successfully; Unknown when fetch failed.\n\n'

for path in robots.txt sitemap.xml llms.txt security.txt humans.txt; do
  result=$(fetch_status "$origin/$path")
  status=${result%%$'\t'*}
  tmp=${result#*$'\t'}
  printf '## /%s\n\n' "$path"
  printf '- URL: `%s/%s`\n' "$origin" "$path"
  printf '- HTTP status: %s\n' "$status"
  if [ "$status" = "200" ]; then
    bytes=$(wc -c < "$tmp" | tr -d ' ')
    printf '- Bytes: %s\n' "$bytes"
    if [ "$path" = "robots.txt" ]; then
      printf '\n### AI Crawler Directives\n\n'
      for bot in GPTBot OAI-SearchBot ChatGPT-User ClaudeBot PerplexityBot Google-Extended CCBot Bytespider Applebot-Extended Amazonbot; do
        if grep -i "User-agent:[[:space:]]*$bot" "$tmp" >/dev/null; then
          printf '- %s: Mentioned\n' "$bot"
        else
          printf '- %s: Not mentioned\n' "$bot"
        fi
      done
      if grep -i '^Sitemap:' "$tmp" >/dev/null; then
        printf '\n### Sitemap Directives\n\n'
        grep -i '^Sitemap:' "$tmp" | sed 's/^/- /'
      fi
    fi
  fi
  rm -f "$tmp"
  printf '\n'
done

home=$(mktemp)
home_status=$(curl -L -sS -o "$home" -w "%{http_code}" "$origin" 2>/dev/null || true)
if [ -z "$home_status" ] || [ "$home_status" = "000" ]; then
  home_status="Unknown / fetch failed"
fi

printf '## Homepage Raw HTML Signals\n\n'
printf '- URL: `%s`\n' "$origin"
printf '- HTTP status: %s\n' "$home_status"
if [ "$home_status" = "200" ]; then
  if grep -Eiq 'id="root"|id="app"|__NEXT_DATA__|__nuxt|vite|data-reactroot' "$home"; then
    printf '- SPA/framework markers: Present\n'
  else
    printf '- SPA/framework markers: Not detected\n'
  fi
  if grep -iq 'application/ld+json' "$home"; then
    printf '- JSON-LD markers: Present\n'
  else
    printf '- JSON-LD markers: Not detected\n'
  fi
  if grep -Eiq '<meta[^>]+name=["'\'' ]robots["'\'' ][^>]+noindex|noindex' "$home"; then
    printf '- noindex marker: Possible presence; review manually\n'
  else
    printf '- noindex marker: Not detected in raw HTML\n'
  fi
fi
rm -f "$home"
