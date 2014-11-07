//
//  CreateLinkViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/3/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateLinkViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *linkCategory;
@property (weak, nonatomic) IBOutlet UITextField *linkTitle;
@property (weak, nonatomic) IBOutlet UITextField *linkUrl;

- (IBAction)switchValueChanged:(UISwitch *)sender;
- (IBAction)createBtnPressed:(UIButton *)sender;

@end
