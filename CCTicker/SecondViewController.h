//
//  SecondViewController.h
//  CCTicker
//
//  Created by Simon De Schutter on 5/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UITableView *tableView;
    IBOutlet UILabel *totalLabel;
    IBOutlet UILabel *totalValueCurrency;
}

-(void)coinValueChanged:(NSNumber*) value forCurrency:(NSString*) currency;
-(void)updateView;

@property(nonatomic, retain)IBOutlet UITableView* tableView;
@property(nonatomic, retain)IBOutlet UILabel* totalLabel;
@property(nonatomic, retain)IBOutlet UILabel* totalValueCurrency;

@end
