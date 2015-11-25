//
//  PushmotePlugin.m
//  PushmotePhoneGapBindings
//
//  Created by Taha Ozket on 11/24/15.
//  Copyright © 2015 Pushmote. All rights reserved.
//

#import "PushmotePlugin.h"

@implementation PushmotePlugin


- (void)startWithApplicationId:(CDVInvokedUrlCommand *)command
{
    NSMutableDictionary* options = [command.arguments objectAtIndex:0];
    NSString *appId = [options objectForKey:@"appId"];
    
    [Pushmote startWithApplicationId:appId];
    
    NSString* message = @"Pushmote started";
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
}

+ (void)handleNotification:(UILocalNotification*)notification {
    [Pushmote handleNotification:notification];
}
     

@end
