//
//  DGMenu.m
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import "DGMenu.h"
#import "DGMenuItem.h"

@implementation DGMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(id)initWithMenuItems:(NSArray *) menuItems
{

    self.menuItems = menuItems;
    for(int i =0 ; i < [self.menuItems count];i++)
    {
        DGMenuItem * item = (DGMenuItem *)[self.menuItems objectAtIndex:i];
        
        
    
    
    
    
    }



}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
