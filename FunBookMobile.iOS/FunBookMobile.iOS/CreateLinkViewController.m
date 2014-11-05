//
//  CreateLinkViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/3/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "CreateLinkViewController.h"
#import "AppData.h"
#import "AppDelegate.h"

@interface CreateLinkViewController ()

@end

@implementation CreateLinkViewController

static BOOL isAnonymous;
static AppData *data;

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

- (IBAction)switchValueChanged:(UISwitch *)sender {
    if([sender isOn]){
        isAnonymous = YES;
    } else{
        isAnonymous = NO;
    }
}

- (IBAction)createBtnPressed:(UIButton *)sender {
    NSString *linkUrl = self.linkUrl.text;
    NSString *linkTitle = self.linkTitle.text;
    NSString *linkCategory = self.linkCategory.text;
    
    [self createLinkWithUrl:linkUrl title:linkTitle andCategory:nil];
}

-(void) createLinkWithUrl:(NSString *)url title:(NSString *)title andCategory:(NSString *)category{
    [data createLink:[LinkNewDataModel linkWithUrl:url title:title isAnonymous:isAnonymous andCategory:@"popular"] AndPerformSuccessBlock:^(NSString *createdObjId) {
        NSLog(@"Successfuly added!");
    } orReactToErrorWithBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}

@end
