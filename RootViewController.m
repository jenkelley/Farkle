//
//  RootViewController.m
//  Farkle
//
//  Created by Ben Whitley on 3/19/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onRollButtonPressed:(UIButton *)rollButton {

    for (DieLabel *dieLabel in self.dieLabels) {
        dieLabel.text = [NSString stringWithFormat:@"%i", arc4random_uniform(6)+1];
        NSLog(@"%@", dieLabel.text);
    }
    NSLog(@"%lu", (unsigned long)self.dieLabels.count);
}

@end
