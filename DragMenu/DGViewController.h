//
//  DGViewController.h
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGMenu.h"
@interface DGViewController : UIViewController <DGMenuDelegate>
- (IBAction)pressed:(id)sender;

@property(strong,nonatomic) DGMenu * menu;
@end
