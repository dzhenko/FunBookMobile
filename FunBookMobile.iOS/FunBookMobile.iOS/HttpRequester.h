//
//  HttpRequester.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequester : NSObject
-(instancetype) initWithBaseUrl: (NSString*)baseUrl;

+(HttpRequester*) requesterWithBaseUrl:(NSString*) baseUrl;

-(void) get: (NSString*) url headers: (NSDictionary*) headers withTarget: (NSObject*) target
andAuthorization:(NSString*) authorization;
-(void) post: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target andAuthorization:(NSString*) authorization;
-(void) put: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target
andAuthorization:(NSString*) authorization;
-(void) delete: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target
andAuthorization:(NSString*) authorization;
@end
