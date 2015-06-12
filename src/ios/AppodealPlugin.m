//Copyright (c) 2014 Sang Ki Kwon (Cranberrygame)
//Email: cranberrygame@yahoo.com
//Homepage: http://cranberrygame.github.io
//License: MIT (http://opensource.org/licenses/MIT)
#import "AppodealPlugin.h"
#import <CommonCrypto/CommonDigest.h> //md5

@implementation AppodealPlugin

@synthesize callbackIdKeepCallback;
//
@synthesize email;
@synthesize licenseKey_;
@synthesize validLicenseKey;
static NSString *TEST_APPLICATION_KEY = @"c2b9d306d7f83752b2e3509f60cb780d81fccf29fcfc1ec5";
//
@synthesize applicationKey;
@synthesize isOverlap;
@synthesize isTest;
//
@synthesize bannerPreviousPosition;
//
@synthesize bannerAdPreload;
@synthesize fullScreenAdPreload;
@synthesize rewardedVideoAdPreload;
//
@synthesize bannerView;

- (void) setLicenseKey: (CDVInvokedUrlCommand*)command {
    NSString *email = [command.arguments objectAtIndex: 0];
    NSString *licenseKey = [command.arguments objectAtIndex: 1];
    NSLog(@"%@", email);
    NSLog(@"%@", licenseKey);
    
    [self.commandDelegate runInBackground:^{
        [self _setLicenseKey:email aLicenseKey:licenseKey];
    }];
}

- (void) setUp: (CDVInvokedUrlCommand*)command {
    //self.viewController
    //self.webView
    //NSString *adUnitBanner = [command.arguments objectAtIndex: 0];
    //NSString *adUnitFullScreen = [command.arguments objectAtIndex: 1];
    //BOOL isOverlap = [[command.arguments objectAtIndex: 2] boolValue];
    //BOOL isTest = [[command.arguments objectAtIndex: 3] boolValue];
	//NSArray *zoneIds = [command.arguments objectAtIndex:4];	
    //NSLog(@"%@", adUnitBanner);
    //NSLog(@"%@", adUnitFullScreen);
    //NSLog(@"%d", isOverlap);
    //NSLog(@"%d", isTest);
	NSString* applicationKey = [command.arguments objectAtIndex:0];
    BOOL isOverlap = [[command.arguments objectAtIndex: 1] boolValue];
    BOOL isTest = [[command.arguments objectAtIndex: 2] boolValue];
	NSLog(@"%@", applicationKey);
    NSLog(@"%d", isOverlap);
    NSLog(@"%d", isTest);
	
    self.callbackIdKeepCallback = command.callbackId;
	
    //[self.commandDelegate runInBackground:^{
		[self _setUp:applicationKey isOverlap:isOverlap isTest:isTest];	
    //}];
}

- (void) preloadBannerAd: (CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
		[self _preloadBannerAd];
    }];
}

- (void) showBannerAd: (CDVInvokedUrlCommand*)command {
	NSString *position = [command.arguments objectAtIndex: 0];
	NSLog(@"%@", position);
			
    //[self.commandDelegate runInBackground:^{
		[self _showBannerAd:position];
    //}];
}

- (void) reloadBannerAd: (CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
		[self _reloadBannerAd];
    }];
}

- (void) hideBannerAd: (CDVInvokedUrlCommand*)command {
    //[self.commandDelegate runInBackground:^{
		[self _hideBannerAd];
    //}];
}

- (void) preloadFullScreenAd: (CDVInvokedUrlCommand*)command {
//    [self.commandDelegate runInBackground:^{
		[self _preloadFullScreenAd];
//    }];
}

- (void) showFullScreenAd: (CDVInvokedUrlCommand*)command {
    //[self.commandDelegate runInBackground:^{
		[self _showFullScreenAd];
    //}];
}

- (void) preloadRewardedVideoAd: (CDVInvokedUrlCommand*)command {
//    [self.commandDelegate runInBackground:^{
		[self _preloadRewardedVideoAd];
//    }];
}

- (void) showRewardedVideoAd: (CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
		[self _showRewardedVideoAd];
    }];
}

- (void) _setLicenseKey:(NSString *)email aLicenseKey:(NSString *)licenseKey {
	self.email = email;
	self.licenseKey_ = licenseKey;

	//
	NSString *str1 = [self md5:[NSString stringWithFormat:@"cordova-plugin-: %@", email]];
	NSString *str2 = [self md5:[NSString stringWithFormat:@"cordova-plugin-ad-appodeal: %@", email]];
	NSString *str3 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.: %@", email]];
	NSString *str4 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.ad.appodeal: %@", email]];
	if(licenseKey_ != Nil && ([licenseKey_ isEqualToString:str1] || [licenseKey_ isEqualToString:str2] || [licenseKey_ isEqualToString:str3] || [licenseKey_ isEqualToString:str4])){
		self.validLicenseKey = YES;
		NSArray *excludedLicenseKeys = [NSArray arrayWithObjects: @"xxx", nil];
		for (int i = 0 ; i < [excludedLicenseKeys count] ; i++) {
			if([[excludedLicenseKeys objectAtIndex:i] isEqualToString:licenseKey]) {
				self.validLicenseKey = NO;
				break;
			}
		}
	}
	else {
		self.validLicenseKey = NO;
	}
	if (self.validLicenseKey)
		NSLog(@"valid licenseKey");
	else {
		NSLog(@"invalid licenseKey");
		//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Cordova Appodeal: invalid email / license key. You can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[alert show];	
	}
}

- (NSString*) md5:(NSString*) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (void) _setUp:(NSString *)applicationKey isOverlap:(BOOL)isOverlap isTest:(BOOL)isTest {
	self.applicationKey = applicationKey;
    self.isOverlap = isOverlap;
    self.isTest = isTest;
    
	if (!validLicenseKey) {
		if (arc4random() % 100 <= 1) {//0 ~ 99		
			self.applicationKey = TEST_APPLICATION_KEY;
		}
	}
    
    [Appodeal initWithAppId:self.applicationKey];//initial preload
    //auto cache: true (default)
    [Appodeal setTesting:isTest];
    [Appodeal setInterstitialDelegate:self];
    [Appodeal setVideoAdDelegate:self];
}

- (void) _preloadBannerAd {
	bannerAdPreload = YES;

    [self _hideBannerAd];
    
    [self loadBannerAd];
    
    CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onBannerAdPreloaded"];
    [pr setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
    //CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    //[pr setKeepCallbackAsBool:YES];
    //[self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
}

- (void) loadBannerAd {
    if (!self.bannerView) {
        self.bannerView = [[AODAdView alloc] init];
        self.bannerView.rootController = self.viewController;
        self.bannerView.delegate = self;
        //[self.bannerView disableAutoRefresh]; // optional
    }
    self.bannerView.testing = isTest;
    [self.bannerView loadAd];
}

- (void) _showBannerAd:(NSString *)position {
    
    if ([self bannerIsShowingOverlap] && [position isEqualToString:self.bannerPreviousPosition]) {
        return;
    }
    
    self.bannerPreviousPosition = position;

    if(bannerAdPreload) {
        bannerAdPreload = NO;
    }
    else{
        [self _hideBannerAd];
        
        [self loadBannerAd];
    }
    
    [self addBannerViewOverlap:position];
    
    CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onBannerAdShown"];
    [pr setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
    //CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    //[pr setKeepCallbackAsBool:YES];
    //[self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
}

- (BOOL) bannerIsShowingOverlap {
    //
    BOOL bannerIsShowing = NO;
    if (bannerView != nil) {
        //if banner is showing
        //if ([bannerView isDescendantOfView:webView]) {
        UIView* webView = [bannerView superview];
        if (webView != nil) {
            bannerIsShowing = YES;
        }
    }
    
    return bannerIsShowing;
}

- (void) addBannerViewOverlap:(NSString*)position {
    /*
     //http://tigerwoods.tistory.com/11
     //http://developer.android.com/reference/android/widget/RelativeLayout.html
     //http://stackoverflow.com/questions/24900725/admob-banner-poitioning-in-android-on-bottom-of-the-screen-using-no-xml-relative
     RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(AdView.LayoutParams.WRAP_CONTENT, AdView.LayoutParams.WRAP_CONTENT);
     if (position.equals("top-left")) {
     Log.d("Admob", "top-left");
     params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
     params.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
     }
     else if (position.equals("top-center")) {
     params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
     params.addRule(RelativeLayout.CENTER_HORIZONTAL);
     }
     else if (position.equals("top-right")) {
     params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
     params.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
     }
     else if (position.equals("left")) {
     params.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
     params.addRule(RelativeLayout.CENTER_VERTICAL);
     }
     else if (position.equals("center")) {
     params.addRule(RelativeLayout.CENTER_HORIZONTAL);
     params.addRule(RelativeLayout.CENTER_VERTICAL);
     }
     else if (position.equals("right")) {
     params.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
     params.addRule(RelativeLayout.CENTER_VERTICAL);
     }
     else if (position.equals("bottom-left")) {
     params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
     params.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
     }
     else if (position.equals("bottom-center")) {
     
     params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
     params.addRule(RelativeLayout.CENTER_HORIZONTAL);
     }
     else if (position.equals("bottom-right")) {
     params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
     params.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
     }
     else {
     params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
     params.addRule(RelativeLayout.CENTER_HORIZONTAL);
     }
     
     //bannerViewLayout.addView(bannerView, params);
     bannerView.setLayoutParams(params);
     bannerViewLayout.addView(bannerView);
     */
    
    CGRect bannerFrame = bannerView.frame;
    if ([position isEqualToString:@"top-center"]) {
        bannerFrame.origin.y = 0;
    }
    //else if ([position isEqualToString:@"center"]) {        
    //}
    else {
        bannerFrame.origin.y = self.webView.frame.size.height - bannerView.frame.size.height;
    }
    bannerFrame.origin.x = self.webView.frame.size.width * 0.5f - bannerView.frame.size.width * 0.5f;
    bannerView.frame = bannerFrame;
    //https://developer.apple.com/library/ios/documentation/uikit/reference/UIView_Class/UIView/UIView.html#//apple_ref/occ/cl/UIView
    [self.webView addSubview:bannerView];
}

- (void)_reloadBannerAd {
    [self loadBannerAd];
}

- (void) _hideBannerAd {
    [self _removeBannerViewOverlap];
    
    CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onBannerAdHidden"];
    [pr setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
    //CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    //[pr setKeepCallbackAsBool:YES];
    //[self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
}

- (void)_removeBannerViewOverlap {
    if (bannerView == nil)
        return;
    
    //if banner is showing
    UIView* webView = [bannerView superview];
    if (webView != nil) {
        //https://developer.apple.com/library/ios/documentation/uikit/reference/UIView_Class/UIView/UIView.html#//apple_ref/occ/cl/UIView
        [self.bannerView removeFromSuperview];
        bannerView = nil;
    }
}

-(void) _preloadFullScreenAd {
	self.fullScreenAdPreload = YES;		
	
    [self loadFullScreenAd];
 	
}

-(void) loadFullScreenAd {
//	Appodeal.cache(cordova.getActivity(), Appodeal.INTERSTITIAL);
}

-(void) _showFullScreenAd {
    if(fullScreenAdPreload) {
        fullScreenAdPreload = NO;
        
        [Appodeal showInterstitial:self.viewController];
    }
    else {
        [Appodeal showInterstitial:self.viewController];
    }
}

-(void) _preloadRewardedVideoAd {
	self.rewardedVideoAdPreload = YES;	
	    
    [self loadRewardedVideoAd];
}

-(void) loadRewardedVideoAd {
//	Appodeal.cache(cordova.getActivity(), Appodeal.VIDEO);
}

-(void) _showRewardedVideoAd {
    if(rewardedVideoAdPreload) {
        rewardedVideoAdPreload = NO;
        
        [Appodeal showVideoAd:self.viewController];
    }
    else {
        [Appodeal showVideoAd:self.viewController];
    }
}

//-----------------------------------------------------

#pragma mark - <AODAdViewDelegate>

- (UIViewController *) viewControllerForPresentingModalView {
    return self.viewController;
}

- (void) adViewDidLoadAd:(AODAdView *)bannerView {
    NSLog(@"adViewDidLoadAd");

	if(bannerAdPreload) {
/*
		CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onBannerAdPreloaded"];
		[pr setKeepCallbackAsBool:YES];
		[self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		//[pr setKeepCallbackAsBool:YES];
		//[self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
*/
	}
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onBannerAdLoaded"];	
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
}

- (void) adViewDidFailToLoadAd:(AODAdView *)view {
    NSLog(@"adViewDidFailToLoadAd");
}

- (void) willPresentModalViewForAd:(AODAdView *)view {
    NSLog(@"willPresentModalViewForAd");
}

- (void) didDismissModalViewForAd:(AODAdView *)view {
    NSLog(@"didDismissModalViewForAd");
}

- (void) willLeaveApplicationFromAd:(AODAdView *)view {
    NSLog(@"willLeaveApplicationFromAd");
}

///////////////////////////////////////////////////////////////////

#pragma mark - <AODInterstitialDelegate>

- (void) onInterstitialAdLoaded:(NSString*)adName isPrecache:(BOOL)isPrecache {
    NSLog(@"onInterstitialAdLoaded");
	
	if(fullScreenAdPreload) {
		CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdPreloaded"];
		[pr setKeepCallbackAsBool:YES];
		[self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		//[pr setKeepCallbackAsBool:YES];
		//[self.commandDelegate sendPluginResult:pr callbackId:self.callbackIdKeepCallback];
	}
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdLoaded"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

- (void) onInterstitialAdFailedToLoad:(NSString*)adName {
    NSLog(@"onInterstitialAdFailedToLoad");
}

- (void) onInterstitialAdShown:(NSString*)adName {
    NSLog(@"onInterstitialAdShown");
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdShown"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

- (void) onInterstitialAdClicked:(NSString*)adName {
    NSLog(@"onInterstitialAdClicked");
}

- (void) onInterstitialAdClosed:(NSString*)adName {
    NSLog(@"onInterstitialAdClosed");
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdHidden"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

///////////////////////////////////////////////////////////////////

#pragma mark - <AODVideoAdDelegate>

- (void) onVideoAdDidLoad:(NSString*)adName {
    NSLog(@"onVideoAdDidLoad");
	
	if(bannerAdPreload) {
		CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdPreloaded"];
		[pr setKeepCallbackAsBool:YES];
		[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		//[pr setKeepCallbackAsBool:YES];
		//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];			
	}
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdLoaded"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

- (void) onVideoAdDidFailToLoad:(NSString*)adName {
    NSLog(@"onVideoAdDidFailToLoad");
}

- (void) onVideoAdDidAppear:(NSString*)adName {
    NSLog(@"onVideoAdDidAppear");
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdShown"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

- (void) onVideoAdDidReceiveTapEvent:(NSString*)adName {
    NSLog(@"onVideoAdDidReceiveTapEvent");
}

- (void) onVideoAdDidDisappear:(NSString*)adName {
    NSLog(@"onVideoAdDidDisappear");
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdHidden"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

- (void) onVideoAdShouldRewardUser:(NSString*)adName reward:(int)amount {
    NSLog(@"onVideoAdShouldRewardUser");
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdCompleted"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

@end