//
//  RegisterViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppData.h"
#import "AppDelegate.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

static AppData *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerBtnPressed:(UIButton *)sender {
    NSString *userEmail = self.userEmail.text;
    NSString *userPassword = self.userPassword.text;
    NSString *userConfirmPassword = self.userConfirmPassword.text;
    if ((userEmail.length != 0) && (userPassword.length != 0) && (userConfirmPassword.length != 0)) {
        [data registerUserWithEmail:userEmail andPassword:userPassword AndPerformBlock:^(BOOL success) {
            NSLog(@"Successfully registered");
        }];
    }
}
@end
