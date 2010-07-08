#import <UIKit/UIKit.h>

@interface PageScrollView : UIView <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    NSInteger hour, min, sec;
    
    CGRect _pageRegion, _controlRegion;
}

- (void)layoutViews;
- (void)notifyPageChange;

@end
