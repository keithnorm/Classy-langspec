# Path where this script is located
SCRIPT_PATH="$(dirname "$BASH_SOURCE")"

# Set up path for PlistBuddy helper application which can add elements to Plist files
PLISTBUDDY=/usr/libexec/PlistBuddy

DVTFOUNDATION_PATH="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources"
cp "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata.bak" "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"

# delete the lang registration from DVTFoundation
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete :plug-in:extensions:Xcode.SourceCodeLanguage.CAS'

# delete the langspec
rm "$DVTFOUNDATION_PATH/CAS.xclangspec"
echo "$DVTFOUNDATION_PATH/CAS.xclangspec"

echo "Removed"
