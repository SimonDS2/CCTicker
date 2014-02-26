//
//  FourthViewController.m
//  CCTicker
//
//  Created by Simon De Schutter on 7/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import "FourthViewController.h"


@implementation FourthViewController

@synthesize btc,ltc,ppc,nmc,trc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	btc.editable = FALSE;
    ltc.editable = FALSE;
    ppc.editable = FALSE;
    nmc.editable = FALSE;
    trc.editable = FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
