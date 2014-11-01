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
                (NSInteger)views content:(NSString*)content andDate:(NSString*)date {
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
            initWithId:[jsonDictionary objectForKey:@"Id"]
                title:[jsonDictionary objectForKey:@"Title"]
                views:[[jsonDictionary objectForKey:@"Views"] integerValue]
                content:[jsonDictionary objectForKey:@"Content"]
                andDate:[jsonDictionary objectForKey:@"Date"]];
}

@end
