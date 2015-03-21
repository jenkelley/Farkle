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
@property int playerScoreInt;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dice = [NSMutableArray new];
    self.selectedDice = [NSMutableArray new];

    for (DieLabel *dieLabel in self.dieLabels) {
        dieLabel.delegate = self;
    }
    self.playerScoreInt = 0;
}

- (IBAction)onRollButtonPressed:(UIButton *)rollButton {
    for (DieLabel *label in self.dieLabels) {
        [label rollDice];
        [self.selectedDice removeAllObjects];
    }
}

- (IBAction)onEndTurnButtonPressed:(id)sender {
    
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

//            if (ones == twos == threes == fours == fives == sixes == 1) {
//                turnScore += 1500;
//            }

            if (!(sixes == 0)) {
                if (sixes == 6) {
                    turnScore += 3000;
                } else if (sixes == 5) {
                    turnScore += 2000;
                } else if (sixes == 4) {
                    turnScore += 1000;
                } else if (sixes == 3){
                    turnScore += 600;
                }
            }
        
            if (!(fives == 0)) {
                if (fives == 6) {
                    turnScore += 3000;
                } else if (fives == 5) {
                    turnScore += 2000;
                } else if (fives == 4) {
                    turnScore += 1000;
                } else if (fives == 3){
                    turnScore += 500;
                } else if (fives == 2) {
                    turnScore += 100;
                } else if (fives == 1) {
                    turnScore += 50;
                }
            }
        
            if (!(fours == 0)) {
                if (fours == 6) {
                    turnScore += 3000;
                } else if (fours == 5) {
                    turnScore += 2000;
                } else if (fours == 4) {
                    turnScore += 1000;
                } else if (fours == 3){
                    turnScore += 400;
                }
            }
        
            if (!(threes == 0)) {
                if (threes == 6) {
                    turnScore += 3000;
                } else if (threes == 5) {
                    turnScore += 2000;
                } else if (threes == 4) {
                    turnScore += 1000;
                } else if (threes == 3){
                    turnScore += 300;
                }
            }
        
            if (!(twos == 0)) {
                if (twos == 6) {
                    turnScore += 3000;
                } else if (twos == 5) {
                    turnScore += 2000;
                } else if (twos == 4) {
                    turnScore += 1000;
                } else if (twos == 3){
                    turnScore += 200;
                }
            }
        
            if (!(ones == 0)) {
                if (ones == 6) {
                    turnScore += 3000;
                } else if (ones == 5) {
                    turnScore += 2000;
                } else if (ones == 4) {
                    turnScore += 1000;
                } else if (ones == 3){
                    turnScore += 300;
                } else if (ones == 2) {
                    turnScore += 200;
                } else if (ones == 1) {
                    turnScore += 100;
                }
            }
        

    NSLog(@"Ones equal %i", ones);
    NSLog(@"Twos equal %i", twos);
    NSLog(@"Threes equal %i", threes);
    NSLog(@"Fours equal %i", fours);
    NSLog(@"Fives equal %i", fives);
    NSLog(@"Sixes equal %i", sixes);

    self.playerScoreInt = self.playerScoreInt + turnScore;
    self.userScore.text = [NSString stringWithFormat:@"Player 1 Score: %i", self.playerScoreInt];
}

@end
