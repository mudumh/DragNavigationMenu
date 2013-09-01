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

- (IBAction)pressed:(id)sender {
    
    
    //find the content offsets of each frame wrt to the center.
    // the frame with the minimum content offset wrt to the center should be moved the center of the screen.
    
    NSLog(@"the x -content offset right now is  : %f",[self.menu contentOffset].x);
    CGFloat half_screen_width = [[UIScreen mainScreen] bounds].size.width/2.0;
    CGFloat content_offset_item = [self.menu contentOffset].x+half_screen_width;
    CGFloat center_item_index;
    NSArray* items =  [[self menu] menuItems];
    DGMenuItem* center_item= [items objectAtIndex:0];
    CGFloat min_offset= fabs(content_offset_item);
    CGFloat item_width = [center_item frame].size.width;

    for(int i = 0 ; i <[items count];i++)
    {
    //compute the content offset of this item
    
        content_offset_item = content_offset_item-item_width;
        item_width= [[items objectAtIndex:i] frame].size.width;
        if(fabs(content_offset_item)<min_offset)
        {   NSLog(@"hitting the for loop");
            min_offset =fabs(content_offset_item);
            center_item = [items objectAtIndex:i];
            center_item_index=i;
            NSLog(@"the center item index is : %d",[center_item index]);
            
        }
    
    
    }
    //animate the contentview so that the center item is in the center
    
    //the x_co-or of center_item

    CGFloat x = half_screen_width-[center_item frame].size.width/2.0;
    CGFloat i_items_width = center_item_index*(item_width);
    CGPoint offset;
    offset.x = i_items_width-x;
    offset.y = 0;
    [[self menu] setContentOffset:offset animated:YES];
    
    
    
    
}
@end
