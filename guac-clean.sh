#!/bin/bash
# guac-clean — a lean, transparent macOS maintenance script 🥑
# (placeholder name — will be renamed before publishing)

clear
echo "🥑  guac-clean — keeping your Mac ripe"
echo ""

PS3=$'\nSelection: '

options=(
  "Flush DNS Cache"
  "──────── ⚠️  destructive below ────────"
  "🔥 Empty Trash (Permanent Delete)"
  "Exit"
)

select opt in "${options[@]}"
do
  case $opt in
    "Flush DNS Cache")
      echo "🧹  Flushing DNS cache..."
      sudo dscacheutil -flushcache
      sudo killall -HUP mDNSResponder
      echo "✅  DNS cache flushed."
      ;;
    "──────── ⚠️  destructive below ────────")
      echo "(that's just a divider — pick a real option)"
      ;;
    "🔥 Empty Trash (Permanent Delete)")
      echo "🔥  This is different from everything else in this script."
      echo "    Every other cleanup action moves files to Trash first, so you can recover them."
      echo "    This action permanently empties Trash — including any external drives' Trash."
      echo "    Nothing removed here can be undone."
      read -p "Type EMPTY to confirm: " confirm
      if [[ "$confirm" == "EMPTY" ]]; then
        echo "🔥  Emptying Trash..."
        rm -rf ~/.Trash/*
        for vol_trash in /Volumes/*/.Trashes; do
          if [ -d "$vol_trash" ]; then
            sudo rm -rf "$vol_trash"/*
          fi
        done
        echo "✅  Trash emptied."
      else
        echo "❎  Cancelled — Trash left untouched."
      fi
      ;;
    "Exit")
      echo "👋  See you next time."
      break
      ;;
    *)
      echo "Invalid option, try again."
      ;;
  esac
done
