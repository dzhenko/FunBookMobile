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
        NSLog(@"Test");
        if ([self.type isEqualToString:@"joke"]) {
            NSLog(@"%@ %@", self.modelId, self.commentText.text);
            [data commentJokeWithId:self.modelId commentText:self.commentText.text AndPerformBlock:^(BOOL success) {
                NSLog(@"successfully commented!");
            }];
        } else if ([self.type isEqualToString:@"link"]){
            NSLog(@"%@ %@", self.modelId, self.commentText.text);
            [data commentLinkWithId:self.modelId commentText:self.commentText.text AndPerformBlock:^(BOOL success) {
                NSLog(@"successfully commented!");
            }];
        } else if ([self.type isEqualToString:@"picture"]){
            NSLog(@"%@ %@", self.modelId, self.commentText.text);
            [data commentPictureWithId:self.modelId commentText:self.commentText.text AndPerformBlock:^(BOOL success) {
                NSLog(@"successfully commented!");
            }];
        }
    }
    
}

@end

