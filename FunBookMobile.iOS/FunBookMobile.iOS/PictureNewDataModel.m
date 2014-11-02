//
//  PictureNewDataModel.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "PictureNewDataModel.h"

@implementation PictureNewDataModel
-(instancetype)initWithData:(NSString *)data title:(NSString *)title isAnonymous:(BOOL)isAnonymous andCategory:(NSString *)category{
    if (self = [super init]){
        self.data = data;
        self.title = title;
        self.isAnonymous = isAnonymous;
        self.category = category;
    }
    return self;
}

+(PictureNewDataModel*) pictureWithData:(NSString*)data
                                  title:(NSString*)title
                            isAnonymous:(BOOL)isAnonymous
                            andCategory:(NSString*)category{
    return [[PictureNewDataModel alloc] initWithData:data title:title isAnonymous:isAnonymous andCategory:category];
}
@end
