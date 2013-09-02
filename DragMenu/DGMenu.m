//
//  DGMenu.m
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import "DGMenu.h"
#import "DGMenuItem.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+FlatUI.h"

@implementation DGMenu
{
    CAGradientLayer* _gradientLayer;

}



-(id)initWithMenuItems:(NSArray *) menuItems

NSLSDASDF
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
        CGFloat menu_item_width = [[self.menuItems objectAtIndex:0] frame].size.width;
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
        self.delegate = self;
        [self setBackgroundColor:[UIColor peterRiverColor]];
        
        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:0.6f alpha:0.5f] CGColor],
                                  (id)[[UIColor colorWithWhite:0.6f alpha:0.6f] CGColor],
                                  (id)[[UIColor colorWithWhite:0.6f alpha:0.6f] CGColor],
                                  (id)[[UIColor colorWithWhite:0.6f alpha:0.5f] CGColor]];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];

        CGRect gradientFrame = CGRectMake(scrollViewWindowWidth/2, 0, menu_item_width, menu_item_height);
        UIView * gradientView = [[UIView alloc] initWithFrame:gradientFrame];
        _gradientLayer.bounds = gradientView.bounds;
        [[gradientView layer]addSublayer: _gradientLayer];
        [self addSubview:gradientView];
      
        

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

    NSLog(@"in scroll view did end decelerating");
    [self computeCenter];



}
-(void)computeCenter
{

    
    CGFloat x_offset = [self contentOffset].x;
    CGFloat item_width = [[[self menuItems] objectAtIndex:0]frame].size.width;
    
    if(x_offset>0)
    {
        int numberOfItemsOfScreen = x_offset/item_width;
        int numberOfItemsPartiallyOfScreen = (int)x_offset % (int)item_width;
        
        if(numberOfItemsPartiallyOfScreen!=0)
        {
            int items_count=[[self menuItems] count];
            if(numberOfItemsOfScreen+1<items_count)
            {
                int i = numberOfItemsOfScreen+1;
                DGMenuItem* candidate = [[self menuItems] objectAtIndex:i];
                CGFloat x_min = (numberOfItemsOfScreen*item_width)-x_offset;
                CGFloat x_max = x_min+[candidate frame].size.width;
                CGFloat screen_x_center = [[UIScreen mainScreen]bounds].size.width/2.0;
                i++;
                
                while(!(x_min < screen_x_center && screen_x_center< x_max)&&i<items_count)
                {
                    candidate = [[self menuItems] objectAtIndex:i];
                    x_min = x_max;
                    x_max = x_min+[candidate frame].size.width;
                    i++;
                    
                }
                
                if(x_min < screen_x_center && screen_x_center< x_max)
                {
                    //found the candidate. Now align it to the center.
                    CGFloat item_center_x_position = x_min+item_width/2.0;
                    if(item_center_x_position>screen_x_center)
                    {
                        CGFloat delta_x = item_center_x_position-screen_x_center;
                        CGPoint offset;
                        offset.x = [self contentOffset].x+delta_x;
                        offset.y = 0;
                        
                        [self setContentOffset:offset animated:YES];
                        
                        
                    }
                    else if(item_center_x_position<screen_x_center)
                    {
                        CGFloat delta_x = screen_x_center-item_center_x_position;
                        CGPoint offset;
                        offset.x = [self contentOffset].x-delta_x;
                        offset.y = 0;
                        [self setContentOffset:offset animated:YES];
                        
                    }
                    
                    
                }
                
                
            }
            
            
        }
        else
        {
            
            
            int items_count=[[self menuItems] count];
            if(numberOfItemsOfScreen<items_count)
            {
                int i = numberOfItemsOfScreen;
                DGMenuItem* candidate = [[self menuItems] objectAtIndex:i];
                CGFloat x_min = (numberOfItemsOfScreen*item_width)-x_offset;
                CGFloat x_max = x_min+[candidate frame].size.width;
                CGFloat screen_x_center = [[UIScreen mainScreen]bounds].size.width/2.0;
                i++;
                
                while(!(x_min < screen_x_center && screen_x_center< x_max)&&i<items_count)
                {
                    candidate = [[self menuItems] objectAtIndex:i];
                    x_min = x_max;
                    x_max = x_min+[candidate frame].size.width;
                    i++;
                    
                }
                
                if(x_min < screen_x_center && screen_x_center< x_max)
                {
                    //found the candidate. Now align it to the center.
                    CGFloat item_center_x_position = x_min+item_width/2.0;
                    if(item_center_x_position>screen_x_center)
                    {
                        CGFloat delta_x = item_center_x_position-screen_x_center;
                        CGPoint offset;
                        offset.x = [self contentOffset].x+delta_x;
                        offset.y = 0;
                        
                        [self setContentOffset:offset animated:YES];
                        
                        
                    }
                    else if(item_center_x_position<screen_x_center)
                    {
                        CGFloat delta_x = screen_x_center-item_center_x_position;
                        CGPoint offset;
                        offset.x = [self contentOffset].x-delta_x;
                        offset.y = 0;
                        [self  setContentOffset:offset animated:YES];
                        
                    }
                    
                    
                }
                
                
            }
            
            
            
        }
        
        
        
        
        
        
    }
    else
    {
        CGPoint offset;
        offset.x = 0;
        offset.y = 0;
        
        [self setContentOffset:offset animated:YES];
        
    }
    
    
    


}
@end
