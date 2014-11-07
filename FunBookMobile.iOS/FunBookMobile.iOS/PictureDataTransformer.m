//
//  PictureDataTransformer.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/7/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "PictureDataTransformer.h"
#import "AppDelegate.h"

@implementation PictureDataTransformer

+(Class)transformedValueClass{
    return [NSData class];
}

+(BOOL)allowsReverseTransformation{
    return YES;
}

-(id)transformedValue:(id)value{
    return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value{
    UIImage *image = [UIImage imageWithData:value];
    return image;
}

@end
