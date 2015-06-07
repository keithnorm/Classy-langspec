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
cp "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata" "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata.bak"
# Now merge in the additonal languages to DVTFoundation.xcplugindata
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Merge CAS.plist plug-in:extensions'

# Copy in the xclangspecs for the languages (assumes in same directory as this shell script)
cp "$SCRIPT_PATH/CAS.xclangspec" "$DVTFOUNDATION_PATH"

# Remove any cached Xcode plugins
rm -rf /private/var/folders/*/*/*/com.apple.DeveloperTools/*/Xcode/PlugInCache*.xcplugincache

echo "Done"
