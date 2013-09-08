//
//  DGMenu.h
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGMenuItem.h"
@class DGNavigationController;
@class DGMenuItem;

@protocol DGMenuDelegate
-(void)selectedMenuItem:(DGMenuItem*)item atIndex:(NSInteger)indexinArray;

@end

@interface DGMenu : UIView<UIScrollViewDelegate,DGMenuItemDelegate>

@property NSArray * menuItems;
@property UIScrollView* scrollView;
@property(nonatomic,strong) id<DGMenuDelegate> menuDelegate;
@property(nonatomic,weak) DGNavigationController* parent_ViewController;

-(id)initWithMenuItems:(NSArray *) menuItems ;
-(void)shiftToCenter:(DGMenuItem*)item atIndex:(NSInteger)indexInArray;



@end


