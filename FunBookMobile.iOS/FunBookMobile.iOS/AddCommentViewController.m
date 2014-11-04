//
//  AddCommentViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/4/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "AddCommentViewController.h"
#import "AppData.h"

@interface AddCommentViewController ()

@end

@implementation AddCommentViewController

static AppData *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    data = [[AppData alloc] init];
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
    
    if ([self.commentTextField.text length] != 0) {
        NSLog(@"Test");
        if ([self.type isEqualToString:@"joke"]) {
            NSLog(@"Test");
            NSLog(@"%@", self.commentTextField.text);
            [data commentJokeWithId:self.modelId commentText:self.commentTextField.text AndPerformBlock:^(BOOL success) {
                NSLog(@"succesfully commented!");
            }];
        } else if ([self.type isEqualToString:@"link"]){
            [data commentLinkWithId:self.modelId commentText:self.commentTextField.text AndPerformBlock:^(BOOL success) {
                NSLog(@"succesfully commented!");
            }];
        } else if ([self.type isEqualToString:@"picture"]){
            [data commentPictureWithId:self.modelId commentText:self.commentTextField.text AndPerformBlock:^(BOOL success) {
                NSLog(@"succesfully commented!");
            }];
        }
    }
    
}
@end

