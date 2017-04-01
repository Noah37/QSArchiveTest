#!/bin/sh

#  autoarchive.sh
#  EMobile_CIB_iPhone
#
#  Created by Nory Chao on 2017/3/20.
#  Copyright © 2017 CSII. All rights reserved.

# Purpose:
#    Auto to build Xcode project and achive,install ipa to iOS device if you connect one.
#    (Actually, this is a concise shell script,just slack to archive)
#
# Notes:
# 1) To use this,you must set your project CA certificate and mobileprovision exactly.
# 2) Check scheme name is correct.
# 3) Update variable.
#
#   Usage: ./autoarchive.sh -t Development | ./autoarchive.sh -t Enterprise


projectName="QSArchiveTest"

# four types
development="Development"
enterprise="Enterprise"
appstore="AppStore"
adhoc="AdHoc"

#Enterprise CA certificate name and mobileprovision uuid
enterpriseCodeSignIdentity="iPhone Distribution: Industrial Bank Co., Ltd."
#uuid
enterpriseProvisioningProfile="272bb89b-7f2e-4aaf-9634-b7bd69ed7833"
#Development CA certificate name and mobileprovision uuid
developmentCodeSignIdentity="iPhone Developer: Guo Shaoqing (CYXM98D895)"
#uuid
developmentProvisioningProfile="35b8e6e5-6fbb-41f1-8975-cf44d63d8b27"
#AdHoc CA certificate name and mobileprovision uuid
adhocCodeSignIdentity=""
adhocProvisioningProfile=""
#AppStore CA certificate name and mobileprovision uuid
appstoreCodeSignIdentity="iPhone Distribution: Guo Shaoqing (ZYDXKQKHVY)"
appstoreProvisioningProfile="e40d0608-b291-4f33-a187-31bed4247db7"

#Apple ID if needed
appleid="cibemobile@126.com"
applepassword="Cibemobile2016"

if [ $# -lt 1 ];then
echo "Error! Should enter the archive type (Development or AppStore or Enterprise)."
echo ""
exit 2
fi

while getopts 't:' optname
do
    case "$optname" in
    t)
        if [ ${OPTARG} != $development ] && [ ${OPTARG} != $enterprise ] && [ ${OPTARG} != $adhoc ] && [ ${OPTARG} != $appstore ] ;then
            echo "Usage: -t [Development|Enterprise|AdHoc|AppStore]"
            echo ""
        exit 1
        fi
        type=${OPTARG}
        ;;
    *)
    echo "Error! Unknown error while processing options"
    echo ""
    exit 2
    ;;
    esac
done

#current dir
basepath=$(cd `dirname $0`; pwd)
myFile="autobuild"

#use -f to check whether $myFile exist
#PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin
#export PATH
#if [ ! -f "$myFile" ]; then
#　　/bin/mkdir -p "$myFile"
#else
#    echo "dir exist"
#fi


#log path
log_path="autobuild/log.txt"
#build mode
configuration="Release"
#project name
workspaceName="${projectName}.xcodeproj"
#scheme name(maybe )
scheme=$projectName
#build path
configurationBuildDir="autobuild/build"
#value for CA certificate type
scheme="${projectName}_${type}"
if [ $type == $enterprise ]; then
    codeSignIdentity=$enterpriseCodeSignIdentity
    provisioningProfile=$enterpriseProvisioningProfile
elif [ $type == $development ]; then
    codeSignIdentity=$developmentCodeSignIdentity
    provisioningProfile=$developmentProvisioningProfile
elif [ $type == $appstore ]; then
    codeSignIdentity=$appstoreCodeSignIdentity
    provisioningProfile=$appstoreProvisioningProfile
elif [ $type == $adhoc ];then
    codeSignIdentity=$adhocCodeSignIdentity
    provisioningProfile=$adhocProvisioningProfile
fi

#archive name and path
archivePath="autobuild/archive/${projectName}.xcarchive"
#ipa path
qs_date=`date +%Y_%m_%d_%H_%M_%S`
#ipa name and export path
exportPath="${basepath}/autobuild/ipa/${projectName}_$qs_date"
#export options
exportOptionsPlist="autobuild/${type}ExportOptions.plist"
#validate ipa
ipaPath="${exportPath}/${scheme}.ipa"


#clean project
function clean(){
    echo "\033[31mStart clean!\033[0m"
    rm -f $log_path
    xcodebuild clean -configuration "$configuration" >> $log_path || exit
    echo "\033[31mClean success!\033[0m"
}

function archive () {
    echo "\033[31mStart archive!\033[0m"
    xcodebuild archive -project "$workspaceName"  -scheme "$scheme" -configuration "$configuration" -archivePath "$archivePath" CONFIGURATION_BUILD_DIR="$configurationBuildDir" CODE_SIGN_IDENTITY="$codeSignIdentity" PROVISIONING_PROFILE="$provisioningProfile" >> $log_path || exit
    echo "\033[31mArchive success!\033[0m"
}

function exportArchive(){
    echo "\033[31mStart export ipa!\033[0m"
    xcodebuild -exportArchive -archivePath "${archivePath}" -exportOptionsPlist "${exportOptionsPlist}" -exportPath "${exportPath}" >> $log_path || exit
    echo "\033[31mExport ipa success,ipa exportPath is：\n ${exportPath}\033[0m"
    open ${exportPath}
}

function installIpa(){
    #a list of attached devices
    echo "\033[31mCurrent attached devices is(UDID):\033[1m"
    idevice_id -l
    echo "Start install ipa to attached device!"
    echo "\033[31m\033[0m"
    ideviceinstaller -i "${exportPath}/${scheme}.ipa"
}

function uploadIpa(){
    #upload iTunesConnect
    osascript -e 'display notification "Start release To AppStore" with title "Validate Start!"'
    altoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"

    #validate
    "$altoolPath" --validate-app -f "$ipaPath" -u "$appleid" -p "$applepassword" -t ios --output-format xml
    osascript -e 'display notification "Release To AppStore" with title "Validate Complete!"'

    #upload
    "$altoolPath" --upload-app -f "$ipaPath" -u "$appleid" -p "$applepassword" -t ios --output-format xml
    osascript -e 'display notification "Release To AppStore" with title "Upload Complete!"'
}

clean

archive

exportArchive

if [ $type == $appstore ]; then
    uploadIpa
else
    installIpa
fi
