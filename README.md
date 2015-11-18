# Pushmote PhoneGap/Cordova Plugin

## How to add Pushmote PhoneGap/Cordova Plugin

First add pushmote-phonegap-plugin by using phonegap cli

    phonegap plugin add pushmote-phonegap-plugin

### For iOS

This plugin requires modifications to your AppDelegate.m. Append the following line just below other imports.
    
    #import <PushmoteSDK/Pushmote.h>

add following line as the first line of "application:didFinishLaunchingWithOptions" method

    [Pushmote startWithApplicationId:@"YOUR_APP_KEY"];

add following line part

    -(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
        [Pushmote handleNotification:notification];
    }
    
### For Android

This plugin requires modifications to MainActivity.java. Append the following line just below other imports.
    
    import com.pushmote.android.Pushmote;
    
add following line as the second line of "onCreate(Bundle savedInstanceState)" method

    Pushmote.start(Pushmote.HWProvider.ESTIMOTE, this, "YOUR_APP_KEY");

add onCreate, onStart and onStop methods in your MainActivity.java

    @Override
    protected void onStart() {
        super.onStart();
        Pushmote.bringToForeground();
    }

    @Override
    protected void onStop() {
        super.onStop();
        Pushmote.sendToBackground();
    }
