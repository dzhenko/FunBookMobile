//
//  AppData.h
//  FunBookMobile.iOS
//
//  Created by Admin on 11/2/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject
-(void) getHomeContentAndPerformSuccessBlock:(void (^)(id))successActionBlock
                     orReactToErrorWithBlock:(void (^)(NSError*))errorActionBlock;
@end
