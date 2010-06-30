#import "PageScrollView.h"
#import "DigitView.h"

#define TAG_OFFSET 100
#define PAGE_NUM 4

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
    pageControl.alpha = 0;
    pageControl.numberOfPages = [currentTimeArray count];
    pageControl.numberOfPages = PAGE_NUM;
    pageControl.currentPage = 0;

    [self updateClock];

    [self addSubview:scrollView];
    [self addSubview:pageControl];

    NSLog(@"End: %s", __func__);
}

- (void)reloadDigitView {
    NSLog(@"Start: %s", __func__);

    for (int i = 0; i < PAGE_NUM; i++) {
        if (![scrollView viewWithTag:TAG_OFFSET + i]) {
            DigitView *digitView = [[DigitView alloc] initWithFrame:_pageRegion];
            digitView.frame = CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height);
            digitView.tag = TAG_OFFSET + i;
            [scrollView addSubview:digitView];
            [digitView release];
        }
        [[scrollView viewWithTag:TAG_OFFSET + i] text:[currentTimeArray objectAtIndex:i]];
    }

    NSLog(@"%d", sec);
    if (sec > 50) {
        [[scrollView viewWithTag:TAG_OFFSET + 3] slideUpDigit:10.0];
        if ([[currentTimeArray objectAtIndex:3] isEqualToString:@"9"]) {
                   [[scrollView viewWithTag:TAG_OFFSET + 2] slideUpDigit:10.0];
        }
    }

    NSLog(@"End: %s", __func__);
}

- (void)updateClock {
    NSLog(@"Start: %s", __func__);

    [self loadCurrentTime];
    [self reloadDigitView];

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
    // NSLog(@"%@", [time characterAtIndex:0]);
    sec = [[[time componentsSeparatedByString:@":"] objectAtIndex:2] integerValue];
    // NSLog(@"%@", sec);

    // for (int i = 0; i < [time length]; i++) {
    for (int i = 0; i < PAGE_NUM + 1; i++) {
        if (![[time substringWithRange:NSMakeRange(i, 1)] isEqualToString:@":"]) {
           [currentTimeArray addObject:[time substringWithRange:NSMakeRange(i, 1)]];
        }
    }

    NSLog(@"End: %s", __func__);
}

-(void)switchStateHidden {
    // NSLog(@"%s", __func__);

    [UIView animateWithDuration:0.5 animations:^{ pageControl.alpha = 0.0; }];
    
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
    pageControl.alpha = 1.0;

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
