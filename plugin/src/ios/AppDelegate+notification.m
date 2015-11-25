//
//  AppDelegate+notification.m
//  pushtest
//  https://raw.githubusercontent.com/phonegap/phonegap-plugin-push/master/src/ios/AppDelegate%2Bnotification.m
//  Originally created by Robert Easterday on 10/26/12.
//
//

#import "AppDelegate+notification.h"
#import "PushmotePlugin.h"
#import <objc/runtime.h>

static char launchNotificationKey;

@implementation AppDelegate (notification)


// its dangerous to override a method from within a category.
// Instead we will use method swizzling. we set this up in the load call.
+ (void)load
{
    Method original, swizzled;
    
    original = class_getInstanceMethod(self, @selector(init));
    swizzled = class_getInstanceMethod(self, @selector(swizzled_init));
    method_exchangeImplementations(original, swizzled);
}

- (AppDelegate *)swizzled_init
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createNotificationChecker:)
                                                 name:@"UIApplicationDidFinishLaunchingNotification" object:nil];
    
    // This actually calls the original init method over in AppDelegate. Equivilent to calling super
    // on an overrided method, this is not recursive, although it appears that way. neat huh?
    return [self swizzled_init];
}

// This code will be called immediately after application:didFinishLaunchingWithOptions:. We need
// to process notifications in cold-start situations
- (void)createNotificationChecker:(NSNotification *)notification
{
    if (notification)
    {
        NSDictionary *launchOptions = [notification userInfo];
        if (launchOptions)
            self.launchNotification = [launchOptions objectForKey: @"UIApplicationLaunchOptionsLocalNotificationKey"];
    }
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [PushmotePlugin handleNotification:notification];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"active");
    
    if (self.launchNotification) {
        [PushmotePlugin handleNotification:self.launchNotification];
        self.launchNotification = nil;
    }
}


// The accessors use an Associative Reference since you can't define a iVar in a category
// http://developer.apple.com/library/ios/#documentation/cocoa/conceptual/objectivec/Chapters/ocAssociativeReferences.html
- (NSMutableArray *)launchNotification
{
    return objc_getAssociatedObject(self, &launchNotificationKey);
}

- (void)setLaunchNotification:(UILocalNotification *)notification
{
    objc_setAssociatedObject(self, &launchNotificationKey, notification, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)dealloc
{
    self.launchNotification = nil; // clear the association and release the object
}

@end
