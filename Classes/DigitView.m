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

       // UILabel *nextLabel = [self label:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height)];
       // nextLabel.tag = NEXT;
       // [self addSubview:nextLabel];
       // [nextLabel release];
    }
    state = waiting;
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
    if (state != animating) {
        [[self viewWithTag:CURRENT] setText:text];
    } 
    // [[self viewWithTag:NEXT] setText:@"X"];

    // for (UILabel *label in self.subviews) {
    // label.text = text;
    // }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
       NSLog(@"Start: %s", __func__);

       [self slideUpDigit:10.0];

}

- (void)slideUpDigit:(double)sec {
       NSLog(@"Start: %s", __func__);

       if (![self viewWithTag:NEXT]) {
            CGRect frame = [[self viewWithTag:CURRENT] frame];
            UILabel *nextLabel = [self label:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height)];
            nextLabel.tag = NEXT;
            [self addSubview:nextLabel];
            [nextLabel release];
       }
       // NSLog(@"%d", [[[self viewWithTag:CURRENT] text] integerValue] + 1);

       void (^slideUp)(void) = ^{
           CGPoint currenCenter = self.center;
           int nextVal = [[[self viewWithTag:CURRENT] text] integerValue] + 1;
           if (nextVal == 10) {
               nextVal =  0;
           }
           [[self viewWithTag:NEXT] setText:[NSString stringWithFormat:@"%d", nextVal]];
           self.center = CGPointMake(currenCenter.x, currenCenter.y - 480);
       };

       if (state != animating) {
           NSLog(@"ANIMATING");
           CGPoint currenCenter = self.center;
           state = animating;
           [UIView animateWithDuration:sec
                                 delay:0
                               options:UIViewAnimationOptionAllowUserInteraction
                            animations:slideUp
                            completion:^(BOOL finished){
                                [[self viewWithTag:CURRENT] setText:[[self viewWithTag:NEXT] text]];
                                self.center = currenCenter;
                                state = waiting;
                            }
           ];
       }

}

- (void)dealloc {
    [super dealloc];
}


@end
