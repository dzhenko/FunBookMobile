//
//  JokeDetailsDataModel.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "JokeDetailsDataModel.h"
#import "CommentDataModel.h"

@implementation JokeDetailsDataModel
-(instancetype)initWithId:(NSString *)objId text:(NSString *)text title:(NSString *)title created:(NSString *)created creator:(NSString *)creator likes:(NSInteger)likes hates:(NSInteger)hates views:(NSInteger)views andComments:(NSArray *)comments{
    if (self = [super init]){
        self.objId = objId;
        self.text = text;
        self.title = title;
        self.created = created;
        self.creator = creator;
        self.likes = likes;
        self.hates = hates;
        self.views = views;
        self.comments = comments;
    }
    return self;
}

+(JokeDetailsDataModel*) fromJsonDictionary:(NSDictionary *)jsonDictionary{
    return [[JokeDetailsDataModel alloc]
initWithId:[jsonDictionary objectForKey:@"Id"]
text:[jsonDictionary objectForKey:@"Text"]
title:[jsonDictionary objectForKey:@"Title"]
created:[jsonDictionary objectForKey:@"Created"]
creator:[jsonDictionary objectForKey:@"Creator"]
likes:[[jsonDictionary objectForKey:@"Likes"] integerValue]
hates:[[jsonDictionary objectForKey:@"Hates"] integerValue]
views:[[jsonDictionary objectForKey:@"Views"] integerValue]
andComments:[CommentDataModel arrayOfCommentsFromJsonDictionary:[jsonDictionary objectForKey:@"Comments"]]];
}
@end
