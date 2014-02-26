//
//  FourthViewController.h
//  CCTicker
//
//  Created by Simon De Schutter on 7/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthViewController : UIViewController{
    IBOutlet UITextView *btc;
    IBOutlet UITextView *ltc;
    IBOutlet UITextView *ppc;
    IBOutlet UITextView *nmc;
    IBOutlet UITextView *trc;

}

@property(nonatomic,retain) IBOutlet UITextView *btc;
@property(nonatomic,retain) IBOutlet UITextView *ltc;
@property(nonatomic,retain) IBOutlet UITextView *ppc;
@property(nonatomic,retain) IBOutlet UITextView *nmc;
@property(nonatomic,retain) IBOutlet UITextView *trc;

@end
