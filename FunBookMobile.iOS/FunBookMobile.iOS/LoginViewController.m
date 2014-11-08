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
#import "InternetConnectionHelper.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

static AppData *data;
static UIAlertView *alertView;
static InternetConnectionHelper *internetCheker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    internetCheker = [[InternetConnectionHelper alloc] init];
    
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
    NSString *status = [internetCheker getConnectionSatus];
    
    if ([status isEqualToString:@"Not connected"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not connected" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    } else {
        NSString *userEmail = self.userEmail.text;
        NSString *userPassword = self.userPassword.text;
        if ((userEmail.length != 0) && (userPassword.length != 0) && (userEmail.length != 1) && (userPassword.length != 1)) {
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
}

-(IBAction)unwindBackToLogin:(UIStoryboardSegue*)segue{
    
}

@end
