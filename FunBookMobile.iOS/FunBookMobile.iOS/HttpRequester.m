//
//  HttpRequester.m
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "HttpRequester.h"

@implementation HttpRequester

-(void)createRequest: (NSString*) method atUrl: (NSString*) url data: (NSData*)
         data headers: (NSDictionary*) headers withTarget: (NSObject*) target {
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
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
}

-(void) get: (NSString*) url headers: (NSDictionary*) headers withTarget: (NSObject*) target {
    [self createRequest:@"GET" atUrl:url data:nil headers:headers withTarget:target];
}

-(void) post: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target {
    [self createRequest:@"POST" atUrl:url data:data headers:headers withTarget:target];
}

-(void) put: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target  {
    [self createRequest:@"PUT" atUrl:url data:data headers:headers withTarget:target];
}

-(void) delete: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target {
    [self createRequest:@"DELETE" atUrl:url data:data headers:headers withTarget:target];
}

@end

