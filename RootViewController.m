//
//  RootViewController.m
//  Farkle
//
//  Created by Ben Whitley on 3/19/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"

@interface RootViewController () <DieLabelDelegate, UIDynamicItem>

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
@property UIDynamicAnimator *dynamicAnimator;
@property UIDynamicItemBehavior *dynamicItemBehavior;
@property UIGravityBehavior *gravityBehavior;
@property UICollisionBehavior *collisionBehavior;
@property (weak, nonatomic) IBOutlet UILabel *userTwoScore;
//@property UIBezierPath *rectangleBounds;
@property int playerScoreInt;
@property int playerTwoScoreInt;
@property int turnScore;
@property BOOL whichPlayer;
@property (strong, nonatomic) IBOutlet UIView *rollingRectangle;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dice = [NSMutableArray new];
    self.selectedDice = [NSMutableArray new];

    for (DieLabel *dieLabel in self.dieLabels) {
        dieLabel.delegate = self;
    }
   [self.view addSubview:self.rollingRectangle];
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view.superview];
    self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.dieLabels];
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:self.dieLabels];
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.dieLabels];

    // this is where I'm trying to set the boundries so the dice don't fall off the screen. But it's not working.

//    UIBezierPath *bezierRect = [[UIBezierPath alloc] init];
//    [self.collisionBehavior addBoundaryWithIdentifier:(id<NSCopying>) forPath:bezierRect];

    self.turnScore = 0;
    self.playerScoreInt = 0;
    self.whichPlayer = YES;

    [self.dynamicAnimator addBehavior:self.collisionBehavior];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    [self.dynamicAnimator addBehavior:self.dynamicItemBehavior];



}

- (IBAction)onRollButtonPressed:(UIButton *)rollButton {
    for (DieLabel *label in self.dieLabels) {
        [label rollDice];
        [self.selectedDice removeAllObjects];
    }
}

- (IBAction)onEndTurnButtonPressed:(id)sender {
    for (int i = 0; i <= self.selectedDice.count; i++) {
        [self.dieLabels addObject:self.selectedDice[i]];
    }
    [self.selectedDice removeAllObjects];
    self.turnScore = 0;
    self.whichPlayer = !self.whichPlayer;
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
  //  int turnScore = 0;


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
                    self.turnScore += 3000;
                } else if (sixes == 5) {
                    self.turnScore += 2000;
                } else if (sixes == 4) {
                    self.turnScore += 1000;
                } else if (sixes == 3){
                    self.turnScore += 600;
                }
            }
        
            if (!(fives == 0)) {
                if (fives == 6) {
                    self.turnScore += 3000;
                } else if (fives == 5) {
                    self.turnScore += 2000;
                } else if (fives == 4) {
                    self.turnScore += 1000;
                } else if (fives == 3){
                    self.turnScore += 500;
                } else if (fives == 2) {
                    self.turnScore += 100;
                } else if (fives == 1) {
                    self.turnScore += 50;
                }
            }
        
            if (!(fours == 0)) {
                if (fours == 6) {
                    self.turnScore += 3000;
                } else if (fours == 5) {
                    self.turnScore += 2000;
                } else if (fours == 4) {
                    self.turnScore += 1000;
                } else if (fours == 3){
                    self.turnScore += 400;
                }
            }
        
            if (!(threes == 0)) {
                if (threes == 6) {
                    self.turnScore += 3000;
                } else if (threes == 5) {
                    self.turnScore += 2000;
                } else if (threes == 4) {
                    self.turnScore += 1000;
                } else if (threes == 3){
                    self.turnScore += 300;
                }
            }
        
            if (!(twos == 0)) {
                if (twos == 6) {
                    self.turnScore += 3000;
                } else if (twos == 5) {
                    self.turnScore += 2000;
                } else if (twos == 4) {
                    self.turnScore += 1000;
                } else if (twos == 3){
                    self.turnScore += 200;
                }
            }
        
            if (!(ones == 0)) {
                if (ones == 6) {
                    self.turnScore += 3000;
                } else if (ones == 5) {
                    self.turnScore += 2000;
                } else if (ones == 4) {
                    self.turnScore += 1000;
                } else if (ones == 3){
                    self.turnScore += 300;
                } else if (ones == 2) {
                    self.turnScore += 200;
                } else if (ones == 1) {
                    self.turnScore += 100;
                }
            }
        

    NSLog(@"Ones equal %i", ones);
    NSLog(@"Twos equal %i", twos);
    NSLog(@"Threes equal %i", threes);
    NSLog(@"Fours equal %i", fours);
    NSLog(@"Fives equal %i", fives);
    NSLog(@"Sixes equal %i", sixes);

    if (self.whichPlayer == YES) {
        self.playerScoreInt = self.playerScoreInt + self.turnScore;
        self.userScore.text = [NSString stringWithFormat:@"Player 1 Score: %i", self.playerScoreInt];
    } else if (self.whichPlayer == NO){
        self.playerTwoScoreInt = self.playerTwoScoreInt + self.turnScore;
        self.userTwoScore.text = [NSString stringWithFormat:@"PLayer 2 Score: %i", self.playerTwoScoreInt];
    }
}

@end
