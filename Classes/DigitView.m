//
//  DigitView.m
//  QuarterClock
//
//  Created by marutanm on 6/19/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

// compose each label

#import "DigitView.h"

#define CURRENT 50
#define NEXT 60

@implementation DigitView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [self label:frame];
        label.tag = CURRENT;
        [self addSubview:label];
        [label release];

        UILabel *nextLabel = [self label:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height)];
        nextLabel.tag = NEXT;
        [self addSubview:nextLabel];
        [nextLabel release];
    }
    return self;
}

- (UILabel *)label:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    // UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:500];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = UITextAlignmentCenter;

    return label;
}

- (void)text:(NSString *)text {
    [[self viewWithTag:CURRENT] setText:text];
    [[self viewWithTag:NEXT] setText:@"X"];

    // for (UILabel *label in self.subviews) {
        // label.text = text;
    // }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Start: %s", __func__);
    CGPoint currenCenter = self.center;

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:10.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];

    self.center = CGPointMake(currenCenter.x, currenCenter.y - 480);

    [UIView commitAnimations];	

}

- (void)dealloc {
    [super dealloc];
}


@end
