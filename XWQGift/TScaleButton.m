//
//  TScaleButton.m
//  2015-08-04-ScaleButton
//
//  Created by TangJR on 8/4/15.
//  Copyright (c) 2015 tangjr. All rights reserved.
//

#import "TScaleButton.h"

static int hitFlag = 0;

@implementation TScaleButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!CGRectContainsPoint([self bounds], point))
        return nil;
    
    if (hitFlag == 0) {
        
        hitFlag = 1;
        [self scaleAnimation];
    }
    return self;
}

- (void)scaleAnimation {
    
    static const CGFloat scaleMultiple = 1.8;
    
    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.transform = CGAffineTransformMakeScale(scaleMultiple, scaleMultiple);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            hitFlag = 0;
        }];
    }];
}

@end