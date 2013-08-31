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

@end
