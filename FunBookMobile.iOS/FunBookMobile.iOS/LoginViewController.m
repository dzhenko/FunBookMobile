//
//  LoginViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "LoginViewController.h"
#import "AppData.h"
#import "AppDelegate.h"
#import "HomeViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

static AppData *data;
static UIAlertView *alertView;

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginBtnPressed:(UIButton *)sender {
    NSString *userEmail = self.userEmail.text;
    NSString *userPassword = self.userPassword.text;
    if ((userEmail.length != 0) && (userPassword.length != 0)) {
        [data loginUserWithEmail:userEmail andPassword:userPassword AndPerformBlock:^(BOOL success) {
            alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully logged in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [self performSegueWithIdentifier:@"fromLoginToHome" sender:self];
        }];
    } else {
        alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Wrong credentials or no such user, try to register first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
