//
//  ShakeView.h
//  Farkle
//
//  Created by Jen Kelley on 3/22/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakeView : UIView

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
- (BOOL)canBecomeFirstResponder;

@end
