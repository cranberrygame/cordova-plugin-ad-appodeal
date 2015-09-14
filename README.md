Cordova Appodeal plugin
====================
# Overview #
show appodeal banner ad, full screen ad and rewarded video ad.

[android, ios] [cordova cli] [xdk] [cocoon] [phonegap build service]

requires appodeal account http://appodeal.com/+6ba27c77d92d2eb5cdbb47ee677b1c83

[Appodeal android SDK 1.12.2]<br>
[Appodeal ios SDK 0.2.3]

This is open source cordova plugin.

You can see Plugins For Cordova in one page: http://cranberrygame.github.io?referrer=github

# Change log #
```c

To-Do:
	Support test mode on android.
	Support split mode on both android and ios.
```
# Install plugin #

## Cordova cli ##
https://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-Line%20Interface - npm install -g cordova@5.0.0
```c
cordova plugin add cordova-plugin-ad-appodeal
(when build error, use github url: cordova plugin add cordova plugin add https://github.com/cranberrygame/cordova-plugin-ad-appodeal)
```

## Xdk ##
https://software.intel.com/en-us/intel-xdk - Download XDK - XDK PORJECTS - [specific project] - CORDOVA HYBRID MOBILE APP SETTINGS - Plugins - Third Party Plugins - Add a Third Party Plugin - Get Plugin from the Web -
```c
Name: appodeal
Plugin ID: cordova-plugin-ad-appodeal
[Do not check] Plugin is located in the Apache Cordova Plugins Registry
Repo URL: https://github.com/cranberrygame/cordova-plugin-ad-appodeal
```

## Cocoon ##
https://cocoon.io - Create project - [specific project] - Setting - Plugins - Custom - Git Url: https://github.com/cranberrygame/cordova-plugin-ad-appodeal.git - INSTALL - Save<br>

## Phonegap build service (config.xml) ##
https://build.phonegap.com/ - Apps - [specific project] - Update code - Zip file including config.xml
```c
<gap:plugin name="cordova-plugin-ad-appodeal" source="npm" />
```

## Construct2 ##
Download construct2 plugin<br>
https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/index.html<br>
How to install c2 native plugins in xdk, cocoon and cordova cli<br>
https://plus.google.com/102658703990850475314/posts/XS5jjEApJYV

# Server setting #
```c
```

<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-appodeal/master/doc/applicationKey.png">

# API #
```javascript
var applicationKey = "REPLACE_THIS_WITH_YOUR_APPLICATION_KEY";//requires appodeal account http://appodeal.com/+6ba27c77d92d2eb5cdbb47ee677b1c83
var isOverlap = true; //true: overlap, false: split
var isTest = true;
/*
var applicationKey;
var isOverlap = true; //true: overlap, false: split
var isTest = true;
//android
if (navigator.userAgent.match(/Android/i)) {
	applicationKey = "REPLACE_THIS_WITH_YOUR_APPLICATION_KEY";
}
//ios
else if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
	applicationKey = "REPLACE_THIS_WITH_YOUR_APPLICATION_KEY";
}
*/

document.addEventListener("deviceready", function(){
	//if no license key, 2% ad traffic share for dev support.
	//you can get paid license key: https://cranberrygame.github.io/request_cordova_ad_plugin_paid_license_key
	//window.appodeal.setLicenseKey("yourEmailId@yourEmaildDamin.com", "yourLicenseKey");
	
	window.appodeal.setUp(applicationKey, isOverlap, isTest);

	//
	window.appodeal.onBannerAdLoaded = function() {
		alert('onBannerAdLoaded');
	};
	window.appodeal.onBannerAdShown = function() {
		alert('onBannerAdShown');
	};
	window.appodeal.onBannerAdHidden = function() {
		alert('onBannerAdHidden');
	};
	//
	window.appodeal.onFullScreenAdLoaded = function() {
		alert('onFullScreenAdLoaded');
	};
	window.appodeal.onFullScreenAdShown = function() {
		alert('onFullScreenAdShown');
	};
	window.appodeal.onFullScreenAdHidden = function() {
		alert('onFullScreenAdHidden');
	};
	//
	window.appodeal.onRewardedVideoAdLoaded = function() {
		alert('onRewardedVideoAdLoaded');
	};
	window.appodeal.onRewardedVideoAdShown = function() {
		alert('onRewardedVideoAdShown');
	};
	window.appodeal.onRewardedVideoAdHidden = function() {
		alert('onRewardedVideoAdHidden');
	};	
	window.appodeal.onRewardedVideoAdCompleted = function() {
		alert('onRewardedVideoAdCompleted');
	};	
}, false);
	
/*
position: 'top-left', 'top-center', 'top-right', 'left', 'center', 'right', 'bottom-left', 'bottom-center', 'bottom-right'
*/
window.appodeal.showBannerAd('top-center');
window.appodeal.showBannerAd('bottom-center');
window.appodeal.reloadBannerAd();
window.appodeal.hideBannerAd();

window.appodeal.showFullScreenAd();

window.appodeal.showRewardedVideoAd();

alert(window.appodeal.loadedBannerAd());//boolean: true or false
alert(window.appodeal.loadedFullScreenAd());//boolean: true or false
alert(window.appodeal.loadedRewardedVideoAd());//boolean: true or false

alert(window.appodeal.isShowingBannerAd());//boolean: true or false
alert(window.appodeal.isShowingFullScreenAd());//boolean: true or false
alert(window.appodeal.isShowingRewardedVideoAd());//boolean: true or false
```
# Examples #
<a href="https://github.com/cranberrygame/cordova-plugin-ad-appodeal/blob/master/example/basic/index.html">example/basic/index.html</a><br>

# Test #

[![](http://img.youtube.com/vi/wOmHRtFTXc4/0.jpg)](https://www.youtube.com/watch?v=wOmHRtFTXc4&feature=youtu.be "Youtube")

You can also run following test apk.
https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/appodeal/apk.html

# Useful links #

Plugins For Cordova<br>
http://cranberrygame.github.io?referrer=github

# Credits #

https://github.com/appodeal/Appodeal-PhoneGap-plugin
