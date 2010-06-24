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
    [super loadView];
    scrollView = [[PageScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:scrollView];

    [NSTimer scheduledTimerWithTimeInterval:1.0 target:scrollView selector:@selector(updateClock) userInfo:nil repeats:YES];
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
