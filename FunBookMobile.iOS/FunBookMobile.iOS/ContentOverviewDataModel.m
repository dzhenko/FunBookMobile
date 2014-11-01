//
//  ContentOverviewDataModel.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "ContentOverviewDataModel.h"

@implementation ContentOverviewDataModel

-(instancetype) initWithId:(NSString*)objId title:(NSString*)title views:
                (NSInteger)views content:(NSString*)content andDate:(NSDate*)date {
    if (self = [super init]) {
        self.objId = objId;
        self.title = title;
        self.views = views;
        self.content = content;
        self.date = date;
    }
    return self;
}

+(ContentOverviewDataModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary {
    return [[ContentOverviewDataModel alloc]
            initWithId:[[jsonDictionary objectForKey:@"Id"] stringValue]
                title:[[jsonDictionary objectForKey:@"Title"] stringValue]
                views:[[jsonDictionary objectForKey:@"Views"] integerValue]
                content:[[jsonDictionary objectForKey:@"Content"] stringValue]
                andDate:[[[NSDateFormatter alloc] init] dateFromString:[[jsonDictionary objectForKey:@"Date"] stringValue]]];
}

@end
