# Appodeal iOS SDK 
*0.2.0*

The Appodeal iOS SDK is a mediation network. It
provides the functionality for showing interstitials, banner and video ads.

## Requirements
Appodeal iOS SDK works on >= iOS 6.0 version and is compatible with both ARC and non-ARC projects. It depends (Project Settings -> Build Phases -> Link Binary With Libraries) on the following Apple frameworks:

* AdSupport
* AVFoundation
* AudioToolbox
* CoreTelefony
* CoreGraphics
* EventKit
* EventKitUI
* MessageUI
* StoreKit
* SystemConfiguration
* CoreLocation
* UIKit
* CoreMedia
* MediaPlayer
* QuartzCore
* CoreImage
* CoreFoundation
* libz.dylib
* Social
* WebKit
* libsqlite3.dylib
* CFNetwork

You will need the latest developer tools in order to build Appodeal iOS SDK. Old Xcode versions might work, but compatibility will not be explicitly maintained.

## Adding Appodeal iOS SDK to your project

### Static library

You can also add Appodeal iOS SDK as a static library to your project or workspace. 

1. Download the [latest ios sdk version](http://dl.dropbox.com/s/didmniwmtgudlbu/Appodeal-iOS-SDK_0.1.1.zip) and extract Appodeal iOS SDK.
2. Open your project in Xcode, then drag and drop `AppodealAds` folder onto your project or workspace (use the "Product Navigator view") and choose "Copy items into destination group's folder and click Finish".  

![](http://dl.dropbox.com/s/8z80aridd4gqxub/Screen%20Shot%202015-04-23%20at%204.30.58%20PM.png)

3. Linker Flags: Click Project -> Build Settings -> Search for other linker flags -> Add "-ObjC"

![](http://dl.dropbox.com/s/bqlv32995a4t164/Screen%20Shot%202015-04-23%20at%204.38.45%20PM.png)

## For Applications that use MRC

If your application uses Manual Reference Counting (MRC) you must tell the compiler to build the MoPub iOS SDK source files with ARC. This has no impact on your application and can be done relatively easily:

First, click on your application's target, then click on Build Phases and expand the Compile Sources group. Now select all the MoPubSDK source files. These will be grouped together near the end if you have recently dragged the SDK in.

Once the files are selected scroll down and double click on the last file. You should see a blank popup appear. Enter `-fobjc-arc` and hit return. This should add the `-fobjc-arc` flag to all the selected files.

## AppLovin Integration
Add Your AppLovin SDK Key.

Project Settings -> Info, click on one of the rows of Custom iOS Properties and click the + to add a new row. The key of the new row key should be AppLovinSdkKey and the value: "TA7nlRNu4oiZ7PWQ-ip1L4dWvS3ZNwkw5rhqG3hLrOvypQMo79pTER_7u3hF-PA3EstUvZrlykgm82TGCMlQok"

![](http://dl.dropbox.com/s/rib8pdximcag6r0/Screen%20Shot%202015-04-23%20at%204.40.23%20PM.png)

## SDK Initialization

Import `<AppodealAds/Appodeal.h>` in `AppDelegate.m` and start sdk initialization with `[Appodeal initWithAppId:@"APPODEAL_APP_KEY"];` in `didFinishLaunchingWithOptions` method

```objective-c
#import "AppDelegate.h"
#import <AppodealAds/Appodeal.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Appodeal SDK Initialization
    [Appodeal initWithAppId:@"APPODEAL_APP_KEY"];
    return YES;
}

@end
```

## Show Interstitial Ad

```objective-c
#import "YourViewController.h"
#import <AppodealAds/Appodeal.h>

@implementation YourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

     // show full screen banner
    [Appodeal showInterstitial:self]; // Note: You need to pass active View Controller as parameter.
}
```

## Delegate callbacks (optional)

`AODInterstitialDelegate` includes a variety of optional callbacks that you can use to be notified of events, e.g. when an interstitial has successfully loaded, or when an interstitial is about to appear.
To handle callbacks you need implement `AODInterstitialDelegate` protocol.

```objective-c
#import "YourViewController.h"
#import <AppodealAds/Appodeal.h>

@interface YourViewController () <AODInterstitialDelegate>

@end

@implementation YourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

     // set delegate
    [Appodeal setInterstitialDelegate:self];
}

#pragma mark - <AODInterstitialDelegate>

- (void)onInterstitialAdLoaded:(NSString*)adName isPrecache:(BOOL)isPrecache {
     NSLog(@"interstitial from %@ did load", adName);
}

- (void)onInterstitialAdFailedToLoad:(NSString*)adName {
     NSLog(@"interstitial from %@ failed to load", adName);
}

- (void)onInterstitialAdShown:(NSString*)adName {
     NSLog(@"interstitial from %@ failed to load", adName);
}

- (void)onInterstitialAdClicked:(NSString*)adName {
     NSLog(@"interstitial from %@ has been clicked", adName);
}

- (void)onInterstitialAdClosed:(NSString*)adName {
     NSLog(@"interstitial from %@ has been closed or dismissed", adName);
}
```
# Banner Integration for iOS
Banner ads usually appear at the top or bottom of your app’s screen. 
Adding one to your app takes just a few lines of code.

## Prerequisites

Before integrating banner ads in your app, you’ll need to go through the steps in our [Getting Started Guide](https://github.com/appodeal/ios-sdk/wiki/Getting-Started) to create an account on Appodeal and integrate the SDK into your project.

## Basic integration

```objective-c
#import "YourViewController.h"
#import <AppodealAds/Appodeal.h>

@implementation YourViewController

@interface YourViewController ()

@property (nonatomic, strong) AODAdView *bannerView;

@end

- (void)viewDidLoad
{
    [super viewDidLoad];

    // init ad banner
    self.bannerView = [[AODAdView alloc] init]; 
    self.bannerView.rootController = self;
    [self.bannerView loadAd];
    [self.view addSubview:self.bannerView];
}
```

## Delegate callbacks (optional)

`AODAdBannerDelegate` includes a variety of optional callbacks that you can use to be notified of events, e.g. when an ad banner has successfully loaded, or when an ad banner is about to appear.
To handle callbacks you need implement `AODAdBannerDelegate` protocol.

```objective-c
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
```

These methods may be implemented in either a separate object like a view controller:
```objective-c
#import "YourViewController.h"
#import <AppodealAds/Appodeal.h>

@interface YourViewController () <AODAdViewDelegate>

@end
```

Remember to set the delegate before making the request for an ad:

```objective-c
self.bannerView.delegate = self;
```

## Banner position on the screen (optional)

By default banner pin at bottom of the screen.

Appodeal Ads supports the following banner positions:

`kAODBannerPortraitTop` - pin ad banner at top with portrait orientation

`kAODBannerPortraitBottom` - pin ad banner at bottom with portrait orientation

`kAODBannerLandscapeTop` - pin ad banner at top with landscape orientation

`kAODBannerLandscapeBottom` - pin ad banner at bottom with landscape orientation

You can init AODAdView with `- (id)initWithBannerType:(AODBannerType)bannerType;`

For example:
```objective-c
// pin ad banner at top of the screen
AODAdView* bannerView = [AODAdView initWithBannerType:kAODBannerPortraitTop];
```

# Video Integration for iOS
Video ads provide full-screen experiences, commonly incorporating rich media to offer a higher level of interactivity than banner and interstitial ads.
Adding one to your app takes just a few lines of code.

## Prerequisites

Before integrating video ads in your app, you’ll need to go through the steps in our [Getting Started Guide](https://github.com/appodeal/ios-sdk/wiki/Getting-Started) to create an account on Appodeal and integrate the SDK into your project.

## Basic integration

```objective-c
#import "YourViewController.h"
#import <AppodealAds/Appodeal.h>

@implementation YourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

     // show full screen banner
    [Appodeal showVideoAd:self]; // Note: You need to pass active View Controller as parameter.
}
```

## Delegate callbacks (optional)

`AODVideoAdDelegate` includes a variety of optional callbacks that you can use to be notified of events, e.g. when an video ad has successfully loaded, or when an video ad did complete then you can reward user virtual currency.
To handle callbacks you need implement `AODVideoAdDelegate` protocol.

```objective-c
#import "YourViewController.h"
#import <AppodealAds/Appodeal.h>

@interface YourViewController () <AODVideoAdDelegate>

@end

@implementation YourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

     // set delegate
    [Appodeal setVideoAdDelegate:self];
}

#pragma mark - <AODVideoAdDelegate>

- (void)onVideoAdDidLoad:(NSString*)adName {
     NSLog(@"video ad from %@ did load", adName);
}

- (void)onVideoAdDidFailToLoad:(NSString*)adName {
     NSLog(@"video ad from %@ failed to load", adName);
}

- (void)onVideoAdDidAppear:(NSString*)adName {
     NSLog(@"video ad from %@ failed to load", adName);
}

- (void)onVideoAdDidReceiveTapEvent:(NSString*)adName {
     NSLog(@"video ad from %@ has been clicked", adName);
}

- (void)onVideoAdDidDisappear:(NSString*)adName {
     NSLog(@"video ad from %@ has been closed or dismissed", adName);
}

- (void)onVideoAdShouldRewardUser:(NSString*)adName reward:(int)amount {
     NSLog(@"video ad from %@ has been completed and user rewarded %d virtual currency", adName, amount);
}
```

 
## Testing mode (optional)

```objective-c
#import "YourViewController.h"
#import <AppodealAds/Appodeal.h>

@implementation YourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set testing mode
    [Appodeal setTesting:YES]; // Note: Disable before publish on App Store.
}
```
If you encounter any issues, do not hesitate to contact our happy support team
at [ios@appodeal.com](mailto:ios@appodeal.com).