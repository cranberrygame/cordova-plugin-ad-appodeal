//Copyright (c) 2014 Sang Ki Kwon (Cranberrygame)
//Email: cranberrygame@yahoo.com
//Homepage: http://cranberrygame.github.io
//License: MIT (http://opensource.org/licenses/MIT)
#import <Cordova/CDV.h>
//
#import <AppodealAds/Appodeal.h>

@interface AppodealPlugin : CDVPlugin <AODAdViewDelegate, AODInterstitialDelegate, AODVideoAdDelegate>

@property NSString *callbackIdKeepCallback;
//
@property NSString *email;
@property NSString *licenseKey_;
@property BOOL validLicenseKey;
//
@property NSString *applicationKey;
@property BOOL isOverlap;
@property BOOL isTest;
//
@property NSString *bannerPreviousPosition;
//
@property BOOL bannerAdPreload;
@property BOOL fullScreenAdPreload;
@property BOOL rewardedVideoAdPreload;
//
@property AODAdView *bannerView;

- (void) setLicenseKey: (CDVInvokedUrlCommand*)command;
- (void) setUp:(CDVInvokedUrlCommand*)command;
- (void) preloadBannerAd: (CDVInvokedUrlCommand*)command;
- (void) showBannerAd: (CDVInvokedUrlCommand*)command;
- (void) reloadBannerAd: (CDVInvokedUrlCommand*)command;
- (void) hideBannerAd: (CDVInvokedUrlCommand*)command;
- (void) preloadFullScreenAd:(CDVInvokedUrlCommand*)command;
- (void) showFullScreenAd:(CDVInvokedUrlCommand*)command;
- (void) preloadRewardedVideoAd:(CDVInvokedUrlCommand*)command;
- (void) showRewardedVideoAd:(CDVInvokedUrlCommand*)command;

@end
