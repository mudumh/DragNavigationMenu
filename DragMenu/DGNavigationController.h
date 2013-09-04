//
//  DGNavigationController.h
//  DragMenu
//
//  Created by Harsha Vardhan on 9/3/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGMenu.h"
@interface DGNavigationController : UIViewController
-(id)initWithMenu:(DGMenu *)menu;
@property(nonatomic,strong)DGMenu* scrollMenu;
@property(nonatomic,strong) UIScrollView* viewControllersScrollView;
@property(nonatomic,strong) NSMutableArray *viewControllers;

@end
