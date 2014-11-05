//
//  AppData.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/2/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ContentHomeDataModel.h"

#import "JokeDetailsDataModel.h"
#import "JokeNewDataModel.h"

#import "LinkDetailsDataModel.h"
#import "LinkNewDataModel.h"

#import "PictureDetailsDataModel.h"
#import "PictureNewDataModel.h"

@interface AppData : NSObject
// account
-(void) loginUserWithEmail: (NSString*) email andPassword: (NSString*) password
    AndPerformBlock:(void (^)(BOOL success))blockToPerform;
-(void) registerUserWithEmail: (NSString*) email andPassword: (NSString*) password
       AndPerformBlock:(void (^)(BOOL success))blockToPerform;
-(void) logoutAndPerformBlock:(void (^)(BOOL success))blockToPerform;

-(BOOL) isUserLoggedIn;
@property (strong, nonatomic) NSString* authorizationToken;
@property (strong, nonatomic) NSString* loggedUserName;

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


// jokes
-(void) createJoke:(JokeNewDataModel*)model
    AndPerformSuccessBlock:(void (^)(NSString* createdObjId))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) getJokeDetailsForId:(NSString*) objId
    AndPerformSuccessBlock:(void (^)(JokeDetailsDataModel* model))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) commentJokeWithId:(NSString*) objId commentText:(NSString*) text
          AndPerformBlock:(void (^)(BOOL success))blockToPerform;

-(void) likeJokeWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform;

-(void) hateJokeWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform;

// links
-(void) createLink:(LinkNewDataModel*)model
AndPerformSuccessBlock:(void (^)(NSString* createdObjId))successActionBlock
orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) getLinkDetailsForId:(NSString*) objId
     AndPerformSuccessBlock:(void (^)(LinkDetailsDataModel* model))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) commentLinkWithId:(NSString*) objId commentText:(NSString*) text
          AndPerformBlock:(void (^)(BOOL success))blockToPerform;

-(void) likeLinkWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform;

-(void) hateLinkWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform;

// pictures
-(void) createPicture:(PictureNewDataModel*)model
AndPerformSuccessBlock:(void (^)(NSString* createdObjId))successActionBlock
orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) getPictureDetailsForId:(NSString*) objId
     AndPerformSuccessBlock:(void (^)(PictureDetailsDataModel* model))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock;

-(void) commentPictureWithId:(NSString*) objId commentText:(NSString*) text
          AndPerformBlock:(void (^)(BOOL success))blockToPerform;

-(void) likePictureWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform;

-(void) hatePictureWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform;
@end
