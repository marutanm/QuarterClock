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
   // NSLog(@"Start: %s", __func__);
   // NSLog(@"rect: %@", NSStringFromCGRect(frame));
   
    // if ((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y,
                                        // frame.size.width, frame.size.height * 2)])) {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [self label:frame];
        [self addSubview:label];
        [label release];
    }
    // NSLog(@"End: %s", __func__);
    return self;
}

- (UILabel *)label:(CGRect)frame {
    // NSLog(@"%s", __func__);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:500];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = UITextAlignmentCenter;

    // NSLog(@"%@", [pages objectAtIndex:i]);
    // label.text = [pages objectAtIndex:i];
    return label;
}

- (void)text:(NSString *)text {
    for (UILabel *label in self.subviews) {
        label.text = text;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
// Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
