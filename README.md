Cordova Appodeal plugin
====================
# Overview #
show appodeal banner ad, full screen ad and rewarded video ad.

[android, ios] [cordova cli] [xdk]

requires appodeal account http://appodeal.com/+6ba27c77d92d2eb5cdbb47ee677b1c83

<Appodeal android SDK 1.12.2>
appodeal-1.12.2.jar
applovin-sdk-5.4.3.jar
chartboost-5.2.0.jar
supersonic-sdk-5.14.jar
unity-ads-1.3.12.jar

<Appodeal ios SDK 0.1.6>
AppodealAds.framework (0.1.6)
AmazonAd.framework
Chartboost.framework (5.1.3)
GoogleMobileAds.framework (7.2.2)
MoPub.framework (3.5.0) (need to check)
UnityAds.framework
Applovin 2.5.4 (need to check)

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
https://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-Line%20Interface - npm install -g cordova@4.1.2
```c
cordova plugin add com.cranberrygame.cordova.plugin.ad.appodeal
```

## Xdk ##
https://software.intel.com/en-us/intel-xdk - Download XDK - XDK PORJECTS - [specific project] - CORDOVA 3.X HYBRID MOBILE APP SETTINGS - PLUGINS - Third Party Plugins - Add a Third Party Plugin - Get Plugin from the Web -
```c
Name: appodeal
Plugin ID: com.cranberrygame.cordova.plugin.ad.appodeal
[v] Plugin is located in the Apache Cordova Plugins Registry
```

## Cocoon ##
https://cocoon.io - Create project - [specific project] - Setting - Plugins - Search - cranberrygame - appodeal

## Phonegap build service (config.xml) ##
https://build.phonegap.com/ - Apps - [specific project] - Update code - Zip file including config.xml
```c
<gap:plugin name="com.cranberrygame.cordova.plugin.ad.appodeal" source="plugins.cordova.io" />
```

## Construct2 ##
Download construct2 plugin: http://www.paywithapost.de/pay?id=4ef3f2be-26e8-4a04-b826-6680db13a8c8
<br>
Now all the native plugins are installed automatically: https://plus.google.com/102658703990850475314/posts/XS5jjEApJYV
# Server setting #
```c
```

<img src="https://github.com/cranberrygame/cordova-plugin-ad-appodeal/blob/master/doc/applicationKey.png">

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
	//you can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova
	//window.appodeal.setLicenseKey("yourEmailId@yourEmaildDamin.com", "yourFreeLicenseKey");
	
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
