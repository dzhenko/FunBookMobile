//
//  PictureNewDataModel.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureNewDataModel : NSObject
// some property holding the data ???
@property (strong, nonatomic) NSString* title; // min len 3
@property BOOL IsAnonymous;
@property (strong, nonatomic) NSString* category;
@end
