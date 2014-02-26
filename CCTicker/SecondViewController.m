//
//  SecondViewController.m
//  CCTicker
//
//  Created by Simon De Schutter on 5/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import "SecondViewController.h"
#import "Foundation/Foundation.h"
#import "CapitalTableViewCell.h"
#import "FirstViewController.h"
#import "AppDelegate.h"


@implementation SecondViewController

@synthesize tableView,totalLabel,totalValueCurrency;
double ibtc = -1.0;
double iltc = -1.0;
double ippc = -1.0;
double inmc = -1.0;
double itrc = -1.0;

double totalBTCValue = 0;
double totalLTCValue = 0;
double totalPPCValue = 0;
double totalNMCValue = 0;
double totalTRCValue = 0;


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tableView.delegate = self;
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] addObserver:self];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] getCoinArray].count;
}



- (UITableViewCell *)tableView:(UITableView *)tbleView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"capitalTickerCell";
    NSString *currencyIndicator = [(AppDelegate*)[[UIApplication sharedApplication] delegate] activeCurrency];
    CapitalTableViewCell *cell = [tbleView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[CapitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    cell.fromCoinAmount.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    cell.fromCoinAmount.returnKeyType = UIReturnKeyDone;
    [cell addObserver:self];
    cell.fromCoinCurrencyLabel.text = [[(AppDelegate*)[[UIApplication sharedApplication] delegate] getCoinArray]objectAtIndex:indexPath.row];
    cell.toCoinCurrencyLabel.text = currencyIndicator;
    if([cell.fromCoinCurrencyLabel.text isEqualToString:@"BTC"]){
        cell.fromCoinAmount.tag = 0;
        if(ibtc == -1 || [(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC] == -1){
            cell.toCoinAmount.text = @"0";
            cell.fromCoinAmount.text = @"0";
        }
        else
        {
            cell.toCoinAmount.text = [NSString stringWithFormat:@"%.2f",ibtc*
                                      [(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC]];
            cell.fromCoinAmount.text = [NSString stringWithFormat:@"%.2f",ibtc];
            totalBTCValue = ibtc*[(AppDelegate*)[[UIApplication sharedApplication] delegate] getBTC];
        }
    }
    if([cell.fromCoinCurrencyLabel.text isEqualToString:@"LTC"]){
        cell.fromCoinAmount.tag = 1;
        if(iltc == -1 || [(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC] == -1){
            cell.toCoinAmount.text = @"0";
            cell.fromCoinAmount.text = @"0";
        }
        else
        {
            cell.toCoinAmount.text = [NSString stringWithFormat:@"%.2f",iltc*
                                      [(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC]];
            cell.fromCoinAmount.text = [NSString stringWithFormat:@"%.2f",iltc];
            totalLTCValue = iltc*[(AppDelegate*)[[UIApplication sharedApplication] delegate] getLTC];
        }
    }
    if([cell.fromCoinCurrencyLabel.text isEqualToString:@"PPC"]){
        cell.fromCoinAmount.tag = 2;
        if(ippc == -1 || [(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC] == -1){
            cell.toCoinAmount.text = @"0";
            cell.fromCoinAmount.text = @"0";
        }
        else
        {
            cell.toCoinAmount.text = [NSString stringWithFormat:@"%.2f",ippc*
                                      [(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC]];
            cell.fromCoinAmount.text = [NSString stringWithFormat:@"%.2f",ippc];
            totalPPCValue = ippc*[(AppDelegate*)[[UIApplication sharedApplication] delegate] getPPC];
        }
    }
    if([cell.fromCoinCurrencyLabel.text isEqualToString:@"NMC"]){
        cell.fromCoinAmount.tag = 3;
        if(inmc == -1 || [(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC] == -1){
            cell.toCoinAmount.text = @"0";
            cell.fromCoinAmount.text = @"0";
        }
        else
        {
            cell.toCoinAmount.text = [NSString stringWithFormat:@"%.2f",inmc*
                                      [(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC]];
            cell.fromCoinAmount.text = [NSString stringWithFormat:@"%.2f",inmc];
            totalNMCValue = inmc*[(AppDelegate*)[[UIApplication sharedApplication] delegate] getNMC];
        }
    }
    if([cell.fromCoinCurrencyLabel.text isEqualToString:@"TRC"]){
        cell.fromCoinAmount.tag = 4;
        if(itrc == -1 || [(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC] == -1){
            cell.toCoinAmount.text = @"0";
            cell.fromCoinAmount.text = @"0";
        }
        else
        {
            cell.toCoinAmount.text = [NSString stringWithFormat:@"%.2f",itrc*
                                      [(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC]];
            cell.fromCoinAmount.text = [NSString stringWithFormat:@"%.2f",itrc];
            totalTRCValue = itrc*[(AppDelegate*)[[UIApplication sharedApplication] delegate] getTRC];
        }
    }
    //if(indexPath.row == [(AppDelegate*)[[UIApplication sharedApplication] delegate] getCoinArray].count-1)
        totalLabel.text = [NSString stringWithFormat:@"%.2f",[self sumTotalCapital]];
    return cell;
}

-(double)sumTotalCapital{
    return totalBTCValue+totalLTCValue+totalNMCValue+totalPPCValue+totalTRCValue;
}

-(void)coinValueChanged:(NSNumber*) value forCurrency:(NSString*) currency{
    if([currency isEqualToString:@"BTC"])
        ibtc = value.doubleValue;
    if([currency isEqualToString:@"LTC"])
        iltc = value.doubleValue;
    if([currency isEqualToString:@"PPC"])
        ippc = value.doubleValue;
    if([currency isEqualToString:@"NMC"])
        inmc = value.doubleValue;
    if([currency isEqualToString:@"TRC"])
        itrc = value.doubleValue;
    [self.tableView reloadData];
}

-(void)updateView{
    totalBTCValue = 0;
    totalLTCValue = 0;
    totalPPCValue = 0;
    totalNMCValue = 0;
    totalTRCValue = 0;
    totalValueCurrency.text = [(AppDelegate*)[[UIApplication sharedApplication] delegate] activeCurrency];
    while([(AppDelegate*)[[UIApplication sharedApplication] delegate] getEditing] && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                                                                                              beforeDate:[NSDate distantFuture]]){/*DO NOTHING*/}
    [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelection = FALSE;
	// Do any additional setup after loading the view, typically from a nib.
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] addObserver:self];
    [self.tableView reloadData];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
