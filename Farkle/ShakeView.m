//
//  ShakeView.m
//  Farkle
//
//  Created by Jen Kelley on 3/22/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "ShakeView.h"

@implementation ShakeView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake ) {
    }
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] ) {
        [super motionEnded:motion withEvent:event];
    }
}

//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}

@end
