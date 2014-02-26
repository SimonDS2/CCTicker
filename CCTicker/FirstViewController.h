//
//  FirstViewController.h
//  CCTicker
//
//  Created by Simon De Schutter on 5/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UITableView *tableView;
    NSMutableArray *observers;
}

-(void) updateView;

@property(nonatomic, retain)IBOutlet UITableView* tableView;


@end
