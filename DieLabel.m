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

-(void)roll {
    //    DieLabel *rollLabelOne = [[DieLabel alloc] initWithFrame:CGRectMake(100, 100, 50, 50)]
    //    DieLabel *rollLabelTwo;
    //    DieLabel *rollLabelThree;
    //    DieLabel *rollLabelFour;
    //    DieLabel *rollLabelFive;
    //    DieLabel *rollLabelSix;

    DieLabel *anyDie;
    anyDie.text = [NSString stringWithFormat:@"%i", arc4random_uniform(7)+1];
}
@end
