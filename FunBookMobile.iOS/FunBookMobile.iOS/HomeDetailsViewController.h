//
//  HomeDetailsViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/4/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentOverviewDataModel.h"

@interface HomeDetailsViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *modelTitle;
@property (weak, nonatomic) IBOutlet UILabel *modelText;
@property (weak, nonatomic) IBOutlet UILabel *modelViewsCount;
@property (weak, nonatomic) IBOutlet UILabel *modelHatesCount;
@property (weak, nonatomic) IBOutlet UILabel *modelLikesCount;
@property (weak, nonatomic) IBOutlet UILabel *modelDate;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *labelCreator;

@property (strong, nonatomic) ContentOverviewDataModel *modelFromHome;
@property (strong, nonatomic) NSString *type;

- (IBAction)hateBtnPressed:(UIButton *)sender;
- (IBAction)likeBtnPressed:(UIButton *)sender;
- (IBAction)callBtnPressed:(UIButton *)sender;

@end
