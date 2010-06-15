//
//  ClockViewController.h
//  QuarterClock
//
//  Created by marutanm on 6/14/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ClockViewController : UIViewController {
        
    NSMutableArray *currentTimeArray;
    NSInteger labelTag;
    NSInteger place;
}

@property (nonatomic, retain) NSMutableArray *currentTimeArray;

- (UILabel *)loadLabel; 
- (void)loadCurrentTime;
- (void)updateClock;

@end
