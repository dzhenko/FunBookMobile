//
//  CreatePictureViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/3/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePictureViewController : UIViewController<UIImagePickerControllerDelegate ,UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UITextField *pictureTitle;
@property (strong, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *backroundImage;

- (IBAction)createBtnPressed:(UIButton *)sender;
- (IBAction)switchValueChanged:(UISwitch *)sender;

@end
