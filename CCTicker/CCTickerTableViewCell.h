//
//  CCTickerTableViewCell.h
//  CCTicker
//
//  Created by Simon De Schutter on 5/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCTickerTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *coinLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UIImageView *statusImageView;

-(void)setCoinLabelText:(NSString *)coinLabelString;
-(void)setPriceLabelText:(NSString *)priceLabelString;
-(void)setStatusImage:(NSString *)statusImageString;

@end
