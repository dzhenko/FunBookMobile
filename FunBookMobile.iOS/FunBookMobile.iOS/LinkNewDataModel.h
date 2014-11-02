//
//  LinkNewDataModel.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkNewDataModel : NSObject
@property (strong, nonatomic) NSString* url; // min len 3
@property (strong, nonatomic) NSString* title; // min len 3
@property BOOL isAnonymous;
@property (strong, nonatomic) NSString* category;

-(instancetype) initWithUrl:(NSString*)url
                       title:(NSString*)title
                 isAnonymous:(BOOL)isAnonymous
                 andCategory:(NSString*)category;

+(LinkNewDataModel*) linkWithUrl:(NSString*)url
                           title:(NSString*)title
                     isAnonymous:(BOOL)isAnonymous
                     andCategory:(NSString*)category;
@end
