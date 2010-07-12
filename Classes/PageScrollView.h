#import <UIKit/UIKit.h>

@interface PageScrollView : UIView <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    NSInteger hour, min, sec;
    
    CGRect _pageRegion;
}

- (id)initWithFrame:(CGRect)frame;
- (void)setPages;
- (void)updateClock;
- (void)loadCurrentTime;
- (void)reloadDigitView;

@end
