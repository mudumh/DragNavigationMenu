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
                //NSLog(@"the item number is : %d",i);
                DGMenuItem * item = (DGMenuItem *)[self.menuItems objectAtIndex:i];
                item.index = i;
                item.menu=self;
                [item setTitle:@"test" forState:UIControlStateNormal];
                CGRect item_frame = [item bounds];
                item_frame.origin.x= current_x;
                item_frame.origin.y= current_y;
                //NSLog(@"the item x origin  is : %f",item_frame.origin.x);
                //NSLog(@"the item y origin  is : %f",item_frame.origin.y);
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
        //self.delegate = self;

    }
    
    return self;
}

-(void)itemSelected:(DGMenuItem*)item atItemIndex:(NSInteger)indexinArray
{
    
    [[self menuDelegate] selectedMenuItem:item atIndex:indexinArray];

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
      [self computeCenter];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{





}
-(void)computeCenter
{

    NSLog(@"calling the scrollViewDidEndDragging");
    // NSLog(@"the x -content offset right now is  : %f",[self contentOffset].x);
    CGFloat half_screen_width = [[UIScreen mainScreen] bounds].size.width/2.0;
    CGFloat content_offset_item = [self contentOffset].x+half_screen_width;
    CGFloat center_item_index;
    NSArray* items =  [self  menuItems];
    DGMenuItem* center_item= [items objectAtIndex:0];
    CGFloat min_offset= fabs(content_offset_item);
    CGFloat item_width = [center_item frame].size.width;
    
    for(int i = 0 ; i <[items count];i++)
    {
        //compute the content offset of this item
        
        content_offset_item = content_offset_item-item_width;
        item_width= [[items objectAtIndex:i] frame].size.width;
        if(fabs(content_offset_item)<min_offset)
        {
            //  NSLog(@"hitting the for loop");
            min_offset =fabs(content_offset_item);
            center_item = [items objectAtIndex:i];
            center_item_index=i;
            //NSLog(@"the center item index is : %d",[center_item index]);
            
        }
        
    }
    //animate the contentview so that the center item is in the center
    
    //the x_co-or of center_item
    
    CGFloat x = half_screen_width-[center_item frame].size.width/2.0;
    CGFloat i_items_width = center_item_index*(item_width);
    CGPoint offset;
    offset.x = i_items_width-x;
    offset.y = 0;
    [self setContentOffset:offset animated:YES];













}
@end
