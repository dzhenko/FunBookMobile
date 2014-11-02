//
//  CommentNewDataModel.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "CommentNewDataModel.h"

@implementation CommentNewDataModel
-(instancetype)initWithId:(NSString *)objId andText:(NSString *)text{
    if (self = [super init]) {
        self.objId = objId;
        self.text = text;
    }
    return self;
}

+(CommentNewDataModel*) commentForId:(NSString*)objId andText:(NSString*)text{
    return [[CommentNewDataModel alloc] initWithId:objId andText:text];
}
@end
