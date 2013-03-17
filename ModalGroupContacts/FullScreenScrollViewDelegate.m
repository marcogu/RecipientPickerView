//
//  FullScreenScrollViewDelegate.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-12.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "FullScreenScrollViewDelegate.h"
#import "UIView+YIFullScreenScroll.h"

#define IS_PORTRAIT         UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)
#define STATUS_BAR_HEIGHT   (IS_PORTRAIT ? [UIApplication sharedApplication].statusBarFrame.size.height : [UIApplication sharedApplication].statusBarFrame.size.width)

#define MIN_SCROLL_DISTANCE_FOR_FULLSCREEN  44

@implementation FullScreenScrollViewDelegate

-(id)initWithAboveViewOnTable:(UIView*)headView belowViewOnTable:(UIView*)footView{
    self = [super init];
    if (self) {
        self.floatHeaderView = headView;
        self.floatFooterView = footView;
    }
    return self;
}

- (void)layoutWithScrollView:(UIScrollView*)scrollView deltaY:(CGFloat)deltaY{
    BOOL topViewExisting = _floatHeaderView && _floatHeaderView.superview && !_floatHeaderView.hidden;
    if (topViewExisting) {
        // my logic
        _floatHeaderView.top = MIN(MAX(_floatHeaderView.top-deltaY, 45-_floatHeaderView.height), 45);
//        CGPoint point = scrollView.contentOffset;
//        point.y = _floatHeaderView.top;
//        scrollView.contentOffset = CGPointMake(0, _floatHeaderView.top);
        
        NSLog(@"top = %f,offset=%f", _floatFooterView.frame.origin.y, scrollView.contentOffset.y);
        
        // TEST CODE
//        NSLog(@"%f", deltaY);
//        _floatHeaderView.top = -deltaY;
        // SAMPLE CODE.
//        _floatHeaderView.top = MIN(MAX(_floatHeaderView.top-deltaY, STATUS_BAR_HEIGHT-_floatHeaderView.height), STATUS_BAR_HEIGHT);
//        UIEdgeInsets insets = scrollView.scrollIndicatorInsets;
//        insets.top = _floatHeaderView.bottom-STATUS_BAR_HEIGHT;
//        scrollView.scrollIndicatorInsets = insets;
    }
}

#pragma mark - delgate method

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _prevContentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.dragging || _isScrollingTop) {
        CGFloat deltaY = scrollView.contentOffset.y-_prevContentOffsetY;
        _prevContentOffsetY = MAX(scrollView.contentOffset.y, -scrollView.contentInset.top);
        if (deltaY < 0 && scrollView.contentOffset.y > 0 && !_isScrollingTop)
            deltaY = abs(deltaY);
        [self layoutWithScrollView:scrollView deltaY:deltaY];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(-200, 0, 0, 0)];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    _isScrollingTop = YES;
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    _isScrollingTop = NO;
}

@end
