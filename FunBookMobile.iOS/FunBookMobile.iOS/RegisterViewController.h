//
//  RegisterViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UITextField *userConfirmPassword;

- (IBAction)registerBtnPressed:(UIButton *)sender;

@end
