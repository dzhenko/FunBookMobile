//
//  PictureDetailsDataModel.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureDetailsDataModel : NSObject

@property (strong, nonatomic) NSString* objId;
@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* created;
@property (strong, nonatomic) NSString* creator;
@property NSInteger likes;
@property NSInteger hates;
@property NSInteger views;

// following commentDataModel
@property (strong, nonatomic) NSArray* comments;

-(instancetype) initWithId:(NSString*)objId
                       url:(NSString*)url
                     title:(NSString*)title
                   created:(NSString*)created
                   creator:(NSString*)creator
                     likes:(NSInteger)likes
                     hates:(NSInteger)hates
                     views:(NSInteger)views
               andComments:(NSArray*)comments;

+(PictureDetailsDataModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;
@end
