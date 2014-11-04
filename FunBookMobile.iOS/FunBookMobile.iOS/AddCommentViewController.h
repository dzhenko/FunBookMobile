//
//  AddCommentViewController.h
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/4/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentViewController : UIViewController

- (IBAction)addCommentBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property NSString *type;
@property NSString *modelId;

@end
