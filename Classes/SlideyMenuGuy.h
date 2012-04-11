//
//  SlideyMenuGuy.h
//  SlideyMenuGuy
//
//  Created by Josh Holtz on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SlideyMenuGuy : NSObject

- (id)init:(UIView*)holder withButtons:(NSArray*)subMenu;
- (void) displayMenu;

@end
