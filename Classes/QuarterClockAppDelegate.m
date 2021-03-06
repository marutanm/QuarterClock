//
//  QuarterClockAppDelegate.m
//  QuarterClock
//
//  Created by marutanm on 6/14/10.
//  Copyright shisobu.in 2010. All rights reserved.
//

#import "QuarterClockAppDelegate.h"
#import "ClockViewController.h"

@implementation QuarterClockAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    NSLog(@"%s", __func__);
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ClockViewController *viewController = [[ClockViewController alloc] init];
    [window addSubview:viewController.view];
	
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
