//
//  LinkNewDataModel.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "LinkNewDataModel.h"

@implementation LinkNewDataModel
-(instancetype)initWithUrl:(NSString *)url title:(NSString *)title isAnonymous:(BOOL)isAnonymous andCategory:(NSString *)category{
    if (self = [super init]){
        self.url = url;
        self.title = title;
        self.isAnonymous = isAnonymous;
        self.category = category;
    }
    return self;
}

+(LinkNewDataModel*) linkWithUrl:(NSString*)url
                           title:(NSString*)title
                     isAnonymous:(BOOL)isAnonymous
                     andCategory:(NSString*)category{
    return [[LinkNewDataModel alloc] initWithUrl:url title:title isAnonymous:isAnonymous andCategory:category];
}

@end
