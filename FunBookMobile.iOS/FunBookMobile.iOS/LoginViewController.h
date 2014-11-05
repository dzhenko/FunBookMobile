//
//  LoginViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userEmail;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;

- (IBAction)loginBtnPressed:(UIButton *)sender;

@end
