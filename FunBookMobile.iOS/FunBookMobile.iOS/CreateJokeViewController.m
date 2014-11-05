//
//  CreateJokeViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/3/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "CreateJokeViewController.h"
#import "AppData.h"
#import "AppDelegate.h"

@interface CreateJokeViewController ()

@end

@implementation CreateJokeViewController

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
    
    NSString *jokeText = self.jokeText.text;
    NSString *jokeTitle = self.jokeTitle.text;
    NSString *jokeCategory = self.jokeCategory.text;
    
    [self createJokeWithText:jokeText title:jokeTitle andCategory:nil];
    
}

-(void) createJokeWithText:(NSString *)text title:(NSString *)title andCategory:(NSString *)category{
    
    [data createJoke:[JokeNewDataModel jokeWithText:text title:title isAnonymous:isAnonymous andCategory:@"popular"] AndPerformSuccessBlock:^(NSString *createdObjId) {
        NSLog(@"Successfuly added!");
    } orReactToErrorWithBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}

@end
