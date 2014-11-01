//
//  CreateViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()

@end

@implementation CreateViewController

static NSString *CreateJokeViewIdentifier = @"CreateJokeView";
static NSString *CreateLinkViewIdentifier = @"CreateLinkView";
static NSString *CreatePictureViewIdentifier = @"CreatePictureView";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    int selectedItem = tabBar.selectedItem.tag;
    if (selectedItem == 1) {
        UIView *subView = [[NSBundle mainBundle] loadNibNamed:CreateJokeViewIdentifier owner:self options:nil][0];
        [self.createView addSubview:subView];
    } else if (selectedItem == 2){
        UIView *subView = [[NSBundle mainBundle] loadNibNamed:CreateLinkViewIdentifier owner:self options:nil][0];
        [self.createView addSubview:subView];
    } else if (selectedItem == 3){
        UIView *subView = [[NSBundle mainBundle] loadNibNamed:CreatePictureViewIdentifier owner:self options:nil][0];
        [self.createView addSubview:subView];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
