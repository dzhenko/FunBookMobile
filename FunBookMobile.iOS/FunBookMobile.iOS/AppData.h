//
//  AppData.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/2/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ContentHomeDataModel.h"

@interface AppData : NSObject
-(void) loginUserWithEmail: (NSString*) email andPassword: (NSString*) password
    AndPerformBlock:(void (^)(BOOL success))blockToPerform;
-(void) registerUserWithEmail: (NSString*) email andPassword: (NSString*) password
       AndPerformBlock:(void (^)(BOOL success))blockToPerform;
-(void) logoutAndPerformBlock:(void (^)(BOOL success))blockToPerform;

-(BOOL) isUserLoggedIn;
-(NSString*) getUserName;

-(void) getHomeContentAndPerformSuccessBlock:(void (^)(id data))successActionBlock
                     orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;
@end
