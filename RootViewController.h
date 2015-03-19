//
//  RootViewController.h
//  Farkle
//
//  Created by Ben Whitley on 3/19/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DieLabel.h"

@interface RootViewController : UIViewController

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelOne;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelTwo;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelThree;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelFour;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelFive;

@property (weak, nonatomic) IBOutlet DieLabel *dieLabelSix;
@end
