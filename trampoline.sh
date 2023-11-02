#!/usr/bin/env bash

# dest="/Users/${username}/Applications/Home Manager Trampolines/"
# src="${apps}/Applications/"
# rm -rf "$dest" && mkdir -p "$dest"
# export dest

# for file do
#     # escape the filename because space separated filenames suck
#     filename="''${file@Q}"
#     appname="$(basename "$file")"
#     out="$dest/$appname"

#     # This is basically going to be the script body
#     open_cmd=(
#         "open"
#         \"$file\"
#     )
#     open_cmd="''${open_cmd[@]}"

#     # generate a wrapper app visible to spotlight
#     wrapper=(
#         "do"
#         "shell"
#         "script"
#         "$open_cmd"
#     )
#     wrapper="''${wrapper[@]}"
#     /usr/bin/osacompile -o "$out" -e "$wrapper" 2>/dev/null

#     # time to make stuff visible in spotlight
#     plutil=/usr/bin/plutil
#     contents=/Contents
#     resources="$contents/Resources"
#     plist="$contents/Info.plist"

#     # splice in the icon
#     icon="$("$plutil" -extract CFBundleIconFile raw "$file/$plist")"
#     icon="''${icon%.icns}.icns"
#     icon_src="$file/$resources/$icon"
#     mkdir -p "$out/$resources" && cp "$icon_src" "$_/applet.icns"
# done

function thing() {
  files=("$@")

  for file in "${files[@]}"; do

    /usr/bin/osacompile -o "$toDir/$app" -e 'do shell script "open \"$fromDir/$app\""'
    icon="$(/usr/bin/plutil -extract CFBundleIconFile raw "$fromDir/$app/Contents/Info.plist")"
    mkdir -p "$toDir/$app/Contents/Resources"
    cp -f "$fromDir/$app/Contents/Resources/$icon" "$toDir/$app/Contents/Resources/applet.icns"

  done
}

export -f thing
find . -exec sh -c 'thing "$@"' sh {} +
