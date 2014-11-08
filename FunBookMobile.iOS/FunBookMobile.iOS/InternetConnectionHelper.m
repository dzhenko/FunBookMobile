//
//  InternetConnectionHelper.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/8/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "InternetConnectionHelper.h"

@implementation InternetConnectionHelper

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(NSString *)getConnectionSatus{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        return @"Not connected";
    } else {
        return @"Connected";
    }
}

@end
