//
//  CCTickerTableViewCell.m
//  CCTicker
//
//  Created by Simon De Schutter on 5/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import "CCTickerTableViewCell.h"

@implementation CCTickerTableViewCell
@synthesize coinLabel = _coinLabel;
@synthesize priceLabel = _priceLabel;
@synthesize statusImageView = _statusImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCoinLabelText:(NSString *)coinLabelString{
    _coinLabel.text = coinLabelString;
}

-(void)setPriceLabelText:(NSString *)priceLabelString{
    _priceLabel.text = priceLabelString;
}

-(void)setStatusImage:(NSString *)statusImageString{
    UIImage * image = [UIImage imageNamed:statusImageString];
    [_statusImageView setImage:image];
}


@end
