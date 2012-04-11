//
//  ViewController.m
//  SlideyMenuGuy
//
//  Created by Josh Holtz on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import "SlideyMenuGuy.h"

@interface ViewController ()

@property (nonatomic, strong) SlideyMenuGuy *menu;

@end

@implementation ViewController

@synthesize menu = _menu;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *subMenu = [[NSMutableArray alloc] init];
    
	UIButton *button1 = [[UIButton alloc] init];
    [button1 setBackgroundColor:[UIColor redColor]];
    [button1 addTarget:self action:@selector(handleButton1:) forControlEvents:UIControlEventTouchUpInside];
    [subMenu addObject:button1];
    
    UIButton *button2 = [[UIButton alloc] init];
    [button2 setBackgroundColor:[UIColor blueColor]];
    [button2 addTarget:self action:@selector(handleButton2:) forControlEvents:UIControlEventTouchUpInside];
    [subMenu addObject:button2];
    
    UIButton *button3 = [[UIButton alloc] init];
    [button3 setBackgroundColor:[UIColor greenColor]];
    [button3 addTarget:self action:@selector(handleButton3:) forControlEvents:UIControlEventTouchUpInside];
    [subMenu addObject:button3];
    
    UIButton *button4 = [[UIButton alloc] init];
    [button4 setBackgroundColor:[UIColor yellowColor]];
    [button4 addTarget:self action:@selector(handleButton4:) forControlEvents:UIControlEventTouchUpInside];
    [subMenu addObject:button4];
    
    _menu = [[SlideyMenuGuy alloc] init:self.view withButtons:subMenu];
    [_menu displayMenu];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Handle submenu events

- (void)handleButton1:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Button 1" message:@"It was pressed and we should do something" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

- (void)handleButton2:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Button 2" message:@"It was pressed and we should do something" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

- (void)handleButton3:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Button 3" message:@"It was pressed and we should do something" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

- (void)handleButton4:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Button 4" message:@"It was pressed and we should do something" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

@end
