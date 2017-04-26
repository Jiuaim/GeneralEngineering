#!/bin/sh

#xcrun: error: unable to find utility "PackageApplication", not a developer tool or in PATH
	#goto /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/
	#copy  PackageApplication here
	#sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer/
	#chmod +x /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/PackageApplication

# 当前路径()
#currentPath=$(pwd)
#cd $currentPath

#项目路径
projectPath=$(cd `dirname $0`; pwd)
cd $projectPath

#打包输出路径
out_path=~/Desktop/test

#version
patient_version="4.5.0"

#workspace
workspace_name="test"

#scheme
patient_scheme="test"

#sdk
SDK="iphoneos"

#configuration
stage_configuration="Debug"
online_configuration="Release"

#profile
patient_develop_profile="描述文件名"

#证书
develop_code_sign_identity="证书名"

#fir token
stage_token="fir的token"

#build Path 
build_path=${out_path}/${patient_scheme}_build
#app Path
app_path=${build_path}/${patient_scheme}.app
#ipa_path
date=`date '+%Y年%m月%d日%H:%M:%S'`
ipa_path=${out_path}/${patient_scheme}_${patient_version}_${date}.ipa
{}
xcodebuild clean -workspace $workspace_name.xcworkspace -scheme $patient_scheme -configuration $stage_configuration

xcodebuild -workspace $workspace_name.xcworkspace -scheme $patient_scheme -configuration $stage_configuration -sdk $SDK CODE_SIGN_IDENTITY="$develop_code_sign_identity" PROVISIONING_PROFILE="$patient_develop_profile" CONFIGURATION_BUILD_DIR="$build_path" build

xcrun -sdk $SDK PackageApplication -v "$app_path" -o "$ipa_path"

rm -rf ${build_path}

fir publish ${ipa_path} -T $stage_token &
