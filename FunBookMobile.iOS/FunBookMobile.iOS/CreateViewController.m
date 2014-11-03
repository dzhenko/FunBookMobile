//
//  CreateViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/1/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()

@property (weak, nonatomic) IBOutlet UIButton *pickPhotoBtn;

@end

@implementation CreateViewController

static NSString *CreateJokeViewIdentifier = @"CreateJokeView";
static NSString *CreateLinkViewIdentifier = @"CreateLinkView";
static NSString *CreatePictureViewIdentifier = @"CreatePictureView";
static UIView *CreateJokeSubView;
static UIView *CreateLinkSubview;
static UIView *CreatePictureSubview;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickPhotoBtn.hidden = YES;
    
    
    // Do any additional setup after loading the view.
    [self loadSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSubViews{
    CreatePictureSubview = [[NSBundle mainBundle] loadNibNamed:CreatePictureViewIdentifier owner:self options:nil][0];
    [self.createView addSubview:CreatePictureSubview];
    CreateLinkSubview = [[NSBundle mainBundle] loadNibNamed:CreateLinkViewIdentifier owner:self options:nil][0];
    [self.createView addSubview:CreateLinkSubview];
    CreateJokeSubView = [[NSBundle mainBundle] loadNibNamed:CreateJokeViewIdentifier owner:self options:nil][0];
    [self.createView addSubview:CreateJokeSubView];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    int selectedItem = tabBar.selectedItem.tag;
    if (selectedItem == 1) {
        [self.createView bringSubviewToFront:CreateJokeSubView];
        self.pickPhotoBtn.hidden = YES;
    } else if (selectedItem == 2){
        [self.createView bringSubviewToFront:CreateLinkSubview];
        self.pickPhotoBtn.hidden = YES;
    } else if (selectedItem == 3){
        [self.createView bringSubviewToFront:CreatePictureSubview];
        self.pickPhotoBtn.hidden = NO;
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
