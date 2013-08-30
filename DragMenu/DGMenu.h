//
//  DGMenu.h
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DGMenuItem;

@interface DGMenu : UIScrollView<UIScrollViewDelegate>

@property NSArray * menuItems;
-(id)initWithMenuItems:(NSArray *) menuItems;

@end
