
module.exports = {
	_loadedBannerAd: false,
	_loadedFullScreenAd: false,
	_loadedRewardedVideoAd: false,
	_isShowingBannerAd: false,
	_isShowingFullScreenAd: false,
	_isShowingRewardedVideoAd: false,
	//
	setLicenseKey: function(email, licenseKey) {
		var self = this;	
        cordova.exec(
            null,
            null,
            'AppodealPlugin',
            'setLicenseKey',			
            [email, licenseKey]
        ); 
    },	
	setUp: function(applicationKey, isOverlap, isTest) {
		var self = this;	
        cordova.exec(
            function (result) {
				if (typeof result == "string") {
					if (result == "onBannerAdPreloaded") {
						if (self.onBannerAdPreloaded)
							self.onBannerAdPreloaded();
					}
					else if (result == "onBannerAdLoaded") {
						self._loadedBannerAd = true;

						if (self.onBannerAdLoaded)
							self.onBannerAdLoaded();
					}
					else if (result == "onBannerAdShown") {
						self._loadedBannerAd = false;
						self._isShowingBannerAd = true;
					
						if (self.onBannerAdShown)
							self.onBannerAdShown();
					}
					else if (result == "onBannerAdHidden") {
						self._isShowingBannerAd = false;
					
						 if (self.onBannerAdHidden)
							self.onBannerAdHidden();
					}
					//
					else if (result == "onFullScreenAdPreloaded") {
						if (self.onFullScreenAdPreloaded)
							self.onFullScreenAdPreloaded();
					}
					else if (result == "onFullScreenAdLoaded") {
						self._loadedFullScreenAd = true;

						if (self.onFullScreenAdLoaded)
							self.onFullScreenAdLoaded();
					}
					else if (result == "onFullScreenAdShown") {
						self._loadedFullScreenAd = false;
						self._isShowingFullScreenAd = true;
					
						if (self.onFullScreenAdShown)
							self.onFullScreenAdShown();
					}
					else if (result == "onFullScreenAdHidden") {
						self._isShowingFullScreenAd = false;
					
						 if (self.onFullScreenAdHidden)
							self.onFullScreenAdHidden();
					}
					//
					else if (result == "onRewardedVideoAdPreloaded") {
						if (self.onRewardedVideoAdPreloaded)
							self.onRewardedVideoAdPreloaded();
					}
					else if (result == "onRewardedVideoAdLoaded") {
						self._loadedRewardedVideoAd = true;

						if (self.onRewardedVideoAdLoaded)
							self.onRewardedVideoAdLoaded();
					}
					else if (result == "onRewardedVideoAdShown") {
						self._loadedRewardedVideoAd = false;
						self._isShowingRewardedVideoAd = true;
					
						if (self.onRewardedVideoAdShown)
							self.onRewardedVideoAdShown();
					}
					else if (result == "onRewardedVideoAdHidden") {
						self._isShowingRewardedVideoAd = false;
					
						 if (self.onRewardedVideoAdHidden)
							self.onRewardedVideoAdHidden();
					}
					else if (result == "onRewardedVideoAdCompleted") {
						if (self.onRewardedVideoAdCompleted)
							self.onRewardedVideoAdCompleted();
					}					
				}
				else {
					//var event = result["event"];
					//var location = result["message"];				
					//if (event == "onXXX") {
					//	if (self.onXXX)
					//		self.onXXX(location);
					//}
				}			
			}, 
			function (error) {
			},
            'AppodealPlugin',
            'setUp',			
            [applicationKey, isOverlap, isTest]
        ); 
    },
	preloadBannerAd: function() {
		var self = this;	
        cordova.exec(
            null,
            null,
            'AppodealPlugin',
            'preloadBannerAd',
            []
        ); 
    },
    showBannerAd: function(position) {
		var self = this;	
        cordova.exec(
            null,
            null,
            'AppodealPlugin',
            'showBannerAd',
            [position]
        ); 
    },
	reloadBannerAd: function() {
		var self = this;	
        cordova.exec(
            null,
            null,
            'AppodealPlugin',
            'reloadBannerAd',
            []
        ); 
    },
    hideBannerAd: function() {
		var self = this;	
        cordova.exec(
            null,
            null,
            'AppodealPlugin',
            'hideBannerAd',
            []
        ); 
    },
	//
	preloadFullScreenAd: function() {
		var self = this;	
        cordova.exec(
            null,
            null,
            'AppodealPlugin',
            'preloadFullScreenAd',
            []
        ); 
    },
    showFullScreenAd: function() {
		var self = this;
		cordova.exec(
            null,
            null,
            'AppodealPlugin',
            'showFullScreenAd',
            []
        ); 
    },
	//
	preloadRewardedVideoAd: function() {
		var self = this;	
        cordova.exec(
            null,
            null,
            'AppodealPlugin',
            'preloadRewardedVideoAd',
            []
        ); 
    },
    showRewardedVideoAd: function() {
		var self = this;
		cordova.exec(
            null,
            null,
            'AppodealPlugin',
            'showRewardedVideoAd',
            []
        ); 
    },
	loadedBannerAd: function() {
		return this._loadedBannerAd;
	},
	loadedFullScreenAd: function() {
		return this._loadedFullScreenAd;
	},
	loadedRewardedVideoAd: function() {
		return this._loadedRewardedVideoAd;
	},	
	isShowingBannerAd: function() {
		return this._isShowingBannerAd;
	},
	isShowingFullScreenAd: function() {
		return this._isShowingFullScreenAd;
	},		
	isShowingRewardedVideoAd: function() {
		return this._isShowingRewardedVideoAd;
	},		
	onBannerAdPreloaded: null,
	onBannerAdLoaded: null,
	onBannerAdShown: null,
	onBannerAdHidden: null,
	//
	onFullScreenAdPreloaded: null,
	onFullScreenAdLoaded: null,
	onFullScreenAdShown: null,
	onFullScreenAdHidden: null,
	//
	onRewardedVideoAdPreloaded: null,
	onRewardedVideoAdLoaded: null,
	onRewardedVideoAdShown: null,
	onRewardedVideoAdHidden: null,
	onRewardedVideoAdCompleted: null
};
