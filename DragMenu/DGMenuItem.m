//
//  DGMenuItem.m
//  DragMenu
//
//  Created by Harsha Vardhan on 8/29/13.
//  Copyright (c) 2013 Harsha Vardhan. All rights reserved.
//

#import "DGMenuItem.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@implementation DGMenuItem
@synthesize menu;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
       
    }
    return self;
}

-(void)buttonTapped
{

    [[self menu] itemSelected:(DGMenuItem*)self atItemIndex:self.index];

}


-(id)initMenuItemWithTitle:(NSString*)title width:(CGFloat)width height:(CGFloat)height buttonColor:(UIColor*)color titleFont:(UIFont*)font titleFontColor:(UIColor *)fontColor
{


    CGRect placeholderFrame = CGRectMake(0, 0, width, height);

    self = [super initWithFrame:placeholderFrame];
    if(self)
    {
        NSLog(@"the color is : %@",color);
        FUIButton* myButton = (FUIButton*)self;
        //myButton.buttonColor = [UIColor turquoiseColor];
        myButton.titleLabel.text = title;
        myButton.buttonColor = color;
        myButton.shadowColor = color;
        myButton.shadowHeight = 0.0f;
        myButton.cornerRadius = 0.0f;
        if(font==nil)
        {
        myButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        }
        else
        {
        myButton.titleLabel.font = font;
        }
        
        if(fontColor!=nil)
        {
            [myButton setTitleColor:fontColor forState:UIControlStateNormal];
            [myButton setTitleColor:fontColor forState:UIControlStateHighlighted];
        
        }
        else
        {
            [myButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
            [myButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        
        }

        
        [myButton addTarget:self
                     action:@selector(buttonTapped)
           forControlEvents:UIControlEventTouchDown];
        
    }
    
    return self;
    
}


@end
