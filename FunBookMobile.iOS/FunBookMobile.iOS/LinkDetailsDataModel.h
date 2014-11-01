//
//  LinkDetailsDataModel.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkDetailsDataModel : NSObject
@property (strong, nonatomic) NSString* objId;
@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSDate* created;
@property (strong, nonatomic) NSString* creator;
@property NSInteger likes;
@property NSInteger hates;
@property NSInteger views;

// following commentDataModel
@property (strong, nonatomic) NSArray* comments;

@end
