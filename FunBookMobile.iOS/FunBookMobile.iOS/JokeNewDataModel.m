//
//  JokeNewDataModel.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "JokeNewDataModel.h"

@implementation JokeNewDataModel
-(instancetype)initWithText:(NSString *)text title:(NSString *)title isAnonymous:(BOOL)isAnonymous andCategory:(NSString *)category{
    if (self = [super init]){
        self.text = text;
        self.title = title;
        self.isAnonymous = isAnonymous;
        self.category = category;
    }
    return self;
}

+(JokeNewDataModel*) jokeWithText:(NSString*)text
                            title:(NSString*)title
                      isAnonymous:(BOOL)isAnonymous
                      andCategory:(NSString*)category{
    return [[JokeNewDataModel alloc] initWithText:text title:title isAnonymous:isAnonymous andCategory:category];
}

@end
