//
//  ContentOverviewDataModel.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentOverviewDataModel : NSObject

@property (strong, nonatomic) NSString* objId;
@property (strong, nonatomic) NSString* title;
@property NSInteger views;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSString* date;

-(instancetype) initWithId:(NSString*)objId title:(NSString*)title views:
(NSInteger)views content:(NSString*)content andDate:(NSString*)date;

+(ContentOverviewDataModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;
@end