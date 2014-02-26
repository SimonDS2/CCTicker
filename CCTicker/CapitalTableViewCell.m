//
//  CapitalTableViewCell.m
//  CCTicker
//
//  Created by Simon De Schutter on 8/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import "CapitalTableViewCell.h"
#import "SecondViewController.h"
#import "AppDelegate.h"

@implementation CapitalTableViewCell

@synthesize fromCoinAmount = _fromCoinAmount;
@synthesize fromCoinCurrencyLabel = _fromCoinCurrencyLabel;
@synthesize toCoinAmount = _toCoinAmount;
@synthesize toCoinCurrencyLabel = _toCoinCurrencyLabel;
@synthesize observers;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.fromCoinAmount.delegate = self;
    }
    return self;
}

- (void) addObserver:(NSObject *) observer
{
    if (observers == nil){
		observers = [[NSMutableArray alloc] init];
    }
    if(![observers containsObject:observer]){
        [observers addObject: observer];
    }
}

-(void) notifyValue:(NSNumber *) value forCurrency: (NSString*) currency
{
    for (NSObject *o in observers){
		if ([o isKindOfClass:[SecondViewController class]]){
            SecondViewController * svc = (SecondViewController*) o;
            [svc coinValueChanged: value forCurrency: currency];
        }
	}
}

-(void)fromCoinAmountChanged{
    [self notifyValue: [NSNumber numberWithDouble:[_fromCoinAmount.text doubleValue]] forCurrency: _fromCoinCurrencyLabel.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self fromCoinAmountChanged];
    return YES;
}

-(void)didMoveToWindow{
    [_fromCoinAmount becomeFirstResponder];
    [_fromCoinAmount resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField setNeedsDisplay];
    [textField becomeFirstResponder];
    textField.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
