//
//  FirstViewController.m
//  CCTicker
//
//  Created by Simon De Schutter on 5/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import "FirstViewController.h"
#import "CCTickerTableViewCell.h"
#import "SecondViewController.h"
#import "AppDelegate.h"


@implementation FirstViewController

@synthesize tableView;

NSString *lowFormat = @"%.3f %@";
NSString *midFormat = @"%.2f %@";
NSString *highFormat = @"%.1f %@";



-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tableView.delegate = self;
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] addObserver:self];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] addObserver:self];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
       return [(AppDelegate*)[[UIApplication sharedApplication] delegate] getCoinArray].count;
}



- (UITableViewCell *)tableView:(UITableView *)tbleView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"tickerCell";
    NSString *currencyIndicator = [(AppDelegate*)[[UIApplication sharedApplication] delegate] activeCurrency];
    CCTickerTableViewCell *cell = [tbleView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[CCTickerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    cell.coinLabel.text = [[(AppDelegate*)[[UIApplication sharedApplication] delegate] getCoinArray]objectAtIndex:indexPath.row];
    if([cell.coinLabel.text isEqualToString:@"BTC"]){
        if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC] != -1.0){
            if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC]/1000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:lowFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC],currencyIndicator];
            else if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC]/10000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:midFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC],currencyIndicator];
            else
                cell.priceLabel.text = [NSString stringWithFormat:highFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC],currencyIndicator];
        }
        else
            cell.priceLabel.text = @"---";
        [self setTickerImageOnCell: cell value: [(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC] prevValue:
         [(AppDelegate*)[[UIApplication sharedApplication] delegate] getPrevBTC]];
    }
    if([cell.coinLabel.text isEqualToString:@"LTC"]){
        if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC] != -1.0){
            if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC]/1000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:lowFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC],currencyIndicator];
            else if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC]/10000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:midFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC],currencyIndicator];
            else
                cell.priceLabel.text = [NSString stringWithFormat:highFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC],currencyIndicator];
        }
        else
            cell.priceLabel.text = @"---";
        [self setTickerImageOnCell: cell value: [(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC] prevValue:
         [(AppDelegate*)[[UIApplication sharedApplication] delegate] getPrevLTC]];
    }
    if([cell.coinLabel.text isEqualToString:@"PPC"]){
        if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC] != -1.0){
            if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC]/1000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:lowFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC],currencyIndicator];
            else if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC]/10000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:midFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC],currencyIndicator];
            else
                cell.priceLabel.text = [NSString stringWithFormat:highFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC],currencyIndicator];
        }
        else
            cell.priceLabel.text = @"---";
        [self setTickerImageOnCell: cell value: [(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC] prevValue:
         [(AppDelegate*)[[UIApplication sharedApplication] delegate] getPrevPPC]];
    }
    if([cell.coinLabel.text isEqualToString:@"NMC"]){
        if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC] != -1.0){
            if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC]/1000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:lowFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC],currencyIndicator];
            else if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC]/10000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:midFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC],currencyIndicator];
            else
                cell.priceLabel.text = [NSString stringWithFormat:highFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC],currencyIndicator];
        }
        else
            cell.priceLabel.text = @"---";
        [self setTickerImageOnCell: cell value: [(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC] prevValue:
         [(AppDelegate*)[[UIApplication sharedApplication] delegate] getPrevNMC]];
    }
    if([cell.coinLabel.text isEqualToString:@"TRC"]){
        if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC] != -1.0){
            if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC]/1000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:lowFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC],currencyIndicator];
            else if([(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC]/10000 < 1)
                cell.priceLabel.text = [NSString stringWithFormat:midFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC],currencyIndicator];
            else
                cell.priceLabel.text = [NSString stringWithFormat:highFormat,[(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC],currencyIndicator];
        }
        else
            cell.priceLabel.text = @"---";
        [self setTickerImageOnCell: cell value: [(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC] prevValue:
         [(AppDelegate*)[[UIApplication sharedApplication] delegate] getPrevTRC]];
    }
    return cell;
}

-(void)setTickerImageOnCell:(CCTickerTableViewCell *) cell value: (double) value prevValue: (double) prevValue{
    if(prevValue == -1.0 || value == prevValue){
        [cell setStatusImage: nil];
    }
    else
    if (value > prevValue){
        [cell setStatusImage: @"tickerup.png"];
    }
    else
    if(value < prevValue){
        [cell setStatusImage: @"tickerdown.png"];
    }
}

-(void) updateView{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
