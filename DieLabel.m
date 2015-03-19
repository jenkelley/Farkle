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

-(IBAction)onOneTapped:(UITapGestureRecognizer *)sender {
    
}

-(IBAction)onTwoTapped:(UITapGestureRecognizer *)sender {

}

-(IBAction)onThreeTapped:(UITapGestureRecognizer *)sender {

}

-(IBAction)onFourTapped:(UITapGestureRecognizer *)sender {

}

-(IBAction)onFiveTapped:(UITapGestureRecognizer *)sender {

}

-(IBAction)onSixTapped:(UITapGestureRecognizer *)sender {

}

@end
