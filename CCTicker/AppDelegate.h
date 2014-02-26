//
//  AppDelegate.h
//  CCTicker
//
//  Created by Simon De Schutter on 5/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchangeAPIConnection.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSMutableArray *coinArray;
    ExchangeAPIConnection *apiConnection;
    NSMutableArray *observers;
    NSString *activeCurrency;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) NSMutableArray* coinArray;
@property(nonatomic, retain) ExchangeAPIConnection* apiConnection;
@property(nonatomic, retain) NSString *activeCurrency;


- (NSMutableArray*) getCoinArray;
- (void) notifyForCoin:(NSString *) coin value:(NSNumber *) value;
- (void) addObserver:(NSObject *) obs;
- (void) setCurrency:(NSString *) currency;
- (void) reloadTickerScreen;

-(double)getBTC;
-(double)getLTC;
-(double)getPPC;
-(double)getNMC;
-(double)getTRC;

-(double)getPrevBTC;
-(double)getPrevLTC;
-(double)getPrevPPC;
-(double)getPrevNMC;
-(double)getPrevTRC;

-(BOOL)getEditing;




@end
