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
{


}



-(id)initWithMenuItems:(NSArray *) menuItems 
{
    DGMenuItem * any_item = [menuItems objectAtIndex:0];
    CGFloat menu_item_height =    [any_item frame].size.height;
    CGFloat scrollViewWindowWidth =  [[UIScreen mainScreen] bounds].size.width;
    CGRect frame = CGRectMake(0, 0, scrollViewWindowWidth, menu_item_height);
    
    self = [super initWithFrame:frame];
    if(self)
    {

        self.menuItems = menuItems;
        CGFloat current_x = 0;
        CGFloat current_y = 0;
        for(int i =0 ; i < [self.menuItems count];i++)
            {
                NSLog(@"the item number is : %d",i);
                DGMenuItem * item = (DGMenuItem *)[self.menuItems objectAtIndex:i];
                item.index = i;
                item.menu=self;
                [item setTitle:@"test" forState:UIControlStateNormal];
                CGRect item_frame = [item bounds];
                item_frame.origin.x= current_x;
                item_frame.origin.y= current_y;
                NSLog(@"the item x origin  is : %f",item_frame.origin.x);
                NSLog(@"the item y origin  is : %f",item_frame.origin.y);
                current_x = current_x+item_frame.size.width;
                [item setFrame:item_frame];
                //[item setBackgroundColor:[UIColor blackColor]];
                [self addSubview:item];
            
            }
        CGSize content_size;
        content_size.width= current_x;
        content_size.height= menu_item_height;
        [self setContentSize:content_size];
        [self setShowsHorizontalScrollIndicator:NO];

    }
    
    return self;
}

-(void)itemSelected:(DGMenuItem*)item atItemIndex:(NSInteger)indexinArray
{
    
    [[self menuDelegate] selectedMenuItem:item atIndex:indexinArray];




}

@end
