#import "PageScrollView.h"
#import "DigitsScrollView.h"
#import "DigitView.h"

@implementation PageScrollView

- (id)initWithFrame:(CGRect)frame {
      NSLog(@"Start: %s", __func__);
      self = [super initWithFrame:frame];
      if (self != nil) {
          NSLog([NSString stringWithFormat:@"%f, %f, %f, %f", frame.origin.x, frame.origin.y, frame.size.height - 60.0, frame.size.width]);
          _pageRegion = CGRectMake(0, 0, frame.size.width, frame.size.height);
          _controlRegion = CGRectMake(0, frame.size.height - 60.0, frame.size.width, 60.0);
          self.delegate = nil;

          scrollView = [[DigitsScrollView alloc] initWithFrame:_pageRegion];
          scrollView.backgroundColor = [UIColor blackColor];
          scrollView.pagingEnabled = YES;
          scrollView.delegate = self;
          [self addSubview:scrollView];

          pageControl = [[UIPageControl alloc] initWithFrame:_controlRegion];
          [pageControl addTarget:self action:@selector(pageControlDidChange:) forControlEvents:UIControlEventValueChanged];
          // pageControl.backgroundColor = [UIColor orangeColor];
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
        // [view removeFromSuperview];
        view = nil;
    }
    for (int i = 0; i < [pages count]; i++) {
        // NSLog(@"%@", [[pages objectAtIndex:i] class]);
        DigitView *digitView = [[DigitView alloc] initWithFrame:_pageRegion];
        digitView.frame = CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height);
        [digitView text:[pages objectAtIndex:i]];
        [scrollView addSubview:digitView];
        [digitView release];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [self switchStateHidden:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [self switchStateHidden:self];
}

-(void)switchStateHidden:(id)sender{

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];

    if (pageControl.hidden == YES) {
        pageControl.hidden = NO;
    } else {
        pageControl.hidden = YES;
    }

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
    pageControl.hidden = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControl.currentPage = self.currentPage;
    [self notifyPageChange];
    pageControl.hidden = YES;
}

- (void) pageControlDidChange:(id)sender {
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
