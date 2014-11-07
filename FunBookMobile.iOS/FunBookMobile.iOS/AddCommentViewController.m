//
//  AddCommentViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/4/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "AddCommentViewController.h"
#import "AppData.h"
#import "AppDelegate.h"

@interface AddCommentViewController ()

@end

@implementation AddCommentViewController

static AppData *data;
static UIAlertView *alertView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
    
    // Do any additional setup after loading the view.
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

- (IBAction)addCommentBtnPressed:(id)sender {
    if ([self.commentText.text length] != 0) {
        if ([self.type isEqualToString:@"joke"]) {
            [data commentJokeWithId:self.modelId commentText:self.commentText.text AndPerformBlock:^(BOOL success) {
                alertView = [[UIAlertView alloc] initWithTitle:@"Successfully Commented" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
                [self performSegueWithIdentifier:@"unwindBackToDetails" sender:self];
            }];
        } else if ([self.type isEqualToString:@"link"]){
            [data commentLinkWithId:self.modelId commentText:self.commentText.text AndPerformBlock:^(BOOL success) {
                alertView = [[UIAlertView alloc] initWithTitle:@"Successfully Commented" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
                [self performSegueWithIdentifier:@"unwindBackToDetails" sender:self];
            }];
        } else if ([self.type isEqualToString:@"picture"]){
            [data commentPictureWithId:self.modelId commentText:self.commentText.text AndPerformBlock:^(BOOL success) {
                alertView = [[UIAlertView alloc] initWithTitle:@"Successfully Commented" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
                [self performSegueWithIdentifier:@"unwindBackToDetails" sender:self];
            }];
        }
    }
    
}

@end

