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
    NSString *baseUrl;
    void (^successBlock)(id);
    void (^errorBlock)(id);
}

-(instancetype) init {
    if (self = [super init]) {
        requester = [[HttpRequester alloc] init];
        baseUrl = @"http://funbook.apphb.com/";
    }
    return self;
}

-(void)setSuccessCallbackBlock: (void (^)(id))successActionBlock
         andErrorCallBackBlock:(void (^)(NSError*))errorActionBlock{
    successBlock = successActionBlock;
    errorBlock = errorActionBlock;
}

-(void)connection:(NSURLRequest*) request didReceiveData:(NSData *)data{
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if (successBlock) {
        // we know that all data comes as JSON with single key "Result" /because we created the REST api :)/
        successBlock([json objectForKey:@"Result"]);
    }
}

-(void)connection:(NSURLRequest*) request didFailWithError:(NSError *)error{
    if(errorBlock) {
        errorBlock(error);
    }
}

-(void) getHomeContentAndPerformSuccessBlock:(void (^)(id))successActionBlock
                     orReactToErrorWithBlock:(void (^)(NSError*))errorActionBlock{
    [self setSuccessCallbackBlock:successActionBlock andErrorCallBackBlock:errorActionBlock];
    
    [requester get:@"http://funbook.apphb.com/api/content/home"
           headers:nil withTarget:self];
}

@end
