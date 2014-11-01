//
//  ContentHomeDataModel.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/2/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentOverviewDataModel.h"

@interface ContentHomeDataModel : NSObject
@property NSInteger usersCount;
@property NSInteger jokesCount;
@property NSInteger linksCount;
@property NSInteger picturesCount;
@property (strong, nonatomic) ContentOverviewDataModel* lastJoke;
@property (strong, nonatomic) ContentOverviewDataModel* lastLink;
@property (strong, nonatomic) ContentOverviewDataModel* lastPicture;
@property (strong, nonatomic) ContentOverviewDataModel* bestJoke;
@property (strong, nonatomic) ContentOverviewDataModel* bestLink;
@property (strong, nonatomic) ContentOverviewDataModel* bestPicture;

-(instancetype) initWithUsersCount: (NSInteger) usersCount
                        jokesCount: (NSInteger) jokesCount
                        linksCount: (NSInteger) linksCount
                     picturesCount: (NSInteger) picturesCount
                          lastJoke: (ContentOverviewDataModel*) lastJoke
                          lastLink: (ContentOverviewDataModel*) lastLink
                       lastPicture: (ContentOverviewDataModel*) lastPicture
                          bestJoke: (ContentOverviewDataModel*) bestJoke
                          bestLink: (ContentOverviewDataModel*) bestLink
                       bestPicture: (ContentOverviewDataModel*) bestPicture;

+(ContentHomeDataModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;
@end
