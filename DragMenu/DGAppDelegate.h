//
//  DGAppDelegate.h
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGViewController;
@class DGNavigationController;

@interface DGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DGNavigationController *viewController;

@end
