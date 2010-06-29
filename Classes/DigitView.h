//
//  DigitView.h
//  QuarterClock
//
//  Created by marutanm on 6/19/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    animating,
    waiting
} viewStatement;

@interface DigitView : UIView {

viewStatement state;

}

@end
