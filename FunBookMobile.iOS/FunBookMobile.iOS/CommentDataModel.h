//
//  CommentDataModel.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentDataModel : NSObject

@property (strong, nonatomic) NSString* user;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSString* created;

-(instancetype) initWithUser:(NSString*)user
                       text:(NSString*)text
                       created:(NSString*)created;

+(CommentDataModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;

+(NSArray*) arrayOfCommentsFromJsonDictionary: (NSArray*) jsonArray;
@end