//
//  DateFormater.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/2/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "DateFormater.h"

@implementation DateFormater

static NSDateFormatter* formatter;

+ (void) initialize {
    if (self == [NSObject class]) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-DDTHH:mm"];
    }
    // Initialization for this class and any subclasses
}

+(NSDate*) fromString:(NSString*) string {
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-DD HH:mm:SS.sss"];
    }
    NSDate* date =[formatter dateFromString:string];
    return date;
}

@end
