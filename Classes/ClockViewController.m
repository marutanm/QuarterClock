//
//  ClockViewController.m
//  QuarterClock
//
//  Created by marutanm on 6/14/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import "ClockViewController.h"


@implementation ClockViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    NSLog(@"%s", __func__);
    [super loadView];
    [self.view addSubview:[self loadLabel:@"1"]];
    [self loadCurrentTime];
}

- (UILabel *)loadLabel:(NSString *)text {
    NSLog(@"%s", __func__);
    UILabel *label = [[UILabel alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    label.backgroundColor = [UIColor blackColor];
    // label.text = @"hoge";
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:500];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = UITextAlignmentCenter;

    return label;
}

- (NSArray *)loadCurrentTime {
    NSLog(@"%s", __func__);
    NSString *date= [[NSDate date] description];
    NSString *time = [[date componentsSeparatedByString:@" "] objectAtIndex:1];
    NSLog(@"%@", time);

    NSMutableArray *currenTimeArray = [NSMutableArray array];
    int i;
    for (i = 0; i < 5; i++) {
        // NSLog(@"%d - %@", i, [time substringWithRange:NSMakeRange(i, 1)]);
        if (i != 2) {
            [currenTimeArray addObject:[time substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    
    // NSLog(@"%@",[time substringWithRange:NSMakeRange(0, 1)]);
    NSLog(@"%@",currenTimeArray);

    return currenTimeArray;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
