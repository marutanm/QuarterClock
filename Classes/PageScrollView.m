#import "PageScrollView.h"
#import "DigitView.h"

@implementation PageScrollView

@synthesize updateTimer, delegate;

- (id)initWithFrame:(CGRect)frame {
      NSLog(@"Start: %s", __func__);
      self = [super initWithFrame:frame];
      if (self != nil) {
          _pageRegion = CGRectMake(0, 0, frame.size.width, frame.size.height);
          _controlRegion = CGRectMake(0, frame.size.height - 60.0, frame.size.width, 60.0);
          self.delegate = nil;

          [self setPages];
          [self addSubview:scrollView];
          [self addSubview:pageControl];
      }
      return self;
      NSLog(@"End: %s", __func__);
}

- (void)setPages {
    NSLog(@"Start: %s", __func__);
    [self loadCurrentTime];

    scrollView = [[UIScrollView alloc] initWithFrame:_pageRegion];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentOffset = CGPointMake(0.0, 0.0);
    scrollView.contentSize = CGSizeMake(_pageRegion.size.width * [currentTimeArray count], _pageRegion.size.height);

    pageControl = [[UIPageControl alloc] initWithFrame:_controlRegion];
    pageControl.userInteractionEnabled = NO;
    pageControl.hidden = YES;
    pageControl.numberOfPages = [currentTimeArray count];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;

    NSLog(@"End: %s", __func__);
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

    // for (int i = 0; i < digits + 1; i++) {
    for (int i = 0; i < 5; i++) {
        if (i != 2) {
            [currentTimeArray addObject:[time substringWithRange:NSMakeRange(i, 1)]];
        }
    }

    NSLog(@"End: %s", __func__);
}

- (void)updateClock {
    NSLog(@"Start: %s", __func__);
    [self loadCurrentTime];
    for (UIView *view in self.subviews) {
        view = nil;
    }
    for (int i = 0; i < [currentTimeArray count]; i++) {
        DigitView *digitView = [[DigitView alloc] initWithFrame:_pageRegion];
        digitView.frame = CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height);
        [digitView text:[currentTimeArray objectAtIndex:i]];
        [scrollView addSubview:digitView];
        [digitView release];
    }
    NSLog(@"End: %s", __func__);
}

-(void)switchStateHidden {
    NSLog(@"%s", __func__);

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];

    pageControl.hidden = YES;

    [UIView commitAnimations];	
}

- (void)setCurrentPage:(int)page {
    [scrollView setContentOffset:CGPointMake(_pageRegion.size.width * page, scrollView.contentOffset.y) animated:YES];
    pageControl.currentPage = page;
}

- (int)getCurrentPage {
    return (int) (scrollView.contentOffset.x / _pageRegion.size.width);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // NSLog(@"%s", __func__);
    pageControl.hidden = NO;

    if ([updateTimer isValid]) {
        [updateTimer invalidate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // NSLog(@"%s", __func__);
    pageControl.currentPage = self.currentPage;

    // hide pageControl 1 sec later by timer
    if (!updateTimer) {
        updateTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1.0] interval:0 target:self selector:@selector(switchStateHidden) userInfo:nil repeats:NO];
    } else if (![updateTimer isValid]) {
        [updateTimer release];
        updateTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1.0] interval:0 target:self selector:@selector(switchStateHidden) userInfo:nil repeats:NO];
    }
    [[NSRunLoop mainRunLoop] addTimer:updateTimer forMode:NSRunLoopCommonModes];

}

@end
