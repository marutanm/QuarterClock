//
//  ClockViewController.m
//  QuarterClock
//
//  Created by marutanm on 6/14/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import "ClockViewController.h"

@implementation ClockViewController

@synthesize currenTimeArray;

- (void)loadView {
    NSLog(@"%s", __func__);
    [super loadView];
    place = 0;
    // [self.view addSubview:[self loadLabel:@"1"]];
    [self.view addSubview:[self loadLabel]];
    // [self loadCurrentTime];
}

// - (UILabel *)loadLabel:(NSString *)text {
- (UILabel *)loadLabel {
    NSLog(@"Start: %s", __func__);
    UILabel *label = [[UILabel alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    label.backgroundColor = [UIColor blackColor];
    // label.text = text;
    [self loadCurrentTime];
    label.text = [currenTimeArray objectAtIndex:place];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:500];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = UITextAlignmentCenter;
    NSLog(@"End: %s", __func__);
    return label;
}

- (void)loadCurrentTime {
    NSLog(@"Start: %s", __func__);

    if (!currenTimeArray) {
        currenTimeArray = [NSMutableArray array];
    }
    [currenTimeArray removeAllObjects];

    NSString *date= [[NSDate date] description];
    NSString *time = [[date componentsSeparatedByString:@" "] objectAtIndex:1];
    NSLog(@"%@", time);

    // NSMutableArray *tempArray = [NSMutableArray array];
    int i;
    for (i = 0; i < 5; i++) {
        if (i != 2) {
            [currenTimeArray addObject:[time substringWithRange:NSMakeRange(i, 1)]];
            // [tempArray addObject:[time substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    
    // [currenTimeArray addObjectsFromArray:tempArray];
    NSLog(@"%@",currenTimeArray);

    // [tempArray release];
    NSLog(@"End: %s", __func__);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
