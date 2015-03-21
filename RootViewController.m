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
@property NSMutableArray *dice;
@property NSMutableArray *selectedDice;

@property DieLabel *tappedDieLabel;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelOne;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabelTwo;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabelThree;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabelFour;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabelFive;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabelSix;
@property (weak, nonatomic) IBOutlet UILabel *userScore;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dice = [NSMutableArray new];
    self.selectedDice = [NSMutableArray new];

    for (DieLabel *dieLabel in self.dieLabels) {
        dieLabel.delegate = self;
    }
}

- (IBAction)onRollButtonPressed:(UIButton *)rollButton {
    for (DieLabel *label in self.dieLabels) {
        [label rollDice];
        [self.selectedDice removeAllObjects];
    }
}

-(void)labelTapped:(UITapGestureRecognizer *)tap {
    [self findLabelUsingPoint:[tap locationInView:self.view]];
    self.tappedDieLabel.backgroundColor = [UIColor orangeColor];
    [self.dice addObject:self.tappedDieLabel];
    [self.selectedDice addObject:self.tappedDieLabel];
    [self.dieLabels removeObject:self.tappedDieLabel];
    [self updateScore];
//    NSLog(@"%lu", (unsigned long)self.dice.count);
}

-(void)findLabelUsingPoint:(CGPoint)tap {
    for (DieLabel *dieLabelTapped in self.dieLabels){
        if (CGRectContainsPoint(dieLabelTapped.frame, tap)) {
            self.tappedDieLabel = dieLabelTapped;
        }
    }
}

-(void)updateScore {

    int ones = 0;
    int twos = 0;
    int threes = 0;
    int fours = 0;
    int fives = 0;
    int sixes = 0;
    int turnScore = 0;

    for (DieLabel *die in self.selectedDice) {
        switch ([die.text intValue]) {
            case 1:
                ones++;
                break;
            case 2:
                twos++;
                break;
            case 3:
                threes++;
                break;
            case 4:
                fours++;
                break;
            case 5:
                fives++;
                break;
            case 6:
                sixes++;
                break;
            default:
                break;
        }
    }

//    if (ones == twos == threes == fours == fives == sixes == 1) {
//        turnScore += 1500;
//    } else if () {
//
//    }
}

@end
