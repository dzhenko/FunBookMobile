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
    
    self.backgroundImage.image = [UIImage imageNamed:@"bck.jpg"];
    internetCheker = [[InternetConnectionHelper alloc] init];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.userEmail resignFirstResponder];
    [self.userPassword resignFirstResponder];
    [self.userConfirmPassword resignFirstResponder];
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
        
        if (userEmail.length > 5 && userPassword.length > 5) {
            if ([userPassword isEqualToString:userConfirmPassword]) {
                [data registerUserWithEmail:userEmail andPassword:userPassword AndPerformBlock:^(BOOL success) {
                    if (success) {
                        [[[UIAlertView alloc] initWithTitle:nil message:@"Successfully registered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]
                         show];
                        
                        [self performSegueWithIdentifier:@"unwindBackToLogin" sender:self];
                    }
                    else {
                        [[[UIAlertView alloc] initWithTitle:nil message:@"User with same email already exists" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]
                         show];
                    }
                }];
            }
            else {
                [[[UIAlertView alloc] initWithTitle:nil message:@"User with same email already exists" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]
                 show];
            }
            
            
        } else {
            NSString* msg = userEmail.length < 2
                ? @"Email must be valid!" : @"Password must be at least 2 symbols";
            
            [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]
             show];
        }
    }
}

@end
