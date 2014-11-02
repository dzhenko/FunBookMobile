//
//  CommentDataModel.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "CommentDataModel.h"

@implementation CommentDataModel
-(instancetype) initWithUser:(NSString*)user
                        text:(NSString*)text
                     created:(NSString*)created {
    if (self=[super init]) {
        self.user = user;
        self.text = text;
        self.created = created;
    }
    return self;
}

+(CommentDataModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary {
    return [[CommentDataModel alloc] initWithUser:[jsonDictionary objectForKey:@"User"]
                                            text:[jsonDictionary objectForKey:@"Text"]
                                          created:[jsonDictionary objectForKey:@"Created"]];
}

+(NSArray*) arrayOfCommentsFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[CommentDataModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}
@end
