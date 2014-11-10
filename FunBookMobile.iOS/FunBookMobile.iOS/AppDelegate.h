//
//  AppDelegate.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 10/30/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppData.h"
#import "ContactsData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AppData *data;
@property (strong, nonatomic) NSDictionary *contactsData;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

