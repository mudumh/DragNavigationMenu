//
//  DGMenuItem.h
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DGMenuItemDelegate;


@interface DGMenuItem : UIButton
@property id<DGMenuItemDelegate> delegate;


@end

@protocol DGMenuItemDelegate

-(void)menuItemPressed:(DGMenuItem*)item;

@end
