# Path where this script is located
SCRIPT_PATH="$(dirname "$BASH_SOURCE")"

# Set up path for PlistBuddy helper application which can add elements to Plist files
PLISTBUDDY=/usr/libexec/PlistBuddy

# Filename path private framework we need to modify
#DVTFOUNDATION_PATH="/Developer/Library/PrivateFrameworks/DVTFoundation.framework/Versions/A/Resources/"
#DVTFOUNDATION_PATH="/XCode4.3/Library/PrivateFrameworks/DVTFoundation.framework/Versions/A/Resources/"

# This framework is found withing the Xcode.app package and is used when Xcode is a monolithic
# install (all contained in Xcode.app)



DVTFOUNDATION_PATH="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/"
curl "https://raw.githubusercontent.com/keithnorm/Classy-langspec/master/CAS.plist" -o "temp.plist"
curl "https://raw.githubusercontent.com/keithnorm/Classy-langspec/master/CAS.plist" -o "temp.xclangspec"

cp "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata" "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata.bak"
# Now merge in the additonal languages to DVTFoundation.xcplugindata
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Merge temp.plist plug-in:extensions'

LANGSPEC=$(cat $SCRIPT_PATH/temp.xclangspec)

# Copy in the xclangspecs for the languages (assumes in same directory as this shell script)
echo "$LANGSPEC" > "$DVTFOUNDATION_PATH/CAS.xclangspec"

# Remove any cached Xcode plugins
rm -rf /private/var/folders/*/*/*/com.apple.DeveloperTools/*/Xcode/PlugInCache*.xcplugincache
rm temp.plist
rm temp.xclangspec

echo "Done"
