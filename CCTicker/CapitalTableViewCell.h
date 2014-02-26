//
//  CapitalTableViewCell.h
//  CCTicker
//
//  Created by Simon De Schutter on 8/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapitalTableViewCell : UITableViewCell <UITextFieldDelegate>{
    NSMutableArray *observers; 
}

-(void)addObserver:(NSObject*) observer;
-(void)fromCoinAmountChanged;


@property (nonatomic, retain) NSMutableArray *observers;
@property (nonatomic, strong) IBOutlet UITextField *fromCoinAmount;
@property (nonatomic, strong) IBOutlet UILabel *fromCoinCurrencyLabel;
@property (nonatomic, strong) IBOutlet UILabel *toCoinAmount;
@property (nonatomic, strong) IBOutlet UILabel *toCoinCurrencyLabel;
@end
