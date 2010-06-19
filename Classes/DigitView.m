//
//  DigitView.m
//  QuarterClock
//
//  Created by marutanm on 6/19/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import "DigitView.h"


@implementation DigitView


- (id)initWithFrame:(CGRect)frame {
   NSLog(@"Start: %s", __func__);
    if ((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y,
                                        frame.size.width, frame.size.height * 2)])) {
       // UILabel *label = [[UILabel alloc] initWithFrame:_pageRegion];
       // label.backgroundColor = [UIColor blackColor];
       // label.textColor = [UIColor whiteColor];
       // label.font = [UIFont systemFontOfSize:500];
       // label.adjustsFontSizeToFitWidth = YES;
       // label.textAlignment = UITextAlignmentCenter;

       // NSLog(@"%@", [pages objectAtIndex:i]);
       // label.frame = CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height);
       // label.text = [pages objectAtIndex:i];

       // [scrollView addSubview:label];
       // [label release];
    }
    self.backgroundColor = [UIColor orangeColor];
    return self;
    NSLog(@"End: %s", __func__);
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
