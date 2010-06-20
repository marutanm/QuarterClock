//
//  ClockViewController.m
//  QuarterClock
//
//  Created by marutanm on 6/14/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import "ClockViewController.h"

@implementation ClockViewController

@synthesize currentTimeArray;

int digits = 4;

- (void)loadView {
    NSLog(@"%s", __func__);
    [self loadCurrentTime];
    [super loadView];
    scrollView = [[PageScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [scrollView setPages:currentTimeArray];
    [self.view addSubview:scrollView];

    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock) userInfo:nil repeats:YES];
    
}

- (void)loadCurrentTime {
    NSLog(@"Start: %s", __func__);

    if (!currentTimeArray) {
        // currentTimeArray = [NSMutableArray array];
        currentTimeArray = [[NSMutableArray alloc] init];
    }
    [currentTimeArray removeAllObjects];

    NSString *date = [NSString stringWithString:[[NSDate date] description]];
    NSString *time = [NSString stringWithString:[[date componentsSeparatedByString:@" "] objectAtIndex:1]];
    NSLog(@"%@", time);

    for (int i = 0; i < digits + 1; i++) {
        if (i != 2) {
            [currentTimeArray addObject:[time substringWithRange:NSMakeRange(i, 1)]];
        }
    }

    NSLog(@"End: %s", __func__);
}

- (void)updateClock{
    NSLog(@"Start: %s", __func__);
    [self loadCurrentTime];
    [scrollView updateClock:currentTimeArray];
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
