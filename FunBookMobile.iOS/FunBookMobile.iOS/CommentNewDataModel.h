//
//  CommentNewDataModel.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentNewDataModel : NSObject

@property (strong, nonatomic) NSString* objId;
@property (strong, nonatomic) NSString* text; // min len 3

-(instancetype) initWithId:(NSString*)objId andText:(NSString*)text;

+(CommentNewDataModel*) commentForId:(NSString*)objId andText:(NSString*)text;

@end
