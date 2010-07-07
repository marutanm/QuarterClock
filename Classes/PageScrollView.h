#import <UIKit/UIKit.h>

@interface PageScrollView : UIView <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    NSMutableString *currentTime;
    NSInteger *sec;
    
    CGRect _pageRegion, _controlRegion;
}

- (void)layoutViews;
- (void)notifyPageChange;

@end
