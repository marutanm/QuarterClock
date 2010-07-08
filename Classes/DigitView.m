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

int (^nextVal)(int, int) = ^(int current, int max) {
    current++;
    if (current > max) {
        return 0;
    } else {
        return current;
    }
};

@implementation DigitView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       UILabel *label = [self label:frame];
       label.tag = CURRENT;
       [self addSubview:label];
       [label release];
    }
    state = waiting;
    return self;
}

- (UILabel *)label:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:500];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = UITextAlignmentCenter;

    return label;
}

- (void)setCurrentTime:(NSString *)text {
    if (state != animating) {
        [[self viewWithTag:CURRENT] setText:text];
    } 
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
       NSLog(@"Start: %s", __func__);

       // [self slideUpDigit:10.0];

}

- (void)slideUpDigit:(double)sec value:(NSString *)value{
       NSLog(@"Start: %s", __func__);

       if (![self viewWithTag:NEXT]) {
            CGRect frame = [[self viewWithTag:CURRENT] frame];
            UILabel *nextLabel = [self label:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height)];
            nextLabel.tag = NEXT;
            [self addSubview:nextLabel];
            [nextLabel release];
       }

       void (^slideUp)(void) = ^{
           CGPoint currenCenter = self.center;
           [[self viewWithTag:NEXT] setText:value];
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
