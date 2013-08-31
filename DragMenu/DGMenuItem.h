//
//  DGMenuItem.h
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"

@class DGMenuItem;

@protocol DGMenuItemDelegate
-(void)itemSelected:(DGMenuItem*)item atItemIndex:(NSInteger)indexinArray;
@end


@interface DGMenuItem : FUIButton

@property id<DGMenuItemDelegate> menu;
@property NSInteger index;

-(id)initMenuItemWithTitle:(NSString*)title width:(CGFloat)width height:(CGFloat)height buttonColor:(UIColor*)color titleFont:(UIFont*)font titleFontColor:(UIColor *)fontColor;

@end



