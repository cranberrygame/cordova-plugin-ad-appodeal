//
//  ASAdView.h
//  AerServSDK
//
//  Created by Scott A Andrew on 4/9/14.
//  Copyright (c) 2014 AerServ, LLC. All rights reserved.
//
/*! @header
 * View that contains a banner ad.
 */

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol ASAdViewDelegate;

/*! @name
 * Common banners sizes
 */

/*!
 *  320x50 banner size
 */
extern const CGSize ASBannerSize;

/*!
 *  320x100 banner size
 */
extern const CGSize ASLargeBannerSize;

/*!
 * 300x240 banner size.
 */
extern const CGSize ASMediumRectSize;

/*!
 * 728x90 banner size.
 */
extern const CGSize ASLeaderBoardSize;

/*!
 * 728x90 banner size.
 */
extern const CGSize ASWideSkypscraperSize;

/*!
 * @class ASAdView
 *
 * The `ASAdView` class provides a view that contains a banner ad.
 */
@interface ASAdView : UIView

/*! 
 * The delegate of the ad view
 */
@property (nonatomic, weak) id<ASAdViewDelegate> delegate;

/*!
 * The placement ID of the ad to display.
 */
@property (nonatomic, copy) NSString* placementID;

/*! 
 * An optional seet of keywords that should be passe to the ad server to recieve
 * more relevant advertising.
 * 
 */
@property (nonatomic, strong) NSArray* keyWords;

/*!
 * A core location object represening the uers location that should be passed to the server
 * to recieve more relevant ads. If this is not set the users current location is used.
 */
@property (nonatomic, copy) CLLocation* location;

/*!
 * If set to YES the ads are in testing mode and pulled form the staging server.
 * to recieve more relevant ads. If this is not set the users current location is used.
 */
@property (nonatomic, assign) BOOL isTesting;

/*!
 * If set to YES the ads are in preload mode and will attempt to preload when loadAd is called
 */
@property (nonatomic, assign) BOOL isPreload;

/*!
 * If set to YES the ads are outlined in red. Remember to set
 * to NO for production builds.
 */
@property (nonatomic, assign) BOOL outlineAd;

@property (nonatomic, assign) BOOL sizeAdToFit;

/*!
 * The number of seconds before loading the ad should timeout.
 * Ad will send adViewDidFailToLoadAd:withError: message on timeout.
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/*! 
 * Initializes an the view with the given ad ID and banner size.
 * 
 * @param placementID the ID of the ad to display.
 * @param size the desired ad size.
 * @return the view the ad will be placed in.
 */
-(id) initWithPlacementID:(NSString*)placementID size:(CGSize)size;

/*!
 * Requests a new ad from the server. If an ad is already loading
 * this call will be ignored. You can use 'forceRefreshAd' to force cancle
 * any existing ad requests and force a new ad to load.
 */
-(void) loadAd;


/*!
 * Cancels any exiting ad requests and requests a new ad from the server.
 */
-(void) forceRefreshAd;

/*!
 * Returns the size of the actual ad that was fetched. 
 *
 * Ad sizes can very between the different ad networks. This is the actual size
 * of the underlying mediated ad. You can use this to adjust the ad view size and 
 * adjust accordingly.
 * 
 * @return The size of the underlying mediated ad.
 */
-(CGSize) adContentSize;

/*!
 * Turns off auto refreshing the banner ad.
 *
 * Ads by default auto refresh every 30 seconds. This will turn the
 * automatic refreshing. Make sure to call startAutomaticallyRefresingContents
 * to re start the auto refresh.
*
 */
-(void) stopAutomaticallyRefreshingContents;

/*!
 * Turns on auto refreshing the banner ad.
 *
 * This turns on the auto refresh for banner ads. To disable you can
 * call stopAutomaticallyRefreshingConetnts.
 */
-(void) startAutomaticallyRefreshingContents;

/*!
 * rotateToOrientation
 *
 * Call this when your view's orientation changes. Some adds may display
 * differently based on rotation.
 *
 * @param newOrientation - the devices current orientation.
 */
-(void) rotateToOrientation:(UIInterfaceOrientation)newOrientation;

-(void) play;
-(void) pause;

@end
/*!
 * The protocol is implemented to watch for ASAdView state changes and provide the view controller
 * for modal view presentation.
 */
@protocol ASAdViewDelegate <NSObject>

/*!
 * The view controller that can be used to present modal view controllers. Like the web
 * brwoser. This must be impletmented.
 *
 * @return the view controller to use when the add needs to present a modal view.
 */
- (UIViewController *)viewControllerForPresentingModalView;

@optional
/*!
 * This called when the ad has been fully loaded.
 *
 * @param adView - The ad that has been loaded.
 */
- (void)adViewDidLoadAd:(ASAdView *)adView;

/*!
 * This called when the ad has failed to load.
 *
 * @param adView - The ad that failed.
 */
- (void)adViewDidFailToLoadAd:(ASAdView *)adView withError:(NSError *)error;


/*!
 * This called when the ad has preloaded
 *
 * @param adView - The ad that preloaded.
 */
- (void)adViewDidPreloadAd:(ASAdView *)adView;

/*!
 * This called when the ad is about to present a modal fullscreen view.
 *
 * @param adView - The ad that is presenting the modal fullscreen view.
 */
- (void)willPresentModalViewForAd:(ASAdView *)adView;

/*!
 * Called when the ad's modal view has been dismissed.
 *
 * @param adView - The ad that was displaying the modal view.
 */
- (void)didDismissModalViewForAd:(ASAdView *)adView;

/*!
 * This called when the app is about to the leave the application after
 * ad is clicked.
 *
 * @param adView - The ad that was clicked.
 */
- (void) willLeaveApplicatonFromAd:(ASAdView *)adView;

/*!
 * This is called when the size of the ad changes. For example a VAST ad that a playlist with
 * multiple elemnts of different sizes.
 *
 * @param adView - The ad that was clicked.
 */
- (void) adSizedChanged:(ASAdView *)adView;

/*!
 * This is called when the ad is clicked on.
 *
 * @param adView - The ad that was clicked.
 */
- (void) adWasClicked:(ASAdView *)adView;


@end
