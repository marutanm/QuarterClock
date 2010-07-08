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

    id (^strTime)(int) = ^(int current){
        if (current < 10) {
            return [NSString stringWithFormat:@"0%d", current];
        } else {
            return [NSString stringWithFormat:@"%d", current];
        }
    };

    NSMutableString *currentTime = [NSMutableString stringWithCapacity:PAGE_NUM];
    [currentTime appendString:strTime(hour)];
    [currentTime appendString:strTime(min)];

    for (int i = 0; i < PAGE_NUM; i++) {
        if (![scrollView viewWithTag:TAG_OFFSET + i]) {
            DigitView *digitView = [[DigitView alloc] initWithFrame:_pageRegion];
            digitView.frame = CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height);
            digitView.tag = TAG_OFFSET + i;

            [scrollView addSubview:digitView];
            [digitView release];
        }
        [[scrollView viewWithTag:TAG_OFFSET + i] setCurrentTime:[currentTime substringWithRange:NSMakeRange(i, 1)]];
    }

    int (^incrementedTime)(int, int) = ^(int current, int max){ current++; if (current == max) return 0; return current; };

    if (sec >= 50) {
        if (min % 10 == 9) {
            min = incrementedTime(min, 60);
            [[scrollView viewWithTag:TAG_OFFSET + 3] slideUpDigit:10.0 value:[NSString stringWithFormat:@"%d", (min % 10)]];
            [[scrollView viewWithTag:TAG_OFFSET + 2] slideUpDigit:10.0 value:[NSString stringWithFormat:@"%d", (min / 10)]];
        } else {
            min = incrementedTime(min, 60);
            [[scrollView viewWithTag:TAG_OFFSET + 3] slideUpDigit:10.0 value:[NSString stringWithFormat:@"%d", (min % 10)]];
        }
    }
    if (min >= 59) {
        hour = incrementedTime(hour, 24);
        [[scrollView viewWithTag:TAG_OFFSET + 1] slideUpDigit:60.0 value:[NSString stringWithFormat:@"%d", (hour % 10)]];
        [[scrollView viewWithTag:TAG_OFFSET + 0] slideUpDigit:60.0 value:[NSString stringWithFormat:@"%d", (hour / 10)]];
    }
}

@end
