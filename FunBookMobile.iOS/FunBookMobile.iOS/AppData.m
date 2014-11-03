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

// jokes

// links

// pictures

@end
