//
//  ExchangeAPIConnection.h
//  CCTicker
//
//  Created by Simon De Schutter on 7/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AppDelegate;
#define appDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

@interface ExchangeAPIConnection : NSObject{
    NSURLConnection *btcConnection;
    NSURLConnection *ltcConnection;
    NSURLConnection *ppcConnection;
    NSURLConnection *nmcConnection;
    NSURLConnection *trcConnection;
    NSMutableData *receivedData;
    NSMutableArray *observers;
}

@property(nonatomic,retain)    NSMutableArray *observers;

+ (ExchangeAPIConnection *) instance;
-(void) requestBTCValue;
-(void) requestLTCValue;
-(void) requestPPCValue;
-(void) requestNMCValue;
-(void) requestTRCValue;

-(void) addObserver: (NSObject *) obs;

@end
