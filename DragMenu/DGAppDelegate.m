//
//  DGAppDelegate.m
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import "DGAppDelegate.h"


#import "DGMenuItem.h"
#import "DGMenu.h"
#import "UIColor+FlatUI.h"
#import "VC1.h"
#import "VC2.h"
#import "VC3.h"
#import "VC4.h"
#import "VC5.h"
#import "DGNavigationController.h"

@implementation DGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
        
    // specify the width and height for a single menu item
    CGFloat width = 150;
    CGFloat height = 50;
    // VC1, VC2, VC3, VC4 , VC5 are views controller.Each views controller corresponds to one menu item.
    VC1 * one = [[VC1 alloc] init];
    VC2 * two = [[VC2 alloc] init];
    VC3 * three = [[VC3 alloc] init];
    VC4 * four = [[VC4 alloc] init];
    VC5 * five = [[VC5 alloc] init];

    
    //Create 5 different menu items. One for each of the views controller's created above.
    //You can specify the color of each menu item and the font for the title.If font is nil, then default font will be used.
    //USE THE SAME WIDTH and HEIGHT FOR EACH MENU ITEM.
    
    
    
    DGMenuItem * menu_item_1 = [[DGMenuItem alloc] initMenuItemWithTitle:@"View 1" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor] withViewController:one];
    
    DGMenuItem * menu_item_2 = [[DGMenuItem alloc] initMenuItemWithTitle:@"View 2" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor] withViewController:two];
    
    DGMenuItem * menu_item_3 = [[DGMenuItem alloc] initMenuItemWithTitle:@"View 3" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor] withViewController:three];
    
    DGMenuItem * menu_item_4 = [[DGMenuItem alloc] initMenuItemWithTitle:@"View 4" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor] withViewController:four];

    DGMenuItem * menu_item_5 = [[DGMenuItem alloc] initMenuItemWithTitle:@"View 5" width:width height:height buttonColor:[UIColor peterRiverColor] titleFont:nil titleFontColor:[UIColor whiteColor] withViewController:five];
    
    
  
    
   //CREATE A MENU CONTAINING THE MENU ITEMS CREATED ABOVE.
    DGMenu* menu = [[DGMenu alloc] initWithMenuItems:[[NSArray alloc] initWithObjects:menu_item_1,menu_item_2,menu_item_3,menu_item_4,menu_item_5,nil]];
    // CREATE A DGNavigationController and initialize it with the menu.
    DGNavigationController* navigationController = [[DGNavigationController alloc] initWithMenu:menu];
    
    // SET THE navigation controller as the root view controller.
    self.viewController= navigationController;
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
