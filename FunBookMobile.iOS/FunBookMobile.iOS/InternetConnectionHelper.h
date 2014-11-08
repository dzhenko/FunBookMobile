//
//  InternetConnectionHelper.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/8/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface InternetConnectionHelper : NSObject

-(NSString *)getConnectionSatus;

@end
