//
//  appData.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "appData.h"
#import "HttpRequester.h"

@implementation appData{
    HttpRequester *requester;
}

-(instancetype) init {
    if (self = [super init]) {
        requester = [[HttpRequester alloc] init];
    }
    return self;
}



@end
