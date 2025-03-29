#!/usr/bin/osascript
on run argv
  set dir to quoted form of (first item of argv)
  tell app "WezTerm" to do script "cd " & dir
end run
