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
// account
-(void) loginUserWithEmail: (NSString*) email andPassword: (NSString*) password
    AndPerformBlock:(void (^)(BOOL success))blockToPerform;
-(void) registerUserWithEmail: (NSString*) email andPassword: (NSString*) password
       AndPerformBlock:(void (^)(BOOL success))blockToPerform;
-(void) logoutAndPerformBlock:(void (^)(BOOL success))blockToPerform;

-(BOOL) isUserLoggedIn;
-(NSString*) getUserName;

// content
-(void) getCategoriesAllAndPerformSuccessBlock:(void (^)(NSArray* categories))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) getContentHomeAndPerformSuccessBlock:(void (^)(ContentHomeDataModel* model))successActionBlock
                     orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) getContentAllAtPage:(NSInteger) page
     AndPerformSuccessBlock:(void (^)(NSArray* models))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) getJokesAllAtPage:(NSInteger) page
     AndPerformSuccessBlock:(void (^)(NSArray* models))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) getLinksAllAtPage:(NSInteger) page
     AndPerformSuccessBlock:(void (^)(NSArray* models))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) getPicturesAllAtPage:(NSInteger) page
     AndPerformSuccessBlock:(void (^)(NSArray* models))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) getContentFindWithText:(NSString*) text AtPage:(NSInteger) page
     AndPerformSuccessBlock:(void (^)(NSArray* models))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;
@end
