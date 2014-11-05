//
//  CreatePictureViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/3/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePictureViewController : UIViewController<UIImagePickerControllerDelegate ,UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UITextField *pictureCategory;
@property (weak, nonatomic) IBOutlet UITextField *pictureTitle;

- (IBAction)createBtnPressed:(UIButton *)sender;
- (IBAction)switchValueChanged:(UISwitch *)sender;
- (IBAction)pickPhotoBtnPressed:(UIButton *)sender;

@end
