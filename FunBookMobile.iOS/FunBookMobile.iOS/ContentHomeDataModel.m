//
//  ContentHomeDataModel.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/2/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "ContentHomeDataModel.h"

@implementation ContentHomeDataModel
-(instancetype) initWithUsersCount: (NSInteger) usersCount
                        jokesCount: (NSInteger) jokesCount
                        linksCount: (NSInteger) linksCount
                     picturesCount: (NSInteger) picturesCount
                          lastJoke: (ContentOverviewDataModel*) lastJoke
                          lastLink: (ContentOverviewDataModel*) lastLink
                       lastPicture: (ContentOverviewDataModel*) lastPicture
                          bestJoke: (ContentOverviewDataModel*) bestJoke
                          bestLink: (ContentOverviewDataModel*) bestLink
                       bestPicture: (ContentOverviewDataModel*) bestPicture {
    if (self = [super init]) {
        self.usersCount = usersCount;
        self.jokesCount = jokesCount;
        self.linksCount = linksCount;
        self.picturesCount = picturesCount;
        self.lastJoke = lastJoke;
        self.lastLink = lastLink;
        self.lastPicture = lastPicture;
        self.bestJoke = bestJoke;
        self.bestLink = bestLink;
        self.bestPicture = bestPicture;
    }
    return self;
}

+(ContentHomeDataModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary {
    NSDictionary* test = [jsonDictionary objectForKey:@"LastJoke"];
    return [[ContentHomeDataModel alloc]
initWithUsersCount:[[jsonDictionary objectForKey:@"UsersCount"] integerValue]
jokesCount:[[jsonDictionary objectForKey:@"JokesCount"] integerValue]
linksCount:[[jsonDictionary objectForKey:@"LinksCount"] integerValue]
picturesCount:[[jsonDictionary objectForKey:@"PicturesCount"] integerValue]
lastJoke:[ContentOverviewDataModel fromJsonDictionary:
          [jsonDictionary objectForKey:@"LastJoke"]]
lastLink:[ContentOverviewDataModel fromJsonDictionary:
          [jsonDictionary objectForKey:@"LastLink"]]
lastPicture:[ContentOverviewDataModel fromJsonDictionary:
             [jsonDictionary objectForKey:@"LastPicture"]]
bestJoke:[ContentOverviewDataModel fromJsonDictionary:
          [jsonDictionary objectForKey:@"BestJoke"]]
bestLink:[ContentOverviewDataModel fromJsonDictionary:
          [jsonDictionary objectForKey:@"BestLink"]]
bestPicture:[ContentOverviewDataModel fromJsonDictionary:
             [jsonDictionary objectForKey:@"BestPicture"]]];
}
@end
