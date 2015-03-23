//
//  DieLabel.m
//  Farkle
//
//  Created by Ben Whitley on 3/19/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "DieLabel.h"
#import "RootViewController.h"

@implementation DieLabel

-(void)rollDice {
    int randomRoll = arc4random_uniform(6)+1;
    self.text = [NSString stringWithFormat:@"%i", randomRoll];

}

-(IBAction)labelTapped:(UITapGestureRecognizer *)sender {
    [self.delegate labelTapped:sender];
}

@end
