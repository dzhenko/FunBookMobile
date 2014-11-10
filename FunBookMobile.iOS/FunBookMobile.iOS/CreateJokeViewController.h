//
//  CreateJokeViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/3/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateJokeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *jokeTitle;
@property (weak, nonatomic) IBOutlet UITextField *jokeText;
@property (weak, nonatomic) IBOutlet UIPickerView *categoriesPicker;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

- (IBAction)switchValueChanged:(UISwitch *)sender;
- (IBAction)createBtnPressed:(UIButton *)sender;

@end
