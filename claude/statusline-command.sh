#!/usr/bin/env bash
# Claude Code maximalist status line

input=$(cat)

# --- Terminal width ---
term_width=$(tput cols 2>/dev/null || echo 120)

# --- Model ---
model=$(echo "$input" | jq -r '.model.display_name // "unknown model"')

# --- Current directory (basename only for brevity) ---
cwd=$(echo "$input" | jq -r '.cwd // ""')
dir=$(basename "$cwd")

# --- Context window + pressure gauge ---
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
  used_int=$(printf "%.0f" "$used")

  # Visual bar (10 chars wide)
  filled=$((used_int / 10))
  empty=$((10 - filled))
  bar=""
  for ((i=0; i<filled; i++)); do bar+="█"; done
  for ((i=0; i<empty; i++)); do bar+="░"; done

  ctx_str="${bar} ${used_int}%"
else
  ctx_str="░░░░░░░░░░ --"
fi

# --- Vim mode ---
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')

# --- Effort level ---
effort=$(echo "$input" | jq -r '.effort.level // empty')

# --- Git branch or PR ---
git_info=""
pr_num=$(echo "$input" | jq -r '.pr.number // empty')
pr_state=$(echo "$input" | jq -r '.pr.review_state // empty')
if [ -n "$pr_num" ]; then
  if [ -n "$pr_state" ]; then
    git_info="PR#${pr_num}(${pr_state})"
  else
    git_info="PR#${pr_num}"
  fi
else
  branch=$(echo "$input" | jq -r '.worktree.branch // empty')
  if [ -z "$branch" ]; then
    branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
  fi
  [ -n "$branch" ] && git_info="⎇ $branch"
fi

# --- Midway token expiry ---
midway_str=""
cookie_file="$HOME/.midway/cookie"
if [ -f "$cookie_file" ]; then
  cookie_mtime=$(stat -f "%m" "$cookie_file" 2>/dev/null)
  if [ -n "$cookie_mtime" ]; then
    now=$(date +%s)
    # Midway cookies expire after 10 hours (36000 seconds)
    expires_at=$((cookie_mtime + 36000))
    remaining=$((expires_at - now))

    if [ "$remaining" -le 0 ]; then
      midway_str="mw:EXPIRED"
    elif [ "$remaining" -lt 1800 ]; then
      mins=$((remaining / 60))
      midway_str="mw:${mins}m!"
    elif [ "$remaining" -lt 3600 ]; then
      mins=$((remaining / 60))
      midway_str="mw:${mins}m"
    else
      hours=$((remaining / 3600))
      mins=$(( (remaining % 3600) / 60 ))
      midway_str="mw:${hours}h${mins}m"
    fi
  fi
fi

# --- Session cost (USD, client-side estimate) ---
cost_str=""
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
if [ -n "$cost_usd" ]; then
  cost_str=$(printf '$%.2f' "$cost_usd")
fi

# --- Rate limits ---
rate_str=""
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
if [ -n "$five_pct" ]; then
  rate_str=$(printf "5h:%.0f%%" "$five_pct")
fi
if [ -n "$week_pct" ]; then
  week_part=$(printf "7d:%.0f%%" "$week_pct")
  rate_str="${rate_str:+$rate_str }$week_part"
fi

# --- Assemble segments ---
segments=()
segments+=("$model")
segments+=("$dir")
segments+=("$ctx_str")
[ -n "$vim_mode" ] && segments+=("$vim_mode")
[ -n "$effort" ] && segments+=("⚡$effort")
[ -n "$git_info" ] && segments+=("$git_info")
[ -n "$midway_str" ] && segments+=("$midway_str")
[ -n "$cost_str" ] && segments+=("$cost_str")
[ -n "$rate_str" ] && segments+=("$rate_str")

# --- Join with separator ---
sep=" | "
output=""
for i in "${!segments[@]}"; do
  if [ "$i" -eq 0 ]; then
    output="${segments[$i]}"
  else
    output+="${sep}${segments[$i]}"
  fi
done

# --- Truncate to terminal width if needed ---
# Strip emoji for length calc (rough: each emoji ~2 display cols)
visible_len=${#output}
if [ "$visible_len" -gt "$term_width" ]; then
  output="${output:0:$((term_width - 1))}…"
fi

printf '%s' "$output"
