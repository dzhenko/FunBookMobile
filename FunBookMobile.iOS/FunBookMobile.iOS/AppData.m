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

-(void)connection:(NSURLRequest*) request didReceiveResponse:(NSURLResponse *)response {
    NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
    if (statusCode / 100 == 2 && successBlock) {
        successBlock(@"Successful registration");
    }
    else if(errorBlock) {
        errorBlock(@"No response from server");
    }
}

-(void)connection:(NSURLRequest*) request didReceiveData:(NSData *)data{
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if([[json objectForKey:@"Message"] isEqualToString:@"The request is invalid."]) {
        errorBlock(json);
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
    
}
-(void) registerUserWithEmail: (NSString*) email andPassword: (NSString*) password
              AndPerformBlock:(void (^)(BOOL success))blockToPerform{
    NSString *postString = [NSString stringWithFormat:@"Email=%@&Password=%@&ConfirmPassword=%@",email,password,password];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [self setSuccessCallbackBlock:^(id data) {
        NSLog(@"%@", data);
        if(blockToPerform){
            blockToPerform(YES);
        }
    } andErrorCallBackBlock:^(NSError *error) {
        NSLog(@"%@", error);
        if(blockToPerform){
            blockToPerform(NO);
        }
    }];
    
    [requester post:@"account/register" data:postData
            headers:[NSDictionary dictionaryWithObjectsAndKeys:
                     @"Content-Type", @"application/x-www-form-urlencoded", nil] withTarget:self];
}
-(void) logoutAndPerformBlock:(void (^)(BOOL success))blockToPerform{
    
}

-(NSString*) getUserName {
    return username;
}

-(BOOL) isUserLoggedIn {
    return authorizationToken != nil;
}


// content

-(void) getHomeContentAndPerformSuccessBlock:(void (^)(id data))successActionBlock
                     orReactToErrorWithBlock:(void (^)(NSError* error))errorActionBlock{
    [self setSuccessCallbackBlock:successActionBlock andErrorCallBackBlock:errorActionBlock];
    
    [requester get:@"content/home" headers:nil withTarget:self];
}

@end
