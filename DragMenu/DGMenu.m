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
#import "DGNavigationController.h"

@implementation DGMenu
{
    CAGradientLayer* _gradientLayer;
    CGFloat gap;
    CGFloat menu_item_width ;
    CGFloat scrollViewWindowWidth;
    CGFloat screenWidth;
    UIScrollView* viewControllerScrollView;
    
}
@synthesize scrollView,menuDelegate,parent_ViewController;



-(id)initWithMenuItems:(NSArray *) menuItems


{
    DGMenuItem * any_item = [menuItems objectAtIndex:0];
    CGFloat menu_item_height =    [any_item frame].size.height;
    screenWidth=[[UIScreen mainScreen] bounds].size.width;
    scrollViewWindowWidth =  screenWidth;
    CGRect frame = CGRectMake(0, 0, scrollViewWindowWidth, menu_item_height);

    
    self = [super initWithFrame:frame];
    if(self)
    {
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.menuItems = menuItems;
        
        menu_item_width = [[self.menuItems objectAtIndex:0] frame].size.width;
        CGFloat current_x = 0+scrollViewWindowWidth/2.0-menu_item_width/2.0;
        CGFloat current_y = 0;
        
        for(int i =0 ; i < [self.menuItems count];i++)
            {
              
                DGMenuItem * item = (DGMenuItem *)[self.menuItems objectAtIndex:i];
                item.index = i;
                item.menu=self;
                [item setTitle:[item menuTitle] forState:UIControlStateNormal];
                CGRect item_frame = [item bounds];
                item_frame.origin.x= current_x;
                item_frame.origin.y= current_y;


                current_x = current_x+item_frame.size.width;
                [item setFrame:item_frame];

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
      
       self->gap= scrollViewWindowWidth/2.0-menu_item_width/2.0;
       self->menu_item_width = [[self.menuItems objectAtIndex:0] frame].size.width;
        

    }
    
    return self;
}

-(void)itemSelected:(DGMenuItem*)item atItemIndex:(NSInteger)indexinArray
{
    viewControllerScrollView=[self fetchViewControllerScrollView];
    [self shiftToCenter:item atIndex:indexinArray];
    [[self menuDelegate] selectedMenuItem:item atIndex:indexinArray];

}
-(UIScrollView*)fetchViewControllerScrollView
{
    if(viewControllerScrollView==nil)
    {
        viewControllerScrollView=[[self parent_ViewController] viewControllersScrollView];
    }
    return viewControllerScrollView;
    

}
-(void)shiftToCenter:(DGMenuItem*)item atIndex:(NSInteger)indexInArray
{
    
    
    CGPoint viewContentOffset;

    
    CGFloat x_offset = [self scrollView].contentOffset.x;
    
   
    if(x_offset>=0)
    {
        
    
        CGFloat current_x_of_item = gap+indexInArray*(menu_item_width)-x_offset;
        CGFloat target_x = scrollViewWindowWidth/2.0-menu_item_width/2.0;
        CGFloat delta_x=0;
        CGPoint offset;
        if(current_x_of_item > target_x)
        {
           
            delta_x = current_x_of_item-target_x;
            offset.x = delta_x+[[self scrollView] contentOffset].x;
            offset.y=[[self scrollView] contentOffset].y;
            [[self scrollView] setContentOffset:offset animated:YES];
            
            viewContentOffset.x= indexInArray*screenWidth;
            viewContentOffset.y= [viewControllerScrollView contentOffset].y;
            [viewControllerScrollView setContentOffset:viewContentOffset animated:YES];
           
            
        
        }
        else if(current_x_of_item < target_x)
        {
        
            delta_x = target_x-current_x_of_item;
            viewContentOffset.x= (indexInArray)*screenWidth;
            viewContentOffset.y= [viewControllerScrollView contentOffset].y;
            offset.x = [[self scrollView] contentOffset].x-delta_x;
            offset.y=[[self scrollView] contentOffset].y;
            [[self scrollView] setContentOffset:offset animated:YES];
            [viewControllerScrollView setContentOffset:viewContentOffset animated:YES];
        
        
        }
       
    }


}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
      [self computeCenter];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    [self computeCenter];

}
-(void)computeCenter

{
    CGFloat x_offset = [self.scrollView contentOffset].x;
    CGFloat item_width = [[[self menuItems] objectAtIndex:0]frame].size.width;
    viewControllerScrollView=[self fetchViewControllerScrollView];

    if(x_offset>0)
    {

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
            
            int items_count=[[self menuItems] count];
            

            
            
            if(numberOfItemsOfScreen+1<items_count)
            {
                
                int i = 0;
                DGMenuItem* candidate = [[self menuItems] objectAtIndex:i];
                
                CGFloat screen_x_center = [[UIScreen mainScreen]bounds].size.width/2.0;
                
                CGFloat x_min= - (x_offset)+gap;
                CGFloat x_max = x_min+[candidate frame].size.width;
                
                while(!(x_min < screen_x_center && screen_x_center< x_max)&&i<items_count)
                {
                   
                    i++;
                    candidate = [[self menuItems] objectAtIndex:i];
                    x_min = x_max;
                   
                    x_max = x_min+[candidate frame].size.width;
                   
                    
                    
                }
                if(i>=items_count)
                {
                   
                
                }
                
                if(x_min <= screen_x_center && screen_x_center<= x_max)
                {
                    CGFloat item_center_x_position = x_min+item_width/2.0;
                    if(item_center_x_position > screen_x_center)
                    {
                        CGFloat delta_x = item_center_x_position-screen_x_center;
                        CGPoint offset;
                        offset.x = [self.scrollView contentOffset].x+delta_x;
                        offset.y = 0;
                        [self.scrollView setContentOffset:offset animated:YES];
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    else if(item_center_x_position < screen_x_center)
                        
                    {
                        
                        CGFloat delta_x = screen_x_center-item_center_x_position;
                        CGPoint offset;
                        offset.x = [self.scrollView contentOffset].x-delta_x;
                        offset.y = 0;
                        [self.scrollView setContentOffset:offset animated:YES];
                        for(int i = 0 ; i <20000;i++)
                        {
                        
                        }
                        
                       
                        
                    }
                    CGPoint viewOffset;
                   
                    viewOffset.x = [candidate index]*screenWidth;
                   
                    viewOffset.y = [viewControllerScrollView contentOffset].y;
                   
                    [viewControllerScrollView setContentOffset:viewOffset animated:YES];
                    
                    
                    
                   
                    
                    
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
                
                
                
                while(!(x_min <= screen_x_center && screen_x_center <= x_max)&&i<items_count)
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
                        
                       
                        [self.scrollView setContentOffset:offset animated:YES];
                         
                        
                        
                    }
                    else if(item_center_x_position<screen_x_center)
                    {
                        CGFloat delta_x = screen_x_center-item_center_x_position;
                        CGPoint offset;
                        offset.x = [self.scrollView contentOffset].x-delta_x;
                        offset.y = 0;
                       
                        [self.scrollView  setContentOffset:offset animated:YES];
                        
                        
                    }
                    [[self menuDelegate] selectedMenuItem:candidate atIndex:candidate.index];
                    CGPoint viewOffset;
                    viewOffset.x = [candidate index]*screenWidth;
                    viewOffset.y = [viewControllerScrollView contentOffset].y;
                    [viewControllerScrollView setContentOffset:viewOffset animated:YES];
                    
                }
                
                
            }
            
            
            
        }
        
        
    }

    else
        
    {
     

        CGPoint offset;
        offset.x = 0;
        offset.y = 0;
        
     
        [self.scrollView setContentOffset:offset animated:YES];
        CGPoint viewOffset;
        viewOffset.x = 0;
        viewOffset.y = [viewControllerScrollView contentOffset].y;
        [viewControllerScrollView setContentOffset:viewOffset animated:YES];
        
    }
    
}
@end
