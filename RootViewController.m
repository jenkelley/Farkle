//
//  RootViewController.m
//  Farkle
//
//  Created by Ben Whitley on 3/19/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"

@interface RootViewController () <DieLabelDelegate>

@property IBOutletCollection(DieLabel) NSMutableArray *dieLabels;

@property DieLabel *tappedDieLabel;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelOne;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelTwo;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelThree;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelFour;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelFive;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelSix;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (DieLabel *dieLabel in self.dieLabels) {
        dieLabel.delegate = self;
    }
}

- (IBAction)onRollButtonPressed:(UIButton *)rollButton {

    for (DieLabel *label in self.dieLabels) {
        [label rollDice];
    }
}

-(void)labelTapped:(UITapGestureRecognizer *)tap {
    [self findLabelUsingPoint:[tap locationInView:self.view]];
    self.tappedDieLabel.backgroundColor = [UIColor orangeColor];
    [self.dieLabels removeObject:self.tappedDieLabel];

}

-(void)findLabelUsingPoint:(CGPoint)tap {
    for (DieLabel *dieLabelTapped in self.dieLabels){
        if (CGRectContainsPoint(dieLabelTapped.frame, tap)) {
            self.tappedDieLabel = dieLabelTapped;
        }
    }
}

@end
