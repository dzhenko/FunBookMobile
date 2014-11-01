//
//  HttpRequester.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequester : NSObject
-(void) get: (NSString*) url headers: (NSDictionary*) headers withTarget: (NSObject*) target
     action:(void (^)(id result))callback;

-(void) post: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target action:(void (^)(id result))callback;

-(void) put: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target action:(void (^)(id result))callback;

-(void) delete: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target action:(void (^)(id result))callback;
@end
