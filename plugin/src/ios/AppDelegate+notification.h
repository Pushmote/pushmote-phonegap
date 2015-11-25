//
//  AppDelegate+notification.h
//  pushtest
//  https://github.com/phonegap/phonegap-plugin-push/blob/master/src/ios/AppDelegate%2Bnotification.h
//  Originally created by Robert Easterday on 10/26/12.
//
//

#import "AppDelegate.h"

@interface AppDelegate (notification)
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
- (void)applicationDidBecomeActive:(UIApplication *)application;

@property (nonatomic, retain) UILocalNotification	*launchNotification;

@end