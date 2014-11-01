//
//  HttpRequester.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//
#import "HttpRequester.h"

@implementation HttpRequester

-(void) createRequest: (NSString*) method atUrl: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target action:(void (^)(id result))callback {
    
    NSMutableURLRequest* request =
        [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:method];

    if (headers) {
        for(id key in headers) {
            [request setValue:[headers objectForKey:key] forKey:key];
        }
    }
    
    else {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    
    if (data) {
        [request setHTTPBody:data];
    }
    
    [NSURLConnection connectionWithRequest:request delegate: target];
    
    // ...
    return;
    id result = @"";
    if (callback) {
        callback(result);
    }
}



-(void) get: (NSString*) url headers: (NSDictionary*) headers withTarget: (NSObject*) target

     action:(void (^)(id result))callback {
    
    [self createRequest:@"GET" atUrl:url data:nil headers:headers withTarget:target action:callback];
}



-(void) post: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target action:(void (^)(id result))callback {
    
    [self createRequest:@"POST" atUrl:url data:data headers:headers withTarget:target action:callback];
}


-(void) put: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target action:(void (^)(id result))callback {
    
    [self createRequest:@"PUT" atUrl:url data:data headers:headers withTarget:target action:callback];
}


-(void) delete: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target action:(void (^)(id result))callback {
    
    [self createRequest:@"DELETE" atUrl:url data:data headers:headers withTarget:target action:callback];
    
}

@end

