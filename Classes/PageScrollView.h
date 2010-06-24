#import <UIKit/UIKit.h>

@interface PageScrollView : UIView <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSTimer *updateTimer;
    NSMutableArray *currentTimeArray;
    
    CGRect _pageRegion, _controlRegion;
}

- (void)layoutViews;
- (void)notifyPageChange;

@property(nonatomic,assign,getter=getCurrentPage) int currentPage; 
@property(nonatomic,assign) NSTimer *updateTimer;
@property(nonatomic,assign) id delegate;

@end
