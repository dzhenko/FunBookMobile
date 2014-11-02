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
@property (strong, nonatomic) NSString* data; //to be changed
@property (strong, nonatomic) NSString* title; // min len 3
@property BOOL isAnonymous;
@property (strong, nonatomic) NSString* category;

-(instancetype) initWithData:(NSString*)data
                        title:(NSString*)title
                     isAnonymous:(BOOL)isAnonymous
                 andCategory:(NSString*)category;

+(PictureNewDataModel*) pictureWithData:(NSString*)data
                                  title:(NSString*)title
                            isAnonymous:(BOOL)isAnonymous
                            andCategory:(NSString*)category;
@end
