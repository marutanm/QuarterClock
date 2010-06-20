//
//  DigitView.m
//  QuarterClock
//
//  Created by marutanm on 6/19/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

// compose each label

#import "DigitView.h"


@implementation DigitView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [self label:frame];
        [self addSubview:label];
        [label release];
    }
    return self;
}

- (UILabel *)label:(CGRect)frame {
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:500];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = UITextAlignmentCenter;

    return label;
}

- (void)text:(NSString *)text {
    for (UILabel *label in self.subviews) {
        label.text = text;
    }
}

- (void)dealloc {
    [super dealloc];
}


@end
