//
//  ThirdViewController.h
//  CCTicker
//
//  Created by Simon De Schutter on 7/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    IBOutlet UIPickerView* currencyPicker;
    NSMutableArray *currencies;
}

@property(nonatomic,retain) IBOutlet UIPickerView* currencyPicker;

@end
