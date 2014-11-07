//
//  PhotoDetailsViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/7/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface PhotoDetailsViewController : UIViewController

@property (strong, nonatomic) Photo *photo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addFilterBtnPressed:(UIButton *)sender;
- (IBAction)deleteBtnPressed:(UIButton *)sender;
- (IBAction)handlePinch:(UIPinchGestureRecognizer *)sender;


@end
