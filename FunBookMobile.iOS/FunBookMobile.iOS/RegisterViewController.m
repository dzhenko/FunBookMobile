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
#import "InternetConnectionHelper.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

static InternetConnectionHelper *internetCheker;
static AppData *data;
static UIAlertView *alertView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    internetCheker = [[InternetConnectionHelper alloc] init];
    
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
    NSString *status = [internetCheker getConnectionSatus];
    
    if ([status isEqualToString:@"Not connected"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not connected" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    } else {
        NSString *userEmail = self.userEmail.text;
        NSString *userPassword = self.userPassword.text;
        NSString *userConfirmPassword = self.userConfirmPassword.text;
        if ((userEmail.length != 0) && (userPassword.length != 0) && (userConfirmPassword.length != 0)
            && (userEmail.length != 1) && (userPassword.length != 1) && (userConfirmPassword.length != 1)) {
            [data registerUserWithEmail:userEmail andPassword:userPassword AndPerformBlock:^(BOOL success) {
                alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully registered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [self performSegueWithIdentifier:@"unwindBackToLogin" sender:self];
            }];
        } else {
            alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Input must be longer than 1" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

@end
