//
//  SlideyMenuGuy.m
//  SlideyMenuGuy
//
//  Created by Josh Holtz on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SlideyMenuGuy.h"

@interface SlideyMenuGuy()

@property (nonatomic, strong) UIView *holder;

@property (nonatomic, strong) UIButton *rootMenu;
@property (nonatomic, strong) UIButton *clearLayer;
@property (nonatomic, strong) NSArray *subMenus;

@end

@implementation SlideyMenuGuy

@synthesize holder = _holder;

@synthesize rootMenu = _rootMenu;
@synthesize clearLayer = _clearLayer;
@synthesize subMenus = _subMenus;

- (id)init:(UIView*)holder withButtons:(NSArray*)subMenu {
    self = [super init];
    if (self) {
        _holder = holder;
        _subMenus = subMenu;
        
        if ([_subMenus count] > 0) {
            float y = _holder.frame.size.height - 50;
            float subMenuWidth = _holder.frame.size.width / [_subMenus count];
            
            for (int i = 0; i < [_subMenus count]; i++) {
                UIButton *button = [_subMenus objectAtIndex:i];
                button.frame = CGRectMake(-subMenuWidth, y, subMenuWidth, 50);
            }
        }
    }
    return self;
}

- (void) displayMenu {
    
    float x = 0;
    float y = _holder.frame.size.height - 50;
    
    _rootMenu = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 60, 50)];
    [_rootMenu setBackgroundColor:[UIColor blackColor]];
    
    [_rootMenu addTarget:self action:@selector(expandMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [_holder addSubview:_rootMenu];
    
}

- (void) expandMenu:(id)sender {
    NSLog(@"In expandMenu");
    
    [_rootMenu removeTarget:self action:@selector(expandMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    _clearLayer = [[UIButton alloc] initWithFrame:_holder.frame];
    [_clearLayer setBackgroundColor:[UIColor clearColor]];
    [_clearLayer addTarget:self action:@selector(colapseMenu:) forControlEvents:UIControlEventTouchUpInside];
    [_holder addSubview:_clearLayer];
    
    float x = -60;
    float y = _holder.frame.size.height - 50;
    
    [UIView animateWithDuration:0.25 
                     animations:^{
                         _rootMenu.frame = CGRectMake(x, y, 60, 50);
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Completed");
                         
                         if ([_subMenus count] > 0) {
                             float subMenuWidth = _holder.frame.size.width / [_subMenus count];
                             
                             for (int i = 0; i < [_subMenus count]; i++) {
                                 UIButton *button = [_subMenus objectAtIndex:i];
                                 [_holder addSubview:button];

                                 [UIView animateWithDuration:0.25 
                                                  animations:^{
                                                      NSLog(@"Are we in here??");
                                                      
                                                      NSLog(@"Color - %@", button.backgroundColor);
                                                      button.frame = CGRectMake((i * subMenuWidth), y, subMenuWidth, 50);
                                                  }];
                                 
                             }
                         }
                     }
     ];
    
}

- (void) colapseMenu:(id)sender {
    NSLog(@"In expandMenu");
    
    [_rootMenu addTarget:self action:@selector(expandMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [_clearLayer removeFromSuperview];
    
    float x = 0;
    float y = _holder.frame.size.height - 50;
    
    for (int i = 0; i < [_subMenus count]; i++) {
        [UIView animateWithDuration:0.25
                         animations:^{
                             UIButton *button = [_subMenus objectAtIndex:i];
                             button.frame = CGRectMake(-60, y, 60, 50);
                         }];
    }
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         _rootMenu.frame = CGRectMake(x, y, 60, 50);
                     }];
}

@end
