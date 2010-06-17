//
//  ClockViewController.m
//  QuarterClock
//
//  Created by marutanm on 6/14/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import "ClockViewController.h"
#import "PageScrollView.h"

@implementation ClockViewController

@synthesize currentTimeArray;

int digits = 4;

- (void)loadView {
    NSLog(@"%s", __func__);
    [self loadCurrentTime];
    [super loadView];
    // self.view.userInteractionEnabled = YES;
    PageScrollView *scrollView = [[PageScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [scrollView setPages:currentTimeArray];
    [self.view addSubview:scrollView];

    currentDigits = 0;
    labelTag = 100;
	// [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock) userInfo:nil repeats:YES];
}

/*
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Start: %s", __func__);
    currentDigits++;
    if (currentDigits == digits) {
        currentDigits = 0;
    }
    NSLog(@"%d", currentDigits);
    [[self.view viewWithTag:labelTag] setText:[currentTimeArray objectAtIndex:currentDigits]];
    NSLog(@"End: %s", __func__);
}
*/

- (UILabel *)loadLabel {
    NSLog(@"Start: %s", __func__);
    UILabel *label = [[UILabel alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    label.backgroundColor = [UIColor blackColor];
    label.text = [currentTimeArray objectAtIndex:currentDigits];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:500];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = UITextAlignmentCenter;
    label.tag = labelTag;
    NSLog(@"End: %s", __func__);
    return label;
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

    int i;
    for (i = 0; i < digits + 1; i++) {
        if (i != 2) {
            [currentTimeArray addObject:[time substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    // NSLog(@"%@", currentTimeArray);

    NSLog(@"End: %s", __func__);
}

- (void)updateClock{
    NSLog(@"Start: %s", __func__);
    [self loadCurrentTime];
    int i;
    for (i = 0; i < digits; i++) {
        [[self.view viewWithTag:labelTag] setText:[currentTimeArray objectAtIndex:currentDigits]];
    }
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
