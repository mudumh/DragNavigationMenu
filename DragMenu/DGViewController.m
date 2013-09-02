//
//  DGViewController.m
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import "DGViewController.h"
#import "DGViewControllerGreenViewController.h"

@interface DGViewController ()

@end

@implementation DGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectedMenuItem:(DGMenuItem*)item atIndex:(NSInteger)indexinArray
{
    
    NSLog(@"in the final method");
    if(indexinArray==0)
    {
               
        NSLog(@"Selected gray button");
    
    }
    if(indexinArray==1)
        
        
    {
        
        DGViewControllerGreenViewController * controller =
        [[DGViewControllerGreenViewController alloc] init];
        [controller setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:controller animated:YES completion:nil];

        
        NSLog(@"Selected green button");
        
        
    }
    if(indexinArray==2)
    {
    NSLog(@"Selected purple button");
        
    }
    
    if(indexinArray==3)
    {
    NSLog(@"Selected black button");
    
    }
    if(indexinArray==4)
    {
    NSLog(@"Selected brown button");
    }

    if(indexinArray==5)
    {
        NSLog(@"Selected magenta button");
    }
    if(indexinArray==6)
    {
        NSLog(@"Selected blue button");
    }
}

- (IBAction)pressed:(id)sender
{
    
    CGFloat x_offset = [[self menu] contentOffset].x;
    CGFloat item_width = [[[[self menu] menuItems] objectAtIndex:0]frame].size.width;
    
    if(x_offset>0)
    {
        int numberOfItemsOfScreen = x_offset/item_width;
        int numberOfItemsPartiallyOfScreen = (int)x_offset % (int)item_width;
        
        if(numberOfItemsPartiallyOfScreen!=0)
        {
            int items_count=[[[self menu] menuItems] count];
            if(numberOfItemsOfScreen+1<items_count)
            {
                int i = numberOfItemsOfScreen+1;
                DGMenuItem* candidate = [[[self menu] menuItems] objectAtIndex:i];
                CGFloat x_min = (numberOfItemsOfScreen*item_width)-x_offset;
                CGFloat x_max = x_min+[candidate frame].size.width;
                CGFloat screen_x_center = [[UIScreen mainScreen]bounds].size.width/2.0;
                i++;
                
                while(!(x_min < screen_x_center && screen_x_center< x_max)&&i<items_count)
                {   
                    candidate = [[[self menu] menuItems] objectAtIndex:i];
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
                        offset.x = [[self menu] contentOffset].x+delta_x;
                        offset.y = 0;
                        
                        [[self menu] setContentOffset:offset animated:YES];
                    
                    
                    }
                    else if(item_center_x_position<screen_x_center)
                    {
                        CGFloat delta_x = screen_x_center-item_center_x_position;
                        CGPoint offset;
                        offset.x = [[self menu] contentOffset].x-delta_x;
                        offset.y = 0;
                        [[self menu] setContentOffset:offset animated:YES];
                    
                    }
                    
                
                }
            
            
            }
            
        
        }
        else
        {
            
           
                int items_count=[[[self menu] menuItems] count];
                if(numberOfItemsOfScreen<items_count)
                {
                    int i = numberOfItemsOfScreen;
                    DGMenuItem* candidate = [[[self menu] menuItems] objectAtIndex:i];
                    CGFloat x_min = (numberOfItemsOfScreen*item_width)-x_offset;
                    CGFloat x_max = x_min+[candidate frame].size.width;
                    CGFloat screen_x_center = [[UIScreen mainScreen]bounds].size.width/2.0;
                    i++;
                    
                    while(!(x_min < screen_x_center && screen_x_center< x_max)&&i<items_count)
                    {
                        candidate = [[[self menu] menuItems] objectAtIndex:i];
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
                            offset.x = [[self menu] contentOffset].x+delta_x;
                            offset.y = 0;
                            
                            [[self menu] setContentOffset:offset animated:YES];
                            
                            
                        }
                        else if(item_center_x_position<screen_x_center)
                        {
                            CGFloat delta_x = screen_x_center-item_center_x_position;
                            CGPoint offset;
                            offset.x = [[self menu] contentOffset].x-delta_x;
                            offset.y = 0;
                            [[self menu] setContentOffset:offset animated:YES];
                            
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

    [[self menu] setContentOffset:offset animated:YES];

}
    
    
    
    
    
}
@end
