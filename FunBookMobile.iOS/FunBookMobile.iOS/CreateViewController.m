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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundImage.image = [UIImage imageNamed:@"bck.jpg"];
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

-(IBAction)unwindBackToCreate:(UIStoryboardSegue*)segue{
    
}

@end
