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
@synthesize scrollView;



-(id)initWithMenuItems:(NSArray *) menuItems


{
    DGMenuItem * any_item = [menuItems objectAtIndex:0];
    CGFloat menu_item_height =    [any_item frame].size.height;
    CGFloat scrollViewWindowWidth =  [[UIScreen mainScreen] bounds].size.width;
    CGRect frame = CGRectMake(0, 0, scrollViewWindowWidth, menu_item_height);

    
    self = [super initWithFrame:frame];
    if(self)
    {
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.menuItems = menuItems;
        
        CGFloat menu_item_width = [[self.menuItems objectAtIndex:0] frame].size.width;
        CGFloat current_x = 0+scrollViewWindowWidth/2.0-menu_item_width/2.0;
        CGFloat current_y = 0;
        NSLog(@"!!! The menu item width is : %f",menu_item_width);
        for(int i =0 ; i < [self.menuItems count];i++)
            {
                //NSLog(@"the item number is : %d",i);
                DGMenuItem * item = (DGMenuItem *)[self.menuItems objectAtIndex:i];
                item.index = i;
                item.menu=self;
                [item setTitle:[item menuTitle] forState:UIControlStateNormal];
                CGRect item_frame = [item bounds];
                item_frame.origin.x= current_x;
                item_frame.origin.y= current_y;

                //NSLog(@"the item x origin  is : %f",item_frame.origin.x);
                //NSLog(@"the item y origin  is : %f",item_frame.origin.y);
                current_x = current_x+item_frame.size.width;
                [item setFrame:item_frame];
                //[item setBackgroundColor:[UIColor blackColor]];
                [scrollView addSubview:item];
            
            }
        [self addSubview:self.scrollView];
        
        
        CGSize content_size;
        content_size.width= current_x+scrollViewWindowWidth/2.0-menu_item_width/2.0;
        content_size.height= menu_item_height;


        [self.scrollView setContentSize:content_size];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        self.scrollView.delegate = self;
        [self setBackgroundColor:[UIColor peterRiverColor]];
        
        _gradientLayer = [CAGradientLayer layer];

        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:0.2f alpha:0.9f] CGColor],
                                  (id)[[UIColor colorWithWhite:02.f alpha:0.9f] CGColor],
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor colorWithWhite:0.2f alpha:0.9f] CGColor]];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
        CGRect layer_bounds = CGRectMake(0, 0, menu_item_width, menu_item_height);
        _gradientLayer.bounds = layer_bounds;
        CGPoint position;
        position.x = scrollViewWindowWidth/2;
        position.y = menu_item_height/2;
        _gradientLayer.position = position;
        [[self layer] addSublayer:_gradientLayer];
      
        

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
     NSLog(@"in compute center");
    CGFloat scrollViewWindowWidth =  [[UIScreen mainScreen] bounds].size.width;
    CGFloat menu_item_width = [[self.menuItems objectAtIndex:0] frame].size.width;
//   CGFloat x_offset = [self.scrollView contentOffset].x-scrollViewWindowWidth/2.0-menu_item_width/2.0;
    CGFloat x_offset = [self.scrollView contentOffset].x;
    CGFloat item_width = [[[self menuItems] objectAtIndex:0]frame].size.width;
    CGFloat gap =  scrollViewWindowWidth/2.0-menu_item_width/2.0;
    NSLog(@"the gap is : %f",gap);
    if(x_offset>0)
    {
        NSLog(@"in x_offset>0");
        int numberOfItemsOfScreen = (x_offset-gap)/item_width;
        BOOL isthereAnItemPartiallyOfScreen;
        if(x_offset<gap)
        {
        isthereAnItemPartiallyOfScreen =NO;
        
        }
        else
        {
        
            if((int)x_offset- (int)gap % (int)item_width==0)
            {
                isthereAnItemPartiallyOfScreen =NO;
            }
            else
            {
                isthereAnItemPartiallyOfScreen =YES;
                
            }
        
        }
        
        
        

        
        if(isthereAnItemPartiallyOfScreen==YES)
        {
            NSLog(@"in isthereAnItemPartiallyOfScreen==YES");
            int items_count=[[self menuItems] count];
            NSLog(@"numberOfItemsOfScreen is : %d",numberOfItemsOfScreen);
            NSLog(@"items_count is : %d",items_count);

            
            if(numberOfItemsOfScreen+1<items_count)
            {
                
                NSLog(@"in numberOfItemsOfScreen+1<items_count");
                int i = numberOfItemsOfScreen+1;
                DGMenuItem* candidate = [[self menuItems] objectAtIndex:i];
                //CGFloat x_min = (numberOfItemsOfScreen*item_width)-x_offset;
                CGFloat x_min = item_width-(((int)x_offset-(int)gap)%(int)item_width);
                CGFloat x_max = x_min+[candidate frame].size.width;
                CGFloat screen_x_center = [[UIScreen mainScreen]bounds].size.width/2.0;
                NSLog(@"the value of x_min is %f",x_min);
                NSLog(@"the value of x_max is %f",x_max);
                NSLog(@"the value of screen_center is : %f",screen_x_center);
                NSLog(@"the x offset is : %f",x_offset);
                NSLog(@"the gap is : %f",gap);
                NSLog(@"numberofItems off screen : %d",(int)x_offset- (int)gap % (int)item_width);
                
                NSLog(@"value is i ,before the while is : %d",i);
                while(!(x_min < screen_x_center && screen_x_center< x_max)&&i<items_count)
                {
                   NSLog(@"in while 1");
                    candidate = [[self menuItems] objectAtIndex:i];
                    x_min = x_max;
                    NSLog(@"the value of x_min is %f",x_min);
                    x_max = x_min+[candidate frame].size.width;
                    if(x_min <= screen_x_center && screen_x_center<= x_max)
                    {
                        break;
                    }
                    i++;
                    
                }
                if(i>=items_count)
                {
                    NSLog(@"i==itemscount");
                    NSLog(@"value is i : %d",i);
                    NSLog(@"value of items_counts is : %d",items_count);
                
                }
                
                if(x_min <= screen_x_center && screen_x_center<= x_max)
                {
                    //found the candidate. Now align it to the center.
                    CGFloat item_center_x_position = x_min+item_width/2.0;
                    if(item_center_x_position > screen_x_center)
                    {
                        CGFloat delta_x = item_center_x_position-screen_x_center;
                        CGPoint offset;
                        offset.x = [self.scrollView contentOffset].x+delta_x;
                        offset.y = 0;
                        NSLog(@"!!!!Hit 1");
                        [self.scrollView setContentOffset:offset animated:YES];
                        
                        
                    }
                    else if(item_center_x_position < screen_x_center)
                        
                    {
                        NSLog(@"!!!!Hit 2");
                        CGFloat delta_x = screen_x_center-item_center_x_position;
                        CGPoint offset;
                        offset.x = [self.scrollView contentOffset].x-delta_x;
                        offset.y = 0;
                        [self.scrollView setContentOffset:offset animated:YES];
                        
                    }
                    
                    
                }
                
                
            }
            
            
        }
       // isthereAnItemPartiallyOfScreen==NO
        else
        {
            

            int items_count=[[self menuItems] count];
            if(numberOfItemsOfScreen<items_count)
            {
                int i = numberOfItemsOfScreen;
                DGMenuItem* candidate = [[self menuItems] objectAtIndex:i];
                //this is the first item on screen.
                CGFloat x_min = 0;
                
                if(x_offset<gap)
                {
                    x_min= gap-x_offset;
                
                }

                CGFloat x_max = x_min+[candidate frame].size.width;
                CGFloat screen_x_center = [[UIScreen mainScreen]bounds].size.width/2.0;
                i++;
                
                NSLog(@"section 3");
                NSLog(@"the value of x_min is %f",x_min);
                NSLog(@"the value of x_max is %f",x_max);
                NSLog(@"the value of screen_center is : %f",screen_x_center);
                NSLog(@"the x offset is : %f",x_offset);
                NSLog(@"the gap is : %f",gap);
                NSLog(@"numberofItems off screen : %d",(int)x_offset- (int)gap % (int)item_width);
                NSLog(@"section 3");
                
                while(!(x_min < screen_x_center && screen_x_center < x_max)&&i<items_count)
                {
                    candidate = [[self menuItems] objectAtIndex:i];
                    x_min = x_max;
                    x_max = x_min+[candidate frame].size.width;
                    

                    i++;
                    
                }
                
                if(x_min <= screen_x_center && screen_x_center<= x_max)
                {
                    //found the candidate. Now align it to the center.
                    CGFloat item_center_x_position = x_min+item_width/2.0;
                    if(item_center_x_position>screen_x_center)
                    {
                        CGFloat delta_x = item_center_x_position-screen_x_center;
                        CGPoint offset;
                        offset.x = [self.scrollView contentOffset].x+delta_x;
                        offset.y = 0;
                        
                        NSLog(@"!!!!Hit 3");
                        [self.scrollView setContentOffset:offset animated:YES];
                        
                        
                    }
                    else if(item_center_x_position<screen_x_center)
                    {
                        CGFloat delta_x = screen_x_center-item_center_x_position;
                        CGPoint offset;
                        offset.x = [self.scrollView contentOffset].x-delta_x;
                        offset.y = 0;
                        NSLog(@"!!!!Hit 4");
                        [self.scrollView  setContentOffset:offset animated:YES];
                        
                    }
                    
                    
                }
                
                
            }
            
            
            
        }
        
        
        
        
        
        
    }
    //offset it negative
    else
        
        
    {
        NSLog(@"in x_offset<0");

        CGPoint offset;
        offset.x = 0;
        offset.y = 0;
        
        NSLog(@"!!!!Hit 5");
        [self.scrollView setContentOffset:offset animated:YES];
        
    }
    
}
@end
