#import "PageScrollView.h"
#import "DigitView.h"

@implementation PageScrollView

@synthesize updateTimer;
- (id)initWithFrame:(CGRect)frame {
      NSLog(@"Start: %s", __func__);
      self = [super initWithFrame:frame];
      if (self != nil) {
          NSLog([NSString stringWithFormat:@"%f, %f, %f, %f", frame.origin.x, frame.origin.y, frame.size.height - 60.0, frame.size.width]);
          _pageRegion = CGRectMake(0, 0, frame.size.width, frame.size.height);
          _controlRegion = CGRectMake(0, frame.size.height - 60.0, frame.size.width, 60.0);
          self.delegate = nil;

          scrollView = [[UIScrollView alloc] initWithFrame:_pageRegion];
          scrollView.backgroundColor = [UIColor blackColor];
          scrollView.pagingEnabled = YES;
          scrollView.delegate = self;
          [self addSubview:scrollView];

          pageControl = [[UIPageControl alloc] initWithFrame:_controlRegion];
          [pageControl addTarget:self action:@selector(pageControlDidChange:) forControlEvents:UIControlEventValueChanged];
          [self addSubview:pageControl];
          pageControl.hidden = YES;
      }
      return self;
      NSLog(@"End: %s", __func__);
}

- (void)setPages:(NSMutableArray *)pages {
   NSLog(@"Start: %s", __func__);
   scrollView.contentOffset = CGPointMake(0.0, 0.0);
   scrollView.contentSize = CGSizeMake(_pageRegion.size.width * [pages count], _pageRegion.size.height);
   pageControl.numberOfPages = [pages count];
   pageControl.currentPage = 0;

   [self updateClock:pages];
   NSLog(@"End: %s", __func__);
}

- (void)updateClock:(NSMutableArray *)pages {
    NSLog(@"%s", __func__);
    for (UIView *view in scrollView.subviews) {
        view = nil;
    }
    for (int i = 0; i < [pages count]; i++) {
        DigitView *digitView = [[DigitView alloc] initWithFrame:_pageRegion];
        digitView.frame = CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height);
        [digitView text:[pages objectAtIndex:i]];
        [scrollView addSubview:digitView];
        [digitView release];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    // [self switchStateHidden:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    // [self switchStateHidden:self];
}

-(void)switchStateHidden {
// -(void)switchStateHidden:(NSTimer *)aTimer {
    NSLog(@"%s", __func__);

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];

    pageControl.hidden = YES;

    [UIView commitAnimations];	
}

- (id)getDelegate {
    return _delegate;
}

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
}

- (NSMutableArray *)getPages {
    return _pages;
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

    // NSLog(@"updateTimer: %@", updateTimer);
    // if (updateTimer) {
    if ([updateTimer isValid]) {
        // NSLog(@"invalidate: %@", updateTimer);
            [updateTimer invalidate];
            // updateTimer = nil;
        // }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    // NSLog(@"%s", __func__);
    // pageControl.currentPage = self.currentPage;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // NSLog(@"%s", __func__);
    pageControl.currentPage = self.currentPage;
    [self notifyPageChange];

    // hide pageControl 1 sec later by timer
    if (!updateTimer) {
        // NSLog(@"%@", updateTimer);
        updateTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1.0] interval:0 target:self selector:@selector(switchStateHidden) userInfo:nil repeats:NO];
        // NSLog(@"updateTimer: %@", updateTimer);
    } else if (![updateTimer isValid]) {
        [updateTimer release];
        updateTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1.0] interval:0 target:self selector:@selector(switchStateHidden) userInfo:nil repeats:NO];
    }
    [[NSRunLoop mainRunLoop] addTimer:updateTimer forMode:NSRunLoopCommonModes];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // NSLog(@"%s", __func__);
    // pageControl.hidden = NO;
}

- (void) pageControlDidChange:(id)sender {
    // NSLog(@"%s", __func__);
    UIPageControl *control = (UIPageControl *) sender;
    if (control == pageControl) {
        self.currentPage = control.currentPage;
    }
    [self notifyPageChange];
}

- (void) notifyPageChange {
    if (self.delegate != nil) {
        if ([_delegate conformsToProtocol:@protocol(PageScrollViewDelegate)]) {
        if ([_delegate respondsToSelector:@selector(pageScrollViewDidChangeCurrentPage:currentPage:)]) {
                [self.delegate pageScrollViewDidChangeCurrentPage:(PageScrollView *)self currentPage:self.currentPage];
        }
        }
    }
}

@end
