//
//  AppDelegate.m
//  WMCNiOSapp
//
//  Created by Eivind Morris Bakke on 10/15/14.
//  Copyright (c) 2014 EivindMorrisBakke. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate (){
}
@property (strong, nonatomic) WMCNPlayer *WMCNPlayer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.WMCNPlayer = [WMCNPlayer sharedInstance];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if (!self.WMCNPlayer.isPlaying) {
        self.WMCNPlayer.playerNeedsReloading = YES;
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self.WMCNPlayer preparePlayer];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
