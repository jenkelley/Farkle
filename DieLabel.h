//
//  DieLabel.h
//  Farkle
//
//  Created by Ben Whitley on 3/19/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DieLabelDelegate <NSObject>

@optional

-(void)labelTapped:(UIGestureRecognizer *)tap;

@end

@interface DieLabel : UILabel

@property (nonatomic, assign) id <DieLabelDelegate> delegate;

-(void)rollDice;

@end
