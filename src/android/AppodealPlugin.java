//Copyright (c) 2014 Sang Ki Kwon (Cranberrygame)
//Email: cranberrygame@yahoo.com
//Homepage: http://cranberrygame.github.io
//License: MIT (http://opensource.org/licenses/MIT)
package com.cranberrygame.cordova.plugin.ad.appodeal;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import android.annotation.TargetApi;
import android.app.Activity;
import android.util.Log;
//
import com.appodeal.ads.Appodeal;
import com.appodeal.ads.BannerCallbacks;
import com.appodeal.ads.InterstitialCallbacks;
import com.appodeal.ads.VideoCallbacks;
//md5
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
//Util
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.view.Surface;
//
import java.util.*;//Random

class Util {

	//ex) Util.alert(cordova.getActivity(),"message");
	public static void alert(Activity activity, String message) {
		AlertDialog ad = new AlertDialog.Builder(activity).create();  
		ad.setCancelable(false); // This blocks the 'BACK' button  
		ad.setMessage(message);  
		ad.setButton("OK", new DialogInterface.OnClickListener() {  
			@Override  
			public void onClick(DialogInterface dialog, int which) {  
				dialog.dismiss();                      
			}  
		});  
		ad.show(); 		
	}
	
	//https://gitshell.com/lvxudong/A530_packages_app_Camera/blob/master/src/com/android/camera/Util.java
	public static int getDisplayRotation(Activity activity) {
	    int rotation = activity.getWindowManager().getDefaultDisplay()
	            .getRotation();
	    switch (rotation) {
	        case Surface.ROTATION_0: return 0;
	        case Surface.ROTATION_90: return 90;
	        case Surface.ROTATION_180: return 180;
	        case Surface.ROTATION_270: return 270;
	    }
	    return 0;
	}

	public static final String md5(final String s) {
        try {
            MessageDigest digest = java.security.MessageDigest.getInstance("MD5");
            digest.update(s.getBytes());
            byte messageDigest[] = digest.digest();
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String h = Integer.toHexString(0xFF & messageDigest[i]);
                while (h.length() < 2)
                    h = "0" + h;
                hexString.append(h);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
        }
        return "";
    }
}

public class AppodealPlugin extends CordovaPlugin {
	private static final String LOG_TAG = "AppodealPlugin";
	private CallbackContext callbackContextKeepCallback;
	//
	protected String email;
	protected String licenseKey;
	public boolean validLicenseKey;
	protected String TEST_APPLICATION_KEY = "d42ab754218d2d24c0d713f5031ddbd34f98274c4074e7a4";
	//
	protected String applicationKey;
    protected boolean isOverlap;
    protected boolean isTest;
	//
	protected String bannerPreviousPosition;	
	//
	protected boolean bannerAdPreload;
	protected boolean fullScreenAdPreload;
	protected boolean rewardedVideoAdPreload;
	
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
    }
	
	//@Override
	//public void onCreate(Bundle savedInstanceState) {//build error
	//	super.onCreate(savedInstanceState);
	//	//
	//}
	
	//@Override
	//public void onStart() {//build error
	//	super.onStart();
	//	//
	//}
	
	@Override
	public void onPause(boolean multitasking) {
		super.onPause(multitasking);
		//
	}
	
	@Override
	public void onResume(boolean multitasking) {
		super.onResume(multitasking);
		//
	}
	
	//@Override
	//public void onStop() {//build error
	//	super.onStop();
	//	//
	//}
	
	@Override
	public void onDestroy() {
		super.onDestroy();
		//
	}
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

		if (action.equals("setLicenseKey")) {
			setLicenseKey(action, args, callbackContext);

			return true;
		}	
		else if (action.equals("setUp")) {
			setUp(action, args, callbackContext);

			return true;
		}			
		else if (action.equals("preloadBannerAd")) {
			preloadBannerAd(action, args, callbackContext);
			
			return true;
		}
		else if (action.equals("showBannerAd")) {
			showBannerAd(action, args, callbackContext);
						
			return true;
		}
		else if (action.equals("reloadBannerAd")) {
			reloadBannerAd(action, args, callbackContext);
						
			return true;
		}
		else if (action.equals("hideBannerAd")) {
			hideBannerAd(action, args, callbackContext);
						
			return true;
		}
		else if (action.equals("preloadFullScreenAd")) {
			preloadFullScreenAd(action, args, callbackContext);
			
			return true;
		}
		else if (action.equals("showFullScreenAd")) {
			showFullScreenAd(action, args, callbackContext);
						
			return true;
		}
		else if (action.equals("preloadRewardedVideoAd")) {
			preloadRewardedVideoAd(action, args, callbackContext);
			
			return true;
		}
		else if (action.equals("showRewardedVideoAd")) {
			showRewardedVideoAd(action, args, callbackContext);
						
			return true;
		}
		
		return false; // Returning false results in a "MethodNotFound" error.
	}

	private void setLicenseKey(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		final String email = args.getString(0);
		final String licenseKey = args.getString(1);				
		Log.d(LOG_TAG, String.format("%s", email));			
		Log.d(LOG_TAG, String.format("%s", licenseKey));
		
		cordova.getActivity().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				_setLicenseKey(email, licenseKey);
			}
		});
	}
	
	private void setUp(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		//Activity activity=cordova.getActivity();
		//webView
		//args.length()
		//args.getString(0)
		//args.getString(1)
		//args.getInt(0)
		//args.getInt(1)
		//args.getBoolean(0)
		//args.getBoolean(1)
		//JSONObject json = args.optJSONObject(0);
		//json.optString("adUnitBanner")
		//json.optString("adUnitFullScreen")
		//JSONObject inJson = json.optJSONObject("inJson");
		//final String adUnitBanner = args.getString(0);
		//final String adUnitFullScreen = args.getString(1);				
		//final boolean isOverlap = args.getBoolean(2);				
		//final boolean isTest = args.getBoolean(3);
		//final String[] zoneIds = new String[args.getJSONArray(4).length()];
		//for (int i = 0; i < args.getJSONArray(4).length(); i++) {
		//	zoneIds[i] = args.getJSONArray(4).getString(i);
		//}			
		//Log.d(LOG_TAG, String.format("%s", adUnitBanner));			
		//Log.d(LOG_TAG, String.format("%s", adUnitFullScreen));
		//Log.d(LOG_TAG, String.format("%b", isOverlap));
		//Log.d(LOG_TAG, String.format("%b", isTest));	
		final String applicationKey = args.getString(0);
		final boolean isOverlap = args.getBoolean(1);			
		final boolean isTest = args.getBoolean(2);				
		Log.d(LOG_TAG, String.format("%s", applicationKey));
		Log.d(LOG_TAG, String.format("%b", isOverlap));
		Log.d(LOG_TAG, String.format("%b", isTest));
		
		callbackContextKeepCallback = callbackContext;
			
		cordova.getActivity().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				_setUp(applicationKey, isOverlap, isTest);
			}
		});
	}
	
	private void preloadBannerAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_preloadBannerAd();
			}
		});
	}

	private void showBannerAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		final String position = args.getString(0);
		Log.d(LOG_TAG, String.format("%s", position));
		
		cordova.getActivity().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				_showBannerAd(position);
			}
		});
	}

	private void reloadBannerAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_reloadBannerAd();
			}
		});
	}
	
	private void hideBannerAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_hideBannerAd();
			}
		});
	}
	
	private void preloadFullScreenAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_preloadFullScreenAd();
			}
		});
	}

	private void showFullScreenAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_showFullScreenAd();
			}
		});
	}

	private void preloadRewardedVideoAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_preloadRewardedVideoAd();
			}
		});
	}

	private void showRewardedVideoAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_showRewardedVideoAd();
			}
		});
	}
	
	public void _setLicenseKey(String email, String licenseKey) {
		this.email = email;
		this.licenseKey = licenseKey;

		//
		String str1 = Util.md5("cordova-plugin-: " + email);
		String str2 = Util.md5("cordova-plugin-ad-appodeal: " + email);
		String str3 = Util.md5("com.cranberrygame.cordova.plugin.: " + email);
		String str4 = Util.md5("com.cranberrygame.cordova.plugin.ad.appodeal: " + email);
		if(licenseKey != null && (licenseKey.equalsIgnoreCase(str1) || licenseKey.equalsIgnoreCase(str2) || licenseKey.equalsIgnoreCase(str3) || licenseKey.equalsIgnoreCase(str4))) {
			this.validLicenseKey = true;
			//
			String[] excludedLicenseKeys = {"xxx"};
			for (int i = 0 ; i < excludedLicenseKeys.length ; i++) {
				if (excludedLicenseKeys[i].equals(licenseKey)) {
					this.validLicenseKey = false;
					break;
				}
			}			
			if (this.validLicenseKey)
				Log.d(LOG_TAG, String.format("%s", "valid licenseKey"));
			else
				Log.d(LOG_TAG, String.format("%s", "invalid licenseKey"));
		}
		else {
			Log.d(LOG_TAG, String.format("%s", "invalid licenseKey"));
			this.validLicenseKey = false;							
		}		
		//if (!this.validLicenseKey)
		//	Util.alert(cordova.getActivity(),"Cordova Appodeal: invalid email / license key. You can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova");
	}
	
	private void _setUp(String applicationKey, boolean isOverlap, boolean isTest) {
		this.applicationKey = applicationKey;
        this.isOverlap = isOverlap;
        this.isTest = isTest;
        
		if (!validLicenseKey) {
			if (new Random().nextInt(100) <= 1) {//0~99					
				this.applicationKey = TEST_APPLICATION_KEY;
			}
		}
		
		Appodeal.initialize(cordova.getActivity(), applicationKey, Appodeal.ALL);//third parameter: initial preload
		//Appodeal.initialize(cordova.getActivity(), applicationKey, Appodeal.NONE);
		//Appodeal.setAutoCache(Appodeal.BANNER, false);//auto cache: true (default)
		//Appodeal.setAutoCache(Appodeal.INTERSTITIAL, false);
		//Appodeal.setAutoCache(Appodeal.VIDEO, false);
		//Appodeal.setTesting(isTest);//build error
		Appodeal.setBannerCallbacks(new MyBannerCallbacks());
		Appodeal.setInterstitialCallbacks(new MyInterstitialCallbacks());
		Appodeal.setVideoCallbacks(new MyVideoCallbacks());
	}

	public void _preloadBannerAd() {
		bannerAdPreload = true;
		
		_hideBannerAd();
        
        loadBannerAd();
	}

    private void loadBannerAd() {
        Appodeal.cache(cordova.getActivity(), Appodeal.BANNER);
    }
    
	public void _showBannerAd(String position) {
        if (bannerIsShowingOverlap() && position.equals(bannerPreviousPosition)) {
            return;
        }
        
 		this.bannerPreviousPosition = position;

        if(bannerAdPreload) {
            bannerAdPreload = false;
        }
        else{
            _hideBannerAd();
            
            loadBannerAd();
        }
        
        addBannerViewOverlap(position);
    }

	protected boolean bannerIsShowingOverlap() {
		boolean bannerIsShowing = false;

		return bannerIsShowing;
	}
	
    protected void addBannerViewOverlap(String position) {
        int adType = Appodeal.BANNER_BOTTOM;
        if (position.equals("top-left")) {
            adType = Appodeal.BANNER_TOP;
        }
        else if (position.equals("top-center")) {
            adType = Appodeal.BANNER_TOP;
        }
        else if (position.equals("top-right")) {
            adType = Appodeal.BANNER_TOP;
        }
        else if (position.equals("left")) {
            adType = Appodeal.BANNER_BOTTOM;
        }
        else if (position.equals("center")) {
            adType = Appodeal.BANNER_CENTER;
        }
        else if (position.equals("right")) {
            adType = Appodeal.BANNER_BOTTOM;
        }
        else if (position.equals("bottom-left")) {
            adType = Appodeal.BANNER_BOTTOM;
        }
        else if (position.equals("bottom-center")) {
            adType = Appodeal.BANNER_BOTTOM;
        }
        else if (position.equals("bottom-right")) {
            adType = Appodeal.BANNER_BOTTOM;
        }
        else {		
            adType = Appodeal.BANNER_BOTTOM;
        }
        
        boolean isShow = Appodeal.show(cordova.getActivity(), adType);
    }
    
	public void _reloadBannerAd() {
		loadBannerAd();
	}
	
	public void _hideBannerAd() {
        removeBannerViewOverlap();
        
        PluginResult pr = new PluginResult(PluginResult.Status.OK, "onBannerAdHidden");
        pr.setKeepCallback(true);
        callbackContextKeepCallback.sendPluginResult(pr);
        //PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
        //pr.setKeepCallback(true);
        //callbackContextKeepCallback.sendPluginResult(pr);
    }
	
    protected void removeBannerViewOverlap() {
        Appodeal.hide(cordova.getActivity(), Appodeal.BANNER);
    }
    
	private void _preloadFullScreenAd() {
		fullScreenAdPreload = true;

        loadFullScreenAd();
	}

	private void loadFullScreenAd() {
        Appodeal.cache(cordova.getActivity(), Appodeal.INTERSTITIAL);
    }
    
	private void _showFullScreenAd() {
        if(fullScreenAdPreload) {
            fullScreenAdPreload = false;
            
            boolean isShow = Appodeal.show(cordova.getActivity(), Appodeal.INTERSTITIAL);
        }
        else {
            boolean isShow = Appodeal.show(cordova.getActivity(), Appodeal.INTERSTITIAL);
        }
	}

	private void _preloadRewardedVideoAd() {
		rewardedVideoAdPreload = true;

        loadRewardedVideoAd();
	}

    private void loadRewardedVideoAd() {
        Appodeal.cache(cordova.getActivity(), Appodeal.VIDEO);
    }
    
	private void _showRewardedVideoAd() {
        if(rewardedVideoAdPreload) {
            rewardedVideoAdPreload = false;
            
            boolean isShow = Appodeal.show(cordova.getActivity(), Appodeal.VIDEO);
        }
        else {
            boolean isShow = Appodeal.show(cordova.getActivity(), Appodeal.VIDEO);
        }
	}
	
///////////////////////////

	class MyBannerCallbacks implements BannerCallbacks {

		@Override
		public void onBannerFailedToLoad() {
			Log.d(LOG_TAG, "onBannerFailedToLoad");
		}

		@Override
		public void onBannerLoaded() {
			Log.d(LOG_TAG, "onBannerLoaded");
			
    		if (bannerAdPreload) {
    			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onBannerAdPreloaded");
    			pr.setKeepCallback(true);
    			callbackContextKeepCallback.sendPluginResult(pr);
    			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
    			//pr.setKeepCallback(true);
    			//callbackContextKeepCallback.sendPluginResult(pr);		
    		}
    		
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onBannerAdLoaded");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);				
		}

		@Override
		public void onBannerShown() {
			Log.d(LOG_TAG, "onBannerShown");
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onBannerAdShown");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);				
		}

		@Override
		public void onBannerClicked() {
			Log.d(LOG_TAG, "onBannerClicked");
		}
	}

	class MyInterstitialCallbacks implements InterstitialCallbacks {
		
		@Override
		public void onInterstitialLoaded(boolean arg0) {
			Log.d(LOG_TAG, "onInterstitialLoaded");
			
    		if (fullScreenAdPreload) {
    			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onFullScreenAdPreloaded");
    			pr.setKeepCallback(true);
    			callbackContextKeepCallback.sendPluginResult(pr);
    			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
    			//pr.setKeepCallback(true);
    			//callbackContextKeepCallback.sendPluginResult(pr);		
    		}
    		
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onFullScreenAdLoaded");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);				
		}
		
		@Override
		public void onInterstitialFailedToLoad() {
			Log.d(LOG_TAG, "onInterstitialFailedToLoad");
		}
		
		@Override
		public void onInterstitialShown() {
			Log.d(LOG_TAG, "onInterstitialShown");
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onFullScreenAdShown");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);			
		}
		
		@Override
		public void onInterstitialClicked() {
			Log.d(LOG_TAG, "onInterstitialClicked");
		}
		
		@Override
		public void onInterstitialClosed() {
			Log.d(LOG_TAG, "onInterstitialClosed");
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onFullScreenAdHidden");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);				
		}
	}

	class MyVideoCallbacks implements VideoCallbacks {

		@Override
		public void onVideoLoaded() {
			Log.d(LOG_TAG, "onVideoLoaded");

    		if (rewardedVideoAdPreload) {
    			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onRewardedVideoAdPreloaded");
    			pr.setKeepCallback(true);
    			callbackContextKeepCallback.sendPluginResult(pr);
    			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
    			//pr.setKeepCallback(true);
    			//callbackContextKeepCallback.sendPluginResult(pr);		
    		}
    		
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onRewardedVideoAdLoaded");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);							
		}

		@Override
		public void onVideoFailedToLoad() {
			Log.d(LOG_TAG, "onVideoFailedToLoad");
		}
		
		@Override
		public void onVideoShown() {
			Log.d(LOG_TAG, "onVideoShown");
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onRewardedVideoAdShown");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);			
		}
		
		@Override
		public void onVideoClosed() {
			Log.d(LOG_TAG, "onVideoClosed");
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onRewardedVideoAdHidden");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);				
		}	

		@Override
		public void onVideoFinished() {
			Log.d(LOG_TAG, "onVideoFinished");
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onRewardedVideoAdCompleted");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);				
		}
	}
}
