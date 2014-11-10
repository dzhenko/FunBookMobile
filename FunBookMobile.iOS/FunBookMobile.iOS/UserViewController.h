//
//  UserViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/6/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController

- (IBAction)loggOutBtnPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end
