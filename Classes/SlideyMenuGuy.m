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
@property (nonatomic, strong) UIView *wholeMenuView;

@property (nonatomic, strong) UIButton *mainMenu;
@property (nonatomic, strong) UIButton *clearLayer;
@property (nonatomic, strong) NSArray *subMenus;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRight;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation SlideyMenuGuy

@synthesize holder = _holder;
@synthesize wholeMenuView = _wholeMenuView;

@synthesize mainMenu = _mainMenu;
@synthesize clearLayer = _clearLayer;
@synthesize subMenus = _subMenus;

@synthesize swipeLeft = _swipeLeft;
@synthesize swipeRight = _swipeRight;
@synthesize tap = _tap;

- (id)init:(UIView*)holder withMain:(UIButton*)mainMenu withSubMenus:(NSArray*)subMenus {
    self = [super init];
    if (self) {
        _holder = holder;
        _mainMenu = mainMenu;
        _subMenus = subMenus;
        
        float y = _holder.frame.size.height - 50;
        _mainMenu.frame = CGRectMake(0, 0, 60, 50);
        
        if ([_subMenus count] > 0) {
            float subMenuWidth = _holder.frame.size.width / [_subMenus count];
            
            for (int i = 0; i < [_subMenus count]; i++) {
                UIButton *button = [_subMenus objectAtIndex:i];
                button.frame = CGRectMake(-subMenuWidth, 0, subMenuWidth, 50);
            }
        }
        
        _wholeMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, y, holder.frame.size.width, 50)];
        [_wholeMenuView setBackgroundColor:[UIColor purpleColor]];
        [_holder addSubview:_wholeMenuView];
        
        
        /*
         * Enables swipe left to collapse.
         */
        _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognitionSwipeLeft:)];
        [_swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//        [_swipeLeft setDelegate:self];
        [_wholeMenuView addGestureRecognizer:_swipeLeft];
        
        /*
         * Enables swipe right to collapse.
         */
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognitionSwipeRight:)];
        [_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        //        [_swipeLeft setDelegate:self];
        [_wholeMenuView addGestureRecognizer:_swipeRight];
        
        /*
         * Enables tapd.
         */
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognitionTap:)];
//        [_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [_tap setDelegate:self];
        [_wholeMenuView addGestureRecognizer:_tap];
        
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    NSLog(@"gesture type - %@", [[gestureRecognizer class] description]);
//    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
//        NSLog(@"We got tapped");
//    } else if ([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
//        NSLog(@"We got swyped");
//    }
//    
//    
//    NSLog(@"Touch - %@", [[touch.view class] description]);
//    if ([touch.view isKindOfClass:[UIButton class]]) {
//        return NO;
//    } else {
//        if (gestureRecognizer == _swipeLeft) {
//            NSLog(@"Swipe left");
//            [self colapseMenu:gestureRecognizer];
//        } else if (gestureRecognizer == _swipeRight) {
//            NSLog(@"Swipe right");
//            [self expandMenu:gestureRecognizer];
//        }
//    }
    
    return NO;
}

- (void)swipeRecognitionSwipeLeft:(UISwipeGestureRecognizer*)sender {
    NSLog(@"Swipe left");
    [self colapseMenu:sender];
}

- (void)swipeRecognitionSwipeRight:(UISwipeGestureRecognizer*)sender {
    NSLog(@"Swipe right");
    [self expandMenu:sender];
}

- (void)swipeRecognitionTap:(UITapGestureRecognizer*)sender {
    NSLog(@"Tap - %@", [[sender.view class] description]);
}

- (void) displayMenu {
    [_mainMenu addTarget:self action:@selector(expandMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [_wholeMenuView addSubview:_mainMenu];
    
}

- (void) expandMenu:(id)sender {
    NSLog(@"In expandMenu");
    
    [_mainMenu removeTarget:self action:@selector(expandMenu:) forControlEvents:UIControlEventTouchUpInside];
    
//    _clearLayer = [[UIButton alloc] initWithFrame:_holder.frame];
//    [_clearLayer setBackgroundColor:[UIColor clearColor]];
//    [_clearLayer addTarget:self action:@selector(colapseMenu:) forControlEvents:UIControlEventTouchUpInside];
//    [_holder addSubview:_clearLayer];
    
    float x = -60;
    float y = 0;
    
    [UIView animateWithDuration:0.2 
                     animations:^{
                         _mainMenu.frame = CGRectMake(x, y, 60, 50);
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Completed");
                         
                         if ([_subMenus count] > 0) {
                             float subMenuWidth = _wholeMenuView.frame.size.width / [_subMenus count];
                             
                             for (int i = 0; i < [_subMenus count]; i++) {
                                 UIButton *button = [_subMenus objectAtIndex:i];
                                 [_wholeMenuView addSubview:button];

                                 [UIView animateWithDuration:0.25 
                                                  animations:^{
                                                      button.frame = CGRectMake((i * subMenuWidth), y, subMenuWidth, 50);
                                                  }];
                                 
                             }
                         }
                     }
     ];
    
}

- (void) colapseMenu:(id)sender {
    NSLog(@"In cloapse");
    
    [_mainMenu addTarget:self action:@selector(expandMenu:) forControlEvents:UIControlEventTouchUpInside];
    
//    [_clearLayer removeFromSuperview];
    
    float x = 0;
    float y = 0;
    
    for (int i = 0; i < [_subMenus count]; i++) {
        [UIView animateWithDuration:0.25
                         animations:^{
                             UIButton *button = [_subMenus objectAtIndex:i];
                             button.frame = CGRectMake(-60, y, 60, 50);
                         }];
    }
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         _mainMenu.frame = CGRectMake(x, y, 60, 50);
                     }];
}

@end
