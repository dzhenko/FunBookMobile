//
//  PhotoDetailsViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/7/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "Photo.h"
#import "FiltersCollectionViewController.h"

@interface PhotoDetailsViewController ()

@end

@implementation PhotoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.imageView.image = self.photo.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FiltersSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[FiltersCollectionViewController class]]) {
            FiltersCollectionViewController *targetVC = [segue destinationViewController];
            targetVC.photo = self.photo;
        }
    }
}

- (IBAction)addFilterBtnPressed:(UIButton *)sender {
    
}

- (IBAction)deleteBtnPressed:(UIButton *)sender {
    
    [[self.photo managedObjectContext] deleteObject:self.photo];
    
    NSError *error = nil;
    
    [[self.photo managedObjectContext] save:&error];
    if (error) {
        NSLog(@"error");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
