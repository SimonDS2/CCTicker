//
//  AppDelegate.m
//  CCTicker
//
//  Created by Simon De Schutter on 5/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation AppDelegate

@synthesize coinArray,apiConnection,activeCurrency;
double btc = -1.0;
double ltc = -1.0;
double ppc = -1.0;
double nmc = -1.0;
double trc = -1.0;
double prevbtc = -1.0;
double prevltc = -1.0;
double prevppc = -1.0;
double prevnmc = -1.0;
double prevtrc = -1.0;
BOOL isEditing = FALSE;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    coinArray = [[NSMutableArray alloc]init];
    [[ExchangeAPIConnection instance] addObserver:self];
    activeCurrency = @"USD";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"YES",@"btc",
                                 @"YES",@"ltc",
                                 @"YES",@"ppc",
                                 @"YES",@"nmc",
                                 @"YES",@"trc",
                                 nil];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    BOOL btc = [defaults boolForKey:@"btc"];
    BOOL ltc = [defaults boolForKey:@"ltc"];
    BOOL ppc = [defaults boolForKey:@"ppc"];
    BOOL nmc = [defaults boolForKey:@"nmc"];
    BOOL trc = [defaults boolForKey:@"trc"];
    if(btc)
        [coinArray addObject:@"BTC"];
    if(ltc)
        [coinArray addObject:@"LTC"];
    if(ppc)
        [coinArray addObject:@"PPC"];
    if(nmc)
        [coinArray addObject:@"NMC"];
    if(trc)
        [coinArray addObject:@"TRC"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTickerScreen)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
    [self startAPIConnections];
    //[self.window makeKeyAndVisible];
    return YES;
}

-(double)getBTC{
    return btc;
}
-(double)getLTC{
    return ltc;
}
-(double)getPPC{
    return ppc;
}
-(double)getNMC{
    return nmc;
}
-(double)getTRC{
    return trc;
}

-(double)getPrevBTC{
    return prevbtc;
}
-(double)getPrevLTC{
    return prevltc;
}
-(double)getPrevPPC{
    return prevppc;
}
-(double)getPrevNMC{
    return prevnmc;
}
-(double)getPrevTRC{
    return prevtrc;
}

-(BOOL)getEditing{
    return isEditing;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    isEditing = FALSE;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void) reloadTickerScreen{
    [coinArray removeAllObjects];
    btc = -1.0;
    ltc = -1.0;
    ppc = -1.0;
    nmc = -1.0;
    trc = -1.0;
    prevbtc = -1.0;
    prevltc = -1.0;
    prevppc = -1.0;
    prevnmc = -1.0;
    prevtrc = -1.0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL btc = [defaults boolForKey:@"btc"];
    BOOL ltc = [defaults boolForKey:@"ltc"];
    BOOL ppc = [defaults boolForKey:@"ppc"];
    BOOL nmc = [defaults boolForKey:@"nmc"];
    BOOL trc = [defaults boolForKey:@"trc"];
    if(btc)
        [coinArray addObject:@"BTC"];
    if(ltc)
        [coinArray addObject:@"LTC"];
    if(ppc)
        [coinArray addObject:@"PPC"];
    if(nmc)
        [coinArray addObject:@"NMC"];
    if(trc)
        [coinArray addObject:@"TRC"];
    for (NSObject *o in observers){
		if ([o isKindOfClass:[FirstViewController class]]){
            FirstViewController * fvc = (FirstViewController*) o;
            [fvc updateView];
        }
        if ([o isKindOfClass:[SecondViewController class]]){
            SecondViewController * svc = (SecondViewController*) o;
            [svc updateView];
        }
	}
    [self requestCoinValues];
}


-(void)requestCoinValues{
    NSLog(@"New Value Resuest");
    for(int i = 0; i < coinArray.count;i++){
        if([[coinArray objectAtIndex:i] isEqualToString:@"BTC"])
            [[ExchangeAPIConnection instance] requestBTCValue];
        if([[coinArray objectAtIndex:i] isEqualToString:@"LTC"])
            [[ExchangeAPIConnection instance] requestLTCValue];
        if([[coinArray objectAtIndex:i] isEqualToString:@"PPC"])
            [[ExchangeAPIConnection instance] requestPPCValue];
        if([[coinArray objectAtIndex:i] isEqualToString:@"NMC"])
            [[ExchangeAPIConnection instance] requestNMCValue];
        if([[coinArray objectAtIndex:i] isEqualToString:@"TRC"])
            [[ExchangeAPIConnection instance] requestTRCValue];
    }
}

-(void)startAPIConnections{
    [self requestCoinValues];
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(requestCoinValues) userInfo:nil repeats:YES];
}

- (NSMutableArray*) getCoinArray{
    return self.coinArray;
}

- (void) setCurrency:(NSString *)currency{
    activeCurrency = currency;
    [self reloadTickerScreen];
}

- (void) addObserver:(NSObject *) obs
{
    if (observers == nil){
		observers = [[NSMutableArray alloc] init];
    }
	[observers addObject: obs];
}

-(void) updateCoin: (NSString *) coin value: (NSNumber *) value
{
    if([coin isEqualToString:@"BTC"]){
        prevbtc = btc;
        btc = value.doubleValue;
    }
    if([coin isEqualToString:@"LTC"]){
        if([[(AppDelegate*)[[UIApplication sharedApplication] delegate] activeCurrency] isEqualToString:@"USD"]){
            prevltc = ltc;
            ltc = value.doubleValue;
        }
        if([[(AppDelegate*)[[UIApplication sharedApplication] delegate] activeCurrency] isEqualToString:@"EUR"]){
            while(btc == -1.0 && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                                          beforeDate:[NSDate distantFuture]]){}
            prevltc = ltc;
            ltc = [self convertToCurrency: value.doubleValue];
        }
    }
    if([coin isEqualToString:@"PPC"])
    {
        while(btc == -1.0 && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                                      beforeDate:[NSDate distantFuture]]){}
        prevppc = ppc;
        ppc = [self convertToCurrency: value.doubleValue];
    }
    if([coin isEqualToString:@"NMC"])
    {
        while(btc == -1.0 && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                                      beforeDate:[NSDate distantFuture]]){}
        prevnmc = nmc;
        nmc = [self convertToCurrency: value.doubleValue];
    }
    if([coin isEqualToString:@"TRC"])
    {
        while(btc == -1.0 && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                                      beforeDate:[NSDate distantFuture]]){}
        prevtrc = trc;
        trc = [self convertToCurrency: value.doubleValue];
    }

}

-(double) convertToCurrency: (double) value{
    return value*btc;
}

-(void)keyboardDidShow{
    [self beginEdit];
}

-(void)keyboardDidHide{
    [self endEdit];
}


-(void) beginEdit{
    isEditing = TRUE;
}

-(void) endEdit{
    isEditing = FALSE;
}

-(void) notifyForCoin: (NSString *) coin value: (NSNumber *) value
{
    [self updateCoin: coin value: value];
    for (NSObject *o in observers){
		if ([o isKindOfClass:[FirstViewController class]]){
            FirstViewController * fvc = (FirstViewController*) o;
            [fvc updateView];
        }
        if ([o isKindOfClass:[SecondViewController class]]){
            SecondViewController * svc = (SecondViewController*) o;
            [svc updateView];
        }
	}
}



@end
