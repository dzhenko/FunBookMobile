//
//  PhotosCollectionViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/7/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
#import "CreatePictureViewController.h"
#import "PhotosCollectionViewCell.h"

@interface PhotosCollectionViewController : UICollectionViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) PhotosCollectionViewCell *cellForCreate;
@property (strong, nonatomic) NSMutableArray *albums;
@property (strong, nonatomic) Album *album;

- (IBAction)cameraBtnPressed:(UIBarButtonItem *)sender;

@end
