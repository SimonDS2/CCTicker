//
//  ExchangeAPIConnection.m
//  CCTicker
//
//  Created by Simon De Schutter on 7/04/13.
//  Copyright (c) 2013 Simon De Schutter. All rights reserved.
//

#import "ExchangeAPIConnection.h"
#import "AppDelegate.h"

@implementation ExchangeAPIConnection

@synthesize observers;

int btcConCounter=0;
int ltcConCounter=0;
int ppcConCounter=0;
int nmcConCounter=0;
int trcConCounter=0;


static ExchangeAPIConnection *apiConnection;
//return the instance of the class
+ (ExchangeAPIConnection *) instance
{
	if (apiConnection == nil ){
		apiConnection = [[ExchangeAPIConnection alloc]init];
	}
	return apiConnection;
}


-(void) requestBTCValue{
    btcConCounter++;
    //This is the url to send the request to
    NSString *url;
    if([[appDelegate activeCurrency] isEqualToString:@"USD"])
        url = [NSString stringWithFormat:@"https://data.mtgox.com/api/2/BTCUSD/money/ticker"];
    if([[appDelegate activeCurrency] isEqualToString:@"EUR"])
        url = [NSString stringWithFormat:@"https://data.mtgox.com/api/2/BTCEUR/money/ticker"];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10.0];
    btcConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(btcConnection){
        receivedData = [NSMutableData data];
    }
}

-(void) requestLTCValue{
    ltcConCounter++;
    NSString *url;
    if([[appDelegate activeCurrency] isEqualToString:@"USD"])
        url = [NSString stringWithFormat:@"https://btc-e.com/api/2/ltc_usd/ticker"];
    if([[appDelegate activeCurrency] isEqualToString:@"EUR"])
        url = [NSString stringWithFormat:@"https://btc-e.com/api/2/ltc_btc/ticker"];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10.0];
    ltcConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(ltcConnection){
        receivedData = [NSMutableData data];
    }
}

-(void) requestPPCValue{
    ppcConCounter++;
    NSString *url = [NSString stringWithFormat:@"https://btc-e.com/api/2/ppc_btc/ticker"];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10.0];
    ppcConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(ppcConnection){
        receivedData = [NSMutableData data];
    }
}

-(void) requestNMCValue{
    nmcConCounter++;
    NSString *url = [NSString stringWithFormat:@"https://btc-e.com/api/2/nmc_btc/ticker"];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10.0];
    nmcConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(nmcConnection){
        receivedData = [NSMutableData data];
    }
}

-(void) requestTRCValue{
    trcConCounter++;
    NSString *url = [NSString stringWithFormat:@"https://btc-e.com/api/2/trc_btc/ticker"];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString: url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10.0];
    trcConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(trcConnection){
        receivedData = [NSMutableData data];
    }
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
	NSCachedURLResponse *newCachedResponse = cachedResponse;
	
	if ([[[[cachedResponse response] URL] scheme] isEqual:@"https"]){
		newCachedResponse = nil;
	}
	else {
		NSDictionary *newUserInfo;
		newUserInfo = [NSDictionary dictionaryWithObject:[NSDate date] forKey: @"Cached Date"];
		newCachedResponse = [[NSCachedURLResponse alloc] initWithResponse:[cachedResponse response] data:[cachedResponse data] userInfo: newUserInfo storagePolicy:[cachedResponse storagePolicy]];
	}
	return newCachedResponse;
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[receivedData setLength: 0];
}

//Actions to be performed when we receive a response from the NoiseTube server
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if (connection == btcConnection){
        btcConnection = 0;
        NSDictionary *result = [response objectForKey:@"data"];
        NSDictionary *last = [result objectForKey:@"last"];
        NSNumber *value = [NSNumber numberWithDouble:[[last objectForKey:@"value"] doubleValue]];
        [self notifyForCoin: @"BTC" value: value];
    }else
    if (connection == ltcConnection){
        ltcConnection = 0;
        NSDictionary *result = [response objectForKey:@"ticker"];
        NSNumber *value = [NSNumber numberWithDouble:[[result objectForKey:@"last"] doubleValue]];
        [self notifyForCoin: @"LTC" value: value];
    }else
    if (connection == ppcConnection){
        ppcConnection = 0;
        NSDictionary *result = [response objectForKey:@"ticker"];
        NSNumber *value = [NSNumber numberWithDouble:[[result objectForKey:@"last"] doubleValue]];
        [self notifyForCoin: @"PPC" value: value];
    }else
    if (connection == nmcConnection){
        nmcConnection = 0;
        NSDictionary *result = [response objectForKey:@"ticker"];
        NSNumber *value = [NSNumber numberWithDouble:[[result objectForKey:@"last"] doubleValue]];
        [self notifyForCoin: @"NMC" value: value];
    }else
    if (connection == trcConnection){
        trcConnection = 0;
        NSDictionary *result = [response objectForKey:@"ticker"];
        NSNumber *value = [NSNumber numberWithDouble:[[result objectForKey:@"last"] doubleValue]];
        [self notifyForCoin: @"TRC" value: value];
    }
}

//Actions to be performed when the connection to the NoiseTube server failed
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"connection failed ! error %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
    if(connection == btcConnection){
        if (btcConCounter < 2)
        {
            [self requestBTCValue];
        }
        else
            btcConCounter = 0;
    }
    if(connection == ltcConnection){
        if (ltcConCounter < 2)
        {
            [self requestLTCValue];
        }
        else
            ltcConCounter = 0;
    }
    if(connection == ppcConnection){
        if (ppcConCounter < 2)
        {
            [self requestPPCValue];
        }
        else
            ppcConCounter = 0;
    }
    if(connection == nmcConnection){
        if (nmcConCounter < 2)
        {
            [self requestNMCValue];
        }
        else
            nmcConCounter = 0;
    }
    if(connection == trcConnection){
        if (trcConCounter < 2)
        {
            [self requestTRCValue];
        }
        else
            trcConCounter = 0;
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *) connection
{
   
}

- (void) addObserver:(NSObject *) obs
{
    if (observers == nil){
		observers = [[NSMutableArray alloc] init];
    }
	[observers addObject: obs];
}

-(void) notifyForCoin: (NSString *) coin value: (NSNumber *) value
{
    for (NSObject *o in observers){
		if ([o isKindOfClass:[AppDelegate class]]){
            AppDelegate * ad = (AppDelegate*) o;
            [ad notifyForCoin: coin value: value];
        }
	}
}



@end
