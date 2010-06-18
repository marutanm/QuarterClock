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

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
    NSLog(@"Start: %s", __func__);
}

- (void)dealloc {
    [super dealloc];
}


@end
