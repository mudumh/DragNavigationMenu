//
//  DGNavigationController.m
//  DragMenu
//
//  Created by Harsha Vardhan on 9/3/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import "DGNavigationController.h"

@interface DGNavigationController ()

@end

@implementation DGNavigationController
{
    CGFloat contentWidth;
    CGFloat contentHeight;
    NSArray* menuItems;
    CGFloat screenWidth; 
    
    

}
@synthesize scrollMenu,viewControllers,viewControllersScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithMenu:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)initWithMenu:(DGMenu *)menu
{

    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        if(menu!=nil)
        {
            self.scrollMenu=menu;
            [menu setParent_ViewController:self];
             menuItems = [[self scrollMenu] menuItems];
            for(int i = 0;i<[menuItems count];i++)
            {
                DGMenuItem * item = (DGMenuItem*)menuItems[i];
                self.viewControllers[i] = item.menuItemController;
            
            }
            screenWidth = [[UIScreen mainScreen] bounds].size.width;
            contentWidth = [menuItems count]*screenWidth;
            
        }

        
    
    }
    
    return self;
    



}
-(void)loadView
{
    
    
    CGFloat menuHeight = [self scrollMenu].frame.size.height;
    
    CGFloat screenHeight  =[[UIScreen mainScreen] bounds].size.height;
    
    CGRect scrollViewOfViewControllers_frame = CGRectMake(0,menuHeight,screenWidth,screenHeight);
    
    self.viewControllersScrollView =[[UIScrollView alloc] initWithFrame:scrollViewOfViewControllers_frame];
    CGSize contentSize;
    contentSize.width= contentWidth;
    // to do. edit this for the generic case.
    contentSize.height= screenHeight;
    [self.viewControllersScrollView setContentSize:contentSize];
    //add the views to the scrollview
    
    [self.viewControllersScrollView setPagingEnabled:YES];
    [self.viewControllersScrollView setDelegate:self];
    CGRect newFrameForItem ;
    CGFloat current_x =0;
    for(int i =0;i<[menuItems count];i++)
    {
        
        UIView * menuItemView = [[(DGMenuItem*)[menuItems objectAtIndex:i]menuItemController] view];
                             
        newFrameForItem.origin.x = current_x;
        newFrameForItem.origin.y = 0;
        newFrameForItem.size.width = screenWidth;
        newFrameForItem.size.height = screenHeight;
        [menuItemView setFrame:newFrameForItem];
        [self.viewControllersScrollView addSubview:menuItemView];
        current_x=current_x+screenWidth;
       
    }
    
    
    
    CGRect  fullScreenFrame = CGRectMake(0, 0,screenWidth ,screenHeight );
    UIView * currentView =[[ UIView alloc] initWithFrame:fullScreenFrame];
    
    [currentView addSubview:scrollMenu];
    
    
    [currentView addSubview:self.viewControllersScrollView];
    
    self.view = currentView;
    
    
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger menu_index = 0;
    menu_index = [self viewControllersScrollView].contentOffset.x/screenWidth;
    [[self scrollMenu]shiftToCenter:[[scrollMenu menuItems] objectAtIndex:menu_index] atIndex:menu_index];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger menu_index = 0;
    menu_index = [self viewControllersScrollView].contentOffset.x/screenWidth;
    [[self scrollMenu]shiftToCenter:[[scrollMenu menuItems] objectAtIndex:menu_index] atIndex:menu_index];
    
}

@end
