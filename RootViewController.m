//
//  RootViewController.m
//  Farkle
//
//  Created by Ben Whitley on 3/19/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"
#import "ShakeView.h"

@interface RootViewController () <DieLabelDelegate, UIDynamicItem, UICollisionBehaviorDelegate>

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
//below are the properties I added to make it animate, i also added a delegate
@property UIDynamicAnimator *dynamicAnimator;
@property UIDynamicItemBehavior *dynamicItemBehavior;
@property UIGravityBehavior *gravityBehavior;
@property UICollisionBehavior *collisionBehavior;
@property (weak, nonatomic) IBOutlet UILabel *userTwoScore;

@property int playerScoreInt;
@property int playerTwoScoreInt;
@property int turnScore;
@property BOOL whichPlayer;
@property (strong, nonatomic) IBOutlet UIView *rollingRectangle;
@property (strong, nonatomic) IBOutlet UIView *pickedView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//new just add ones 'placeholder' for memory.
    self.selectedDice = [NSMutableArray arrayWithCapacity:6];

    for (DieLabel *dieLabel in self.dieLabels) {
        dieLabel.delegate = self;
    }
    [self.view addSubview:self.rollingRectangle];
    [self.rollingRectangle addSubview:self.pickedView];
    [self dynamicMovement];

    self.turnScore = 0;
    self.playerScoreInt = 0;
    self.whichPlayer = YES;
}

- (IBAction)onRollButtonPressed:(UIButton *)rollButton {
    [self dynamicMovement];
    [self.selectedDice removeAllObjects];
}
-(void)labelTapped:(UITapGestureRecognizer *)tap{
    [self findLabelUsingPoint:[tap locationInView:self.rollingRectangle]];
    self.tappedDieLabel.backgroundColor = [UIColor orangeColor];
    [self.dice addObject:self.tappedDieLabel];
    [self.selectedDice addObject:self.tappedDieLabel];
    [self.dieLabels removeObject:self.tappedDieLabel];
    [self updateScore];
}

-(void)findLabelUsingPoint:(CGPoint)tap {
    for (DieLabel *dieLabelTapped in self.dieLabels){
        if (CGRectContainsPoint(dieLabelTapped.frame, tap)) {
            self.tappedDieLabel = dieLabelTapped;
        }
    }
}
//pan Gesture. Doesn't currently work.
-(void)panHandler: (UIPanGestureRecognizer *)drag{
    CGPoint point = [drag locationInView:self.view];
    self.tappedDieLabel.center =  point;

    //if the picked die that is being panned starts in the rolling rectangle and it it ends in the picked rectangle, then update the location to where it's dragged
    if (drag.state == UIGestureRecognizerStateBegan) {
        [self findLabelUsingPoint:[drag locationInView:self.rollingRectangle]];
        if (CGRectContainsPoint(self.pickedView.frame, point)) {
            [UIView animateWithDuration:0.5 animations:^{
                self.tappedDieLabel.center = self.pickedView.center;
            }];
        }
        //if it's not in the picked frame
    } else if (drag.state ==UIGestureRecognizerStateEnded){
        if (CGRectContainsPoint(self.rollingRectangle.frame, point)) {
            self.tappedDieLabel.center = self.tappedDieLabel.center;
        }
    }
}

#pragma mark - "Shake Action"
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"Shake happend …");
    [self dynamicMovement];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.view becomeFirstResponder];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view resignFirstResponder];
    [super viewWillDisappear:animated];
}

#pragma mark - "New Turn"

- (IBAction)onEndTurnButtonPressed:(id)sender {
    for (int i = 0; i <= self.selectedDice.count; i++) {
        [self.dieLabels addObject:self.selectedDice[i]];
    }
    [self.selectedDice removeAllObjects];
    self.turnScore = 0;
    self.whichPlayer = !self.whichPlayer;
}

#pragma mark - "scoring"

-(void)updateScore {

    int ones = 0;
    int twos = 0;
    int threes = 0;
    int fours = 0;
    int fives = 0;
    int sixes = 0;
  //  int turnScore = 0;

    //when pan gesture works, this needs to say the selected die is in the picked view
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
                    //this value needs to be 500-150 because three ones were tapped and this is just adding the difference
                    self.turnScore += 350;
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
                //don't need the below because if three are picked it'll automatically go
//                } else if (ones == 3){
//                    self.turnScore += 300;
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
       // self.playerScoreInt = self.playerScoreInt + self.turnScore;
        self.userScore.text = [NSString stringWithFormat:@"Player 1 Score: %i", self.turnScore];
    } else if (self.whichPlayer == NO){
       // self.playerTwoScoreInt = self.playerTwoScoreInt + self.turnScore;
        self.userTwoScore.text = [NSString stringWithFormat:@"PLayer 2 Score: %i", self.turnScore];
    }
}

-(void)displayScoreAfterFirstTurn{

    //this doesn't work because it's not adding the previous score to the current score; need to make a new variable that represents what the score already is
    if (self.whichPlayer == YES) {
        self.playerScoreInt = self.playerScoreInt + self.turnScore;
        self.userScore.text = [NSString stringWithFormat:@"Player 1 Score: %i", self.playerScoreInt];
    } else if (self.whichPlayer == NO){
        self.playerTwoScoreInt = self.playerTwoScoreInt + self.turnScore;
        self.userTwoScore.text = [NSString stringWithFormat:@"PLayer 2 Score: %i", self.playerTwoScoreInt];
    }

}

#pragma mark - "Dynamic Movement"
//this is all the movement
- (void)dynamicMovement {
    for (DieLabel *die in self.dieLabels) {
       [self.rollingRectangle addSubview:die];
    //before initializing the item behavior, I had to give it bounds, and center. Bounds is the size
        die.center = CGPointMake(120, 100);
        die.bounds = CGRectMake(120, 100, 40, 40);
    }

    //I initialized the animator with the rectangle view
    //remove behaviors before you add new ones
    self.dynamicAnimator= [[UIDynamicAnimator alloc] initWithReferenceView:self.rollingRectangle];
    //the settings for the behavior influence how everything behaves.
    self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.dieLabels];
    self.dynamicItemBehavior.elasticity = 0.9; //bouncy
    self.dynamicItemBehavior.angularResistance = 0.6; //spins?
    self.dynamicItemBehavior.friction = 0.0; //interaction between squares?
    self.dynamicItemBehavior.density = 0.3; //dense

    self.gravityBehavior =[[UIGravityBehavior alloc] initWithItems:self.dieLabels];
    //this sets the bounds for the collisions. I did it individually because I couldn't find a way to tell it that the frame was the boundary


    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.dieLabels];
    self.collisionBehavior.collisionDelegate = self;


    //this tells it that the boundries are the rectangle it's in
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    bezierPath = [UIBezierPath bezierPathWithRect:self.rollingRectangle.frame];
    [self.collisionBehavior addBoundaryWithIdentifier:@"Rectangle Used for Rolling" forPath:bezierPath];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//I'm adding all the behaviors I want on the animator
        [self.dynamicAnimator addBehavior:self.dynamicItemBehavior];
        [self.dynamicAnimator addBehavior:self.gravityBehavior];
        [self.dynamicAnimator addBehavior:self.collisionBehavior];
}
//this determines what happens when the die collide. I have them changing value and making gravity weird
//-(void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier{
//    for (DieLabel *label in self.dieLabels) {
//        [label rollDice];
//        self.gravityBehavior.angle = .3;
//        self.gravityBehavior.gravityDirection = CGVectorMake(1, 0);
//    }
//}
-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    if ([item1 isKindOfClass:[DieLabel class]] && [item2 isKindOfClass:[DieLabel class]] ) {
        [((DieLabel *)item1) rollDice];
        [((DieLabel *)item2) rollDice];
    }
}
@end
