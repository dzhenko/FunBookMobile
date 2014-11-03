//
//  AppData.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/2/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "AppData.h"
#import "HttpRequester.h"

@implementation AppData{
    HttpRequester *requester;
    NSString *authorizationToken;
    NSString *username;
    
    void (^successBlock)(id);
    void (^errorBlock)(id);
}

//class privates

-(instancetype) init {
    if (self = [super init]) {
        requester = [HttpRequester requesterWithBaseUrl:@"http://funbook.apphb.com/api/"];
        authorizationToken = nil;
    }
    return self;
}

-(void)setSuccessCallbackBlock: (void (^)(id data))successActionBlock
         andErrorCallBackBlock:(void (^)(NSError* error))errorActionBlock{
    successBlock = successActionBlock;
    errorBlock = errorActionBlock;
}

-(void)connection:(NSURLRequest*) request didReceiveData:(NSData *)data{
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if([[json objectForKey:@"Message"] isEqualToString:@"The request is invalid."]) {
        if (errorBlock) {
            errorBlock(json);
        }
        return;
    }
    if([[json objectForKey:@"Message"] isEqualToString:@"Authorization has been denied for this request."]) {
        if (errorBlock) {
            errorBlock(json);
        }
        return;
    }
    
    if (successBlock) {
        // we dont know if all data comes as JSON with single key "Result" /although we created the REST api :)/
        id jsonResultObject = [json objectForKey:@"Result"];
        if (jsonResultObject){
            successBlock(jsonResultObject);
        }
        else{
            successBlock(json);
        }
    }
}

-(void)connection:(NSURLRequest*) request didFailWithError:(NSError *)error{
    if(errorBlock) {
        errorBlock(error);
    }
}

// account

-(void) loginUserWithEmail: (NSString*) email andPassword: (NSString*) password
           AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    NSString *postString = [NSString stringWithFormat:@"Username=%@&Password=%@&Grant_Type=password",email,password];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [self setSuccessCallbackBlock:^(id data) {
        authorizationToken = [NSString stringWithFormat:@"%@ %@", @"bearer", [(NSDictionary*)data objectForKey:@"access_token"]];
        username = [(NSDictionary*)data objectForKey:@"userName"];
        if(blockToPerform){
            blockToPerform(YES);
        }
    } andErrorCallBackBlock:^(NSError *error) {
        if(blockToPerform){
            blockToPerform(NO);
        }
    }];
    
    [requester post:@"account/login" data:postData
            headers:[NSDictionary dictionaryWithObjectsAndKeys:
                     @"Content-Type", @"application/x-www-form-urlencoded", nil] withTarget:self];
}

-(void) registerUserWithEmail: (NSString*) email andPassword: (NSString*) password
              AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    NSString *postString = [NSString stringWithFormat:@"Email=%@&Password=%@&ConfirmPassword=%@",email,password,password];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [self setSuccessCallbackBlock:^(id data) {
        if(blockToPerform){
            blockToPerform(YES);
        }
    } andErrorCallBackBlock:^(NSError *error) {
        if(blockToPerform){
            blockToPerform(NO);
        }
    }];
    
    [requester post:@"account/register" data:postData
            headers:[NSDictionary dictionaryWithObjectsAndKeys:
                     @"Content-Type", @"application/x-www-form-urlencoded", nil] withTarget:self];
}

-(void) logoutAndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self setSuccessCallbackBlock:^(id data) {
        authorizationToken = nil;
        username = nil;
        if (blockToPerform) {
            blockToPerform(YES);
        }
    } andErrorCallBackBlock:^(NSError *error) {
        if (blockToPerform) {
            blockToPerform(NO);
        }
    }];
    
    [requester post:@"account/logout" data:nil
            headers:[NSDictionary dictionaryWithObjectsAndKeys:
                     @"Authorization", authorizationToken, nil] withTarget:self];

}

-(NSString*) getUserName {
    return username;
}

-(BOOL) isUserLoggedIn {
    return authorizationToken != nil;
}


// content

-(void)getCategoriesAllAndPerformSuccessBlock:(void (^)(NSArray * categories))successActionBlock orReactToErrorWithBlock:(void (^)(NSError *))errorActionBlock {
    [self setSuccessCallbackBlock:^(id data) {
        NSArray* resultArray = (NSArray*)data;
        if (successActionBlock){
            successActionBlock(resultArray);
        }
    } andErrorCallBackBlock:errorActionBlock];
    
    [requester get:@"content/categories" headers:nil withTarget:self];
}

-(void) getContentHomeAndPerformSuccessBlock:(void (^)(ContentHomeDataModel* model))successActionBlock
                     orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self setSuccessCallbackBlock:^(id data) {
        ContentHomeDataModel* model = [ContentHomeDataModel fromJsonDictionary:data];
        if (successActionBlock){
            successActionBlock(model);
        }
    } andErrorCallBackBlock:errorActionBlock];
    
    [requester get:@"content/home" headers:nil withTarget:self];
}

//private method used by all/find/jokes/links/pictures
-(void)privateGetContentAtUrl:(NSString*)url AndPerformSuccessBlock:(void (^)(NSArray * models))successActionBlock orReactToErrorWithBlock:(void (^)(NSError *))errorActionBlock{
    [self setSuccessCallbackBlock:^(id data) {
        NSArray *recievedArray = (NSArray*)data;
        NSMutableArray* castedArray = [NSMutableArray array];
        for (NSInteger i = 0; i < recievedArray.count; i++) {
            [castedArray addObject:[ContentOverviewDataModel fromJsonDictionary:recievedArray[i]]];
        }
        
        if (successActionBlock) {
            successActionBlock([NSArray arrayWithArray:castedArray]);
        }
    } andErrorCallBackBlock:errorActionBlock];
    
    [requester get:url headers:nil withTarget:self];
}

-(void)getContentAllAtPage:(NSInteger)page AndPerformSuccessBlock:(void (^)(NSArray * models))successActionBlock orReactToErrorWithBlock:(void (^)(NSError *))errorActionBlock{
    [self privateGetContentAtUrl:[NSString stringWithFormat:@"content/all?page=%li",(long)page]
          AndPerformSuccessBlock:successActionBlock
         orReactToErrorWithBlock:errorActionBlock];
}

-(void) getJokesAllAtPage:(NSInteger) page
   AndPerformSuccessBlock:(void (^)(NSArray* models))successActionBlock
  orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self privateGetContentAtUrl:[NSString stringWithFormat:@"content/jokes?page=%li",(long)page]
          AndPerformSuccessBlock:successActionBlock
         orReactToErrorWithBlock:errorActionBlock];
}

-(void) getLinksAllAtPage:(NSInteger) page
   AndPerformSuccessBlock:(void (^)(NSArray* models))successActionBlock
  orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self privateGetContentAtUrl:[NSString stringWithFormat:@"content/links?page=%li",(long)page]
          AndPerformSuccessBlock:successActionBlock
         orReactToErrorWithBlock:errorActionBlock];
}

-(void) getPicturesAllAtPage:(NSInteger) page
      AndPerformSuccessBlock:(void (^)(NSArray* models))successActionBlock
     orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self privateGetContentAtUrl:[NSString stringWithFormat:@"content/pictures?page=%li",(long)page]
          AndPerformSuccessBlock:successActionBlock
         orReactToErrorWithBlock:errorActionBlock];
}

-(void)getContentFindWithText:(NSString *)text AtPage:(NSInteger)page AndPerformSuccessBlock:(void (^)(NSArray *))successActionBlock orReactToErrorWithBlock:(void (^)(NSError *))errorActionBlock{
    [self privateGetContentAtUrl:[NSString stringWithFormat:@"content/find?text=%@&page=%li", text ,(long)page]
          AndPerformSuccessBlock:successActionBlock
         orReactToErrorWithBlock:errorActionBlock];
}

//private method used to comment stuff
-(void) privateCommentItemAtUrl:(NSString*)url WithId:(NSString*) objId commentText:(NSString*) text
         AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self setSuccessCallbackBlock:^(id data) {
        if (blockToPerform) {
            blockToPerform(YES);
        }
    } andErrorCallBackBlock:^(NSError *error) {
        if (blockToPerform) {
            blockToPerform(NO);
        }
    }];
    
    NSDictionary* postDataAsDict = @{@"Id":objId,
                                     @"Text":text};
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [requester post:url data:postData headers:nil withTarget:self];

}
//private method used to hate/like stuff
-(void) privateLikeOrHateItemAtUrl:(NSString*) url
              AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self setSuccessCallbackBlock:^(id data) {
        if (blockToPerform) {
            blockToPerform(YES);
        }
    } andErrorCallBackBlock:^(NSError *error) {
        if (blockToPerform) {
            blockToPerform(NO);
        }
    }];
    
    [requester get:url headers:nil withTarget:self];
}

// jokes
-(void) createJoke:(JokeNewDataModel*)model
        AndPerformSuccessBlock:(void (^)(NSString* createdObjId))successActionBlock
        orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self setSuccessCallbackBlock:successActionBlock andErrorCallBackBlock:errorBlock];
    
    NSDictionary* postDataAsDict = @{@"Text":model.text,
                                     @"Title":model.title,
                                     @"IsAnonymous":model.isAnonymous ? @"true" : @"false",
                                     @"Category":model.category};
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [requester post:@"jokes/create" data:postData headers:nil withTarget:self];
}

-(void) getJokeDetailsForId:(NSString*) objId
     AndPerformSuccessBlock:(void (^)(JokeDetailsDataModel* model))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self setSuccessCallbackBlock:^(id data) {
        JokeDetailsDataModel* model = [JokeDetailsDataModel fromJsonDictionary:data];
        if (successActionBlock){
            successActionBlock(model);
        }
    } andErrorCallBackBlock:errorActionBlock];
    
    [requester get:[NSString stringWithFormat:@"%@%@", @"jokes/details/", objId] headers:nil withTarget:self];
}

-(void) commentJokeWithId:(NSString*) objId commentText:(NSString*) text
          AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self privateCommentItemAtUrl:@"jokes/comment" WithId:objId commentText:text
                  AndPerformBlock:blockToPerform];
}

-(void) likeJokeWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self privateLikeOrHateItemAtUrl:[NSString stringWithFormat:@"%@%@", @"jokes/like/",objId]
                     AndPerformBlock:blockToPerform];
}

-(void) hateJokeWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self privateLikeOrHateItemAtUrl:[NSString stringWithFormat:@"%@%@", @"jokes/hate/",objId]
                     AndPerformBlock:blockToPerform];
}
// links
-(void) createLink:(LinkNewDataModel*)model
AndPerformSuccessBlock:(void (^)(NSString* createdObjId))successActionBlock
orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self setSuccessCallbackBlock:successActionBlock andErrorCallBackBlock:errorBlock];
    
    NSDictionary* postDataAsDict = @{@"URL":model.url,
                                     @"Title":model.title,
                                     @"IsAnonymous":model.isAnonymous ? @"true" : @"false",
                                     @"Category":model.category};
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [requester post:@"links/create" data:postData headers:nil withTarget:self];

}

-(void) getLinkDetailsForId:(NSString*) objId
     AndPerformSuccessBlock:(void (^)(LinkDetailsDataModel* model))successActionBlock
    orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self setSuccessCallbackBlock:^(id data) {
        LinkDetailsDataModel* model = [LinkDetailsDataModel fromJsonDictionary:data];
        if (successActionBlock){
            successActionBlock(model);
        }
    } andErrorCallBackBlock:errorActionBlock];
    
    [requester get:[NSString stringWithFormat:@"%@%@", @"links/details/", objId] headers:nil withTarget:self];
}

-(void) commentLinkWithId:(NSString*) objId commentText:(NSString*) text
          AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self privateCommentItemAtUrl:@"links/comment" WithId:objId commentText:text
                  AndPerformBlock:blockToPerform];
}

-(void) likeLinkWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self privateLikeOrHateItemAtUrl:[NSString stringWithFormat:@"%@%@", @"links/like/",objId]
                     AndPerformBlock:blockToPerform];
}

-(void) hateLinkWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self privateLikeOrHateItemAtUrl:[NSString stringWithFormat:@"%@%@", @"links/hate/",objId]
                     AndPerformBlock:blockToPerform];
}
// pictures
-(void) createPicture:(PictureNewDataModel*)model
AndPerformSuccessBlock:(void (^)(NSString* createdObjId))successActionBlock
orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self setSuccessCallbackBlock:successActionBlock andErrorCallBackBlock:errorBlock];
    
    NSDictionary* postDataAsDict = @{@"Data":model.data,
                                     @"Title":model.title,
                                     @"IsAnonymous":model.isAnonymous ? @"true" : @"false",
                                     @"Category":model.category};
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [requester post:@"pictures/create" data:postData headers:nil withTarget:self];
}

-(void) getPictureDetailsForId:(NSString*) objId
        AndPerformSuccessBlock:(void (^)(PictureDetailsDataModel* model))successActionBlock
       orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self setSuccessCallbackBlock:^(id data) {
        PictureDetailsDataModel* model = [PictureDetailsDataModel fromJsonDictionary:data];
        if (successActionBlock){
            successActionBlock(model);
        }
    } andErrorCallBackBlock:errorActionBlock];
    
    [requester get:[NSString stringWithFormat:@"%@%@", @"pictures/details/", objId] headers:nil withTarget:self];
}

-(void) commentPictureWithId:(NSString*) objId commentText:(NSString*) text
             AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self privateCommentItemAtUrl:@"pictures/comment" WithId:objId commentText:text
                  AndPerformBlock:blockToPerform];
}

-(void) likePictureWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self privateLikeOrHateItemAtUrl:[NSString stringWithFormat:@"%@%@", @"pictures/like/",objId]
                     AndPerformBlock:blockToPerform];
}

-(void) hatePictureWithId:(NSString*) objId AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    [self privateLikeOrHateItemAtUrl:[NSString stringWithFormat:@"%@%@", @"pictures/hate/",objId]
                     AndPerformBlock:blockToPerform];
}
@end
