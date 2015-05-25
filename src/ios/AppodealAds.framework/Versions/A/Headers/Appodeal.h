//
//  Appodeal.h
//  Appodeal_iOS_SDK
//
//  Created by supergoodd on 3/5/15.
//  Copyright (c) 2015 if3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AppodealAds/AODAdView.h>

@protocol AODInterstitialDelegate <NSObject>

@optional
/*!
 @abstract
 Called before an interstitial will be displayed on the screen.
 */
- (void)onInterstitialAdLoaded:(NSString*)adName isPrecache:(BOOL)isPrecache;
/*!
 @abstract
 Called after an interstitial has attempted to load from the Appodeal API
 servers but failed.
 */
- (void)onInterstitialAdFailedToLoad:(NSString*)adName;
/*!
 @abstract
 Called after an interstitial has been displayed on the screen.
 */
- (void)onInterstitialAdShown:(NSString*)adName;
/*!
 @abstract
 Called after an interstitial has been clicked.
 */
- (void)onInterstitialAdClicked:(NSString*)adName;
/*!
 @abstract
 Called after an interstitial has been closed or dismissed.
 */
- (void)onInterstitialAdClosed:(NSString*)adName;

@end

@protocol AODAdBannerDelegate <NSObject>

@optional
/*!
 @abstract
 Called before an ad banner view will be displayed on the screen.
 */
- (void)onAdBannerLoaded;
/*!
 @abstract
 Called after an ad banner view has attempted to load from the Appodeal API
 servers but failed.
 */
- (void)onAdBannerFailedToLoad;
/*!
 @abstract
 Called after an ad banner view has been displayed on the screen.
 */
- (void)onAdBannerShown;
/*!
 @abstract
 Called after an ad banner view has been clicked.
 */
- (void)onAdBannerClicked;
/*!
 @abstract
 Called after an ad banner view has been closed or dismissed.
 */
- (void)onAdBannerClosed;

@end

@protocol AODVideoAdDelegate <NSObject>

@optional
- (void)onVideoAdDidLoad:(NSString*)adName;
- (void)onVideoAdDidFailToLoad:(NSString*)adName;
- (void)onVideoAdDidExpire:(NSString*)adName;
- (void)onVideoAdDidFailToPlay:(NSString*)adName;
- (void)onVideoAdDidAppear:(NSString*)adName;
- (void)onVideoAdDidDisappear:(NSString*)adName;
- (void)onVideoAdDidReceiveTapEvent:(NSString*)adName;
- (void)onVideoAdShouldRewardUser:(NSString*)adName reward:(int)amount;

@end

/*!
 @class Appodeal
 
 @abstract
 Provide methods to display and control Appodeal many advertising types.
 
 @discussion For more information on integrating and using the Appodeal SDK
 please visit our help site documentation at http://appodeal.com
 */
@interface Appodeal : NSObject

+ (instancetype) alloc __attribute__((unavailable("alloc not available, call initWithAppId instead")));
- (instancetype) init __attribute__((unavailable("init not available, call initWithAppId instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call initWithAppId instead")));
+ (instancetype)initWithAppId:(NSString*)appId;
/*!
 @abstract
 Start Appodeal with required appId and delegate.
 
 @param appId appId The Appodeal application ID for this application. 
 @param delegate The delegate instance to receive Appodeal SDK callbacks.
 @discussion This method must be executed before any other Appodeal SDK methods can be used.
 */
+ (instancetype)initWithAppId:(NSString*)appId delegate: (id<AODInterstitialDelegate>) delegate;

// for Interstitial Ad
+ (void)showInterstitial:(UIViewController*)rootController;
+ (BOOL)isInterstitialLoaded;
+ (void)setInterstitialDelegate:(id<AODInterstitialDelegate>) delegate;

// for AdBanner
+ (BOOL)isAdBannerLoaded;

// for Video Ad
+ (void)showVideoOrInterstitialAd:(UIViewController*)rootController;
+ (void)showVideoAd:(UIViewController*)rootController;
+ (BOOL)isVideoAdReady;
+ (void)setVideoAdDelegate:(id<AODVideoAdDelegate>) delegate;

/*!
 @abstract
 Set AODAdBannerDelegate delegate

 @param delegate The delegate instance to receive AODAdBanner callbacks.
 @discussion This method must be executed before used AODAdBanner callbacks.
 */
+ (void)setAdBannerDelegate:(id<AODAdBannerDelegate>) delegate __attribute__((unavailable("deprecated, please use AODAdView for banner")));
/*!
 @abstract
 Set rootViewController and AODAdBannerDelegate delegate
 
 @param rootViewController Required reference to the current root view controller.
 @param delegate The delegate instance to receive AODAdBanner callbacks.
 @discussion This method must be executed before used banner view and callbacks.
 */
+ (void)setAdBannerInViewController:(UIViewController*)rootViewController delegate:(id<AODAdBannerDelegate>)delegate __attribute__((unavailable("deprecated, please use AODAdView for banner")));
/*!
 @abstract
 Pin adBanner at bottom of the screen
 */
+ (void)pinAdBannerAtBottomOfScreen __attribute__((unavailable("deprecated, please use AODAdView for banner")));
/*!
 @abstract
 Pin adBanner at top of the screen
 */
+ (void)pinAdBannerAtTopOfScreen __attribute__((unavailable("deprecated, please use AODAdView for banner")));

/*!
 @abstract
 Set Testing mode
 */
+ (void)setTesting:(BOOL)testing;

/*!
 @abstract
 Disable interstitial ads networks
 
 @param adName You can disable following ad networks: admob, chartboost, smaato, amazon_ads, applovin, appnexus, mopub, mraid, nexage, openx, tapsense.
@discussion This method must be executed before Appodeal intialization.
 */
+ (void)disableInterstitialAdNetworks:(NSArray*)adNames;

// for debug app
+ (NSArray*)getCachedAds;
+ (void)setAdsToLoad:(int)adIdx;
+ (void)setServer:(int)idx;

@end
