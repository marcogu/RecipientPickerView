//
//  AppDelegate.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-10.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"
#import "TestTargetController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
//    [self templateCode];
    [self myTestCode];
    return YES;
}

-(void)myTestCode{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    TestTargetController* testTarget = [[[TestTargetController alloc] initWithNibName:nil bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:testTarget] autorelease];
    self.window.rootViewController = self.navigationController;
//    [self.navigationController setNavigationBarHidden:YES];
    [self.window makeKeyAndVisible];
}

-(void)templateCode{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    MasterViewController *masterViewController = [[[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
}

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}


@end
