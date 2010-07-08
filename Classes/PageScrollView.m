#import "PageScrollView.h"
#import "DigitView.h"

#define TAG_OFFSET 100
#define PAGE_NUM 4

@implementation PageScrollView

- (id)initWithFrame:(CGRect)frame {
      NSLog(@"Start: %s", __func__);
      self = [super initWithFrame:frame];
      if (self != nil) {
          _pageRegion = CGRectMake(0, 0, frame.size.width, frame.size.height);
          _controlRegion = CGRectMake(0, frame.size.height - 60.0, frame.size.width, 60.0);
          [self setPages];
      }

      [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock) userInfo:nil repeats:YES];

      return self;
      NSLog(@"End: %s", __func__);
}

- (void)setPages {

    scrollView = [[UIScrollView alloc] initWithFrame:_pageRegion];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentOffset = CGPointMake(0.0, 0.0);
    scrollView.contentSize = CGSizeMake(_pageRegion.size.width * PAGE_NUM, _pageRegion.size.height);

    [self updateClock];
    [self addSubview:scrollView];
}

- (void)updateClock {
    [self loadCurrentTime];
    [self reloadDigitView];
}

- (void)loadCurrentTime {

    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"HH"];
    hour = [[formatter stringFromDate:[NSDate date]] integerValue];
    [formatter setDateFormat:@"mm"];
    min = [[formatter stringFromDate:[NSDate date]] integerValue];
    [formatter setDateFormat:@"ss"];
    sec = [[formatter stringFromDate:[NSDate date]] integerValue];

    NSLog(@"%d %d %d", hour, min, sec);
}

- (void)reloadDigitView {
    NSLog(@"Start: %s", __func__);

    NSMutableString *currentTime = [NSMutableString stringWithCapacity:PAGE_NUM];
    [currentTime appendString:[NSString stringWithFormat:@"%d", hour]];
    [currentTime appendString:[NSString stringWithFormat:@"%d", min]];

    for (int i = 0; i < PAGE_NUM; i++) {
        if (![scrollView viewWithTag:TAG_OFFSET + i]) {
            DigitView *digitView = [[DigitView alloc] initWithFrame:_pageRegion];
            digitView.frame = CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height);
            digitView.tag = TAG_OFFSET + i;
            digitView.maxValue = 9;
            if (i == 0) {
                digitView.maxValue = 2;
            } else if (i == 2){
                digitView.maxValue = 5;
            }
            [scrollView addSubview:digitView];
            [digitView release];
        }
        [[scrollView viewWithTag:TAG_OFFSET + i] setCurrentTime:[currentTime substringWithRange:NSMakeRange(i, 1)]];
    }

    if (sec >= 50) {
        [[scrollView viewWithTag:TAG_OFFSET + 3] slideUpDigit:10.0];
        if ([[currentTime substringWithRange:NSMakeRange(3, 1)] integerValue] == [[scrollView viewWithTag:TAG_OFFSET + 3] maxValue]) {
                    [[scrollView viewWithTag:TAG_OFFSET + 2] slideUpDigit:10.0];
                    if ([[currentTime substringWithRange:NSMakeRange(2, 1)] integerValue] == [[scrollView viewWithTag:TAG_OFFSET + 2] maxValue]) {
                                [[scrollView viewWithTag:TAG_OFFSET + 1] slideUpDigit:10.0];
                                if ([[currentTime substringWithRange:NSMakeRange(1, 1)] integerValue] == [[scrollView viewWithTag:TAG_OFFSET + 1] maxValue]) {
                                            [[scrollView viewWithTag:TAG_OFFSET + 0] slideUpDigit:10.0];
                                } else if (([[scrollView viewWithTag:TAG_OFFSET + 0] integerValue] == 2) && ([[scrollView viewWithTag:TAG_OFFSET +1] integerValue] == 3)) {
                                            [[scrollView viewWithTag:TAG_OFFSET + 0] slideUpDigit:10.0];
                                }
                    }
        }
    }

}

@end
