//
//  ASViewController.h
//  AerServSDK
//
//  Created by Scott A Andrew on 3/24/14.
//  Copyright (c) 2014 AerServ, LLC. All rights reserved.
//
/*! @header
 * View controller used to display an ad
 */

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol ASInterstitialViewControllerDelegate;

/*!
 * @class ASInterstitialViewController
 *
 * The `ASInterstitialViewController` class provides a full-screen advertisement.
 */
@interface ASInterstitialViewController : UIViewController

/*! The delegate that recieves controller state changes */
@property (readonly, nonatomic, weak) id<ASInterstitialViewControllerDelegate> delegate;

/*! Returns the placement ID*/
@property (readonly, nonatomic, copy) NSString* placementID;

/*! Returns if the ad is ready to be displayed or not*/
@property (readonly, nonatomic, assign) BOOL isReady;

/*! A flag that tells the app to point to a live or staging server.
 *
 * Remember to set this to FALSE before production builds.
 */
@property (nonatomic, assign) BOOL isTesting;

/*!
 * If set to YES the ads are in preload mode and will attempt to preload when loadAd is called
 */
@property (nonatomic, assign) BOOL isPreload;

/*!
 * An optional seet of keywords that should be passe to the ad server to recieve
 * more relevant advertising.
 *
 */
@property (nonatomic, strong) NSArray* keyWords;

/*!
 * If set to YES the ads are outlined in red. Remember to set
 * to NO for production builds.
 */
@property (nonatomic, assign) BOOL showOutline;

/*!
 * The number of seconds before loading the ad should timeout.
 * Ad will send intersitialViewControllerAdFailedToLoad:withError: message on timeout.
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/*!
 * Returns an interstitial ad for the given ID.
 *
 * This will create a new full screen view controller for the given placement ID. If this
 * is called again before the controller is destroyed then a cached object for that ID is
 * returned. The view controller is uncached when the controller is destroyed.
 *
 * There can only be one controller for an ID at a time
 *
 * @param placementID An ID that identifies the placement to show.
 */
+(instancetype) viewControllerForPlacementID:(NSString*)placementID withDelegate:(id<ASInterstitialViewControllerDelegate>)delegate;

/*!
 * Begins loading the ad from the server.
 *
 * The delegate should implement interstitialViewControllerAdLoadedSuccssfully to know if an ad has loaded
 * sucessfully. interstitialViewControllerAdFailedToLoad:withError will be called if there is an error loading
 * an ad.
 *
 */
-(void) loadAd;


/*!
 * Presents the ad's view controller on the parent view controller modally.
 *
 * If there is no ad to display the user will be presented with a spinner until the ad
 * loads.
 */
-(void) showFromViewController:(UIViewController*)parentViewController;

- (void) pause;
- (void) play;

@end

/*!
 * The protocol is implemented to watch for ASInterstitialViewController state chages.
 */
@protocol ASInterstitialViewControllerDelegate<NSObject>

/*!
 * Called when the ad has loaded successfuly. 
 * 
 * @param viewController The view controller that the ad is displayed on.
 */
- (void)interstitialViewControllerAdLoadedSuccessfully:(ASInterstitialViewController *)viewController;

/*!
 * Called when the ad failed has failed to load.
 * 
 * @param viewController The view controller that attempted to load the ad.
 * @param error The error that caused the load to fail.
 */
- (void)intersitialViewControllerAdFailedToLoad:(ASInterstitialViewController *)viewController withError:(NSError *)error;

@optional

/*!
 * Called just before the view appears
 * 
 * @param viewController The view controller whose view is about to appear.
 */
- (void)intersitialViewControllerWillAppear:(ASInterstitialViewController *)viewController;

/*!
 * Called just after the view controller's view appears.
 *
 * @param viewController The view controller whose view appeared.
 */
- (void)intersitialViewControllerDidAppear:(ASInterstitialViewController *)viewController;

/*!
 * Called just before the view is dismissed
 *
 * @param viewController The view controller whose view is about to be dismissed.
 */
- (void)interstitialViewControllerWillDisappear:(ASInterstitialViewController *)viewController;

/*!
 * Called just after the view is dismissed
 *
 * @param viewController The view controller whose view was dismissed.
 */
- (void)interstitialViewControllerDidDisappear:(ASInterstitialViewController *)viewController;

/*!
 * Called when an ad has expired. One action may be to call load ad again to load the new ad.
 *
 * @param viewController The view controller whose as has expired.
 */
- (void)interstitialViewControllerAdExpired:(ASInterstitialViewController *)viewController;

/*!
 * Called when an ad has been touched.
 *
 * @param viewController The view controller whose as has expired.
 */
- (void)interstitialViewControllerAdWasTouched:(ASInterstitialViewController *)viewController;

/*!
 * This called when the ad has preloaded
 *
 * @param adView - The ad that preloaded.
 */
- (void)adViewDidPreloadAd:(ASInterstitialViewController *)viewController;

/*!
 * This called when an ad with a virtual currency reward has loaded
 *
 * @param adView - The ad that loaded with virtual currency enabled.
 * @param vcData - A dictionary containing the virtual currency data; contains "name" and "rewardAmount" keys
 */
- (void)adViewDidVirtualCurrencyLoad:(ASInterstitialViewController *)viewController vcData:(NSDictionary *)vcData;

/*!
 * This called when an ad with a virtual currency reward has been rewarded
 *
 * @param adView - The ad that completed with virtual currency being rewarded
 * @param vcData - A dictionary containing the virtual currency data; contains "name" and "rewardAmount" keys
 */
- (void)adViewDidVirtualCurrencyReward:(ASInterstitialViewController *)viewController vcData:(NSDictionary *)vcData;


@end
