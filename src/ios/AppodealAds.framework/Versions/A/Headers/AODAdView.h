//
//  AODAdView.h
//  AppodealAds
//
//  Created by supergoodd on 4/7/15.
//  Copyright (c) 2015 if3. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _aodBannerType {
    kAODBannerPortraitTop,
    kAODBannerPortraitBottom,
    kAODBannerLandscapeTop,
    kAODBannerLandscapeBottom,
} AODBannerType;

@class AODAdRequestConfig;
@class AODAdView;

@protocol AODAdViewDelegate <NSObject>

@required

- (UIViewController *)viewControllerForPresentingModalView;

@optional

- (void)adViewDidLoadAd:(AODAdView *)view;
- (void)adViewDidFailToLoadAd:(AODAdView *)view;
- (void)willPresentModalViewForAd:(AODAdView *)view;
- (void)didDismissModalViewForAd:(AODAdView *)view;
- (void)willLeaveApplicationFromAd:(AODAdView *)view;

@end

@interface AODAdView : UIView

- (id)initWithBannerType:(AODBannerType)bannerType;
- (id)initWithAdRequestConfig:(AODAdRequestConfig*)rconf;

@property (nonatomic, weak) id<AODAdViewDelegate> delegate;

@property (nonatomic, copy) UIViewController* rootController;

@property (nonatomic, assign, getter = isTesting) BOOL testing;
@property (nonatomic, assign) BOOL ignoresAutorefresh;

- (void)loadAd;
- (void)cache;
- (void)refreshAd;
- (void)forceRefreshAd;
- (CGSize)adContentViewSize;
- (void)hide;
- (void)show;
- (void)destroy;
- (void)orientationChange:(UIInterfaceOrientation)newOrientation;

/*!
 @abstract
 Disable ad network for banner ads
 
 @param adName You can disable following ad network: admob, smaato, amazon_ads, applovin, appnexus, mopub, mraid, nexage, openx, tapsense.
 @discussion This method must be executed after Appodeal initialization.
 */
- (void)disableAdBannerNetwork:(NSString*)adName;
/*!
 @abstract
 Disable banner auto refresh
 
 @discussion This method must be executed after Appodeal initialization.
 */
- (void)disableAutoRefresh;

/*!
 @abstract
 Set auto auto cache
 
 @param autoCache You can disable auto cache banners from servers.
 @discussion This method must be executed after Appodeal initialization.
 */
- (void)setAutoCache:(BOOL)autoCache;
/*!
 @abstract
 Check banner load
 
 @discussion This method must be executed after Appodeal initialization.
 */
- (BOOL)isLoaded;

@end