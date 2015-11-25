//
//  PushmotePlugin.h
//  PushmotePhoneGapBindings
//
//  Created by Taha Ozket on 11/24/15.
//  Copyright © 2015 Pushmote. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PushmoteSDK/Pushmote.h>
#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface PushmotePlugin : CDVPlugin

- (void)startWithApplicationId:(CDVInvokedUrlCommand *)command;
+ (void)handleNotification:(UILocalNotification*)notification;

@end
