//
//  DGAppDelegate.m
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import "DGAppDelegate.h"

#import "DGViewController.h"
#import "DGMenuItem.h"
#import "DGMenu.h"
#import "UIColor+FlatUI.h"

@implementation DGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[DGViewController alloc] initWithNibName:@"DGViewController" bundle:nil];
    
    CGFloat width = 150;
    CGFloat height = 50;
    
    DGMenuItem * menu_item_1 = [[DGMenuItem alloc] initMenuItemWithTitle:@"1" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor]];
    
    DGMenuItem * menu_item_2 = [[DGMenuItem alloc] initMenuItemWithTitle:@"2" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor]];
    
    DGMenuItem * menu_item_3 = [[DGMenuItem alloc] initMenuItemWithTitle:@"3" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor]];
    
    DGMenuItem * menu_item_4 = [[DGMenuItem alloc] initMenuItemWithTitle:@"4" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor]];

    DGMenuItem * menu_item_5 = [[DGMenuItem alloc] initMenuItemWithTitle:@"5" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor]];
    
    DGMenuItem * menu_item_6 = [[DGMenuItem alloc] initMenuItemWithTitle:@"6" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor]];
    
    DGMenuItem * menu_item_7 = [[DGMenuItem alloc] initMenuItemWithTitle:@"7" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor]];
    
    CGFloat scrollViewWindowWidth =  [[UIScreen mainScreen] bounds].size.width;
    //scrollViewWindowHeight should ideally be the same as the height of a menu item.
    CGFloat scrollViewWindowHeight =  50;
    
    DGMenu* menu = [[DGMenu alloc] initWithMenuItems:[[NSArray alloc] initWithObjects:menu_item_1,menu_item_2,menu_item_3,menu_item_4,menu_item_5,menu_item_6,menu_item_7,nil]];
   // [menu setPagingEnabled:YES];
    self.viewController.menu = menu;
    menu.menuDelegate = self.viewController;
    
    
    [self.viewController.view addSubview:menu];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
