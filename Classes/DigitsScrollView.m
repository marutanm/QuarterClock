//
//  DigitsScrollView.m
//  QuarterClock
//
//  Created by marutanm on 6/18/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import "DigitsScrollView.h"


@implementation DigitsScrollView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    if (self.superview != nil) {
        [self.superview touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    if (self.superview != nil) {
        [self.superview touchesEnded:touches withEvent:event];
    }
}

- (void)dealloc {
    [super dealloc];
}


@end
