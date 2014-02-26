//
//  ThirdViewController.m
//  CCTicker
//
//  Created by Simon De Schutter on 7/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import "ThirdViewController.h"
#import "AppDelegate.h"


@implementation ThirdViewController

@synthesize currencyPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currencyPicker.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    currencies = [[NSMutableArray alloc] init];
    [currencies addObject:@"USD"];
    [currencies addObject:@"EUR"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [currencies count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [currencies objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] setCurrency:[currencies objectAtIndex:row]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
