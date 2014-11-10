//
//  CreatePictureViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/3/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "CreatePictureViewController.h"
#import "AppData.h"
#import "AppDelegate.h"
#import "PhotosCollectionViewController.h"

@interface CreatePictureViewController ()<UIImagePickerControllerDelegate ,UINavigationBarDelegate>

@end

@implementation CreatePictureViewController

static BOOL isAnonymous;
static AppData *data;
static UIAlertView *alertView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backroundImage.image = [UIImage imageNamed:@"bck.jpg"];
    data = [[AppData alloc] init];
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

- (IBAction)createBtnPressed:(UIButton *)sender {
        
    NSData *imageData = UIImageJPEGRepresentation(self.image, 90);
    
    NSString *encodedString = [imageData base64EncodedStringWithOptions:0];
    
    NSString *pictureTitle = self.pictureTitle.text;
    
    [data createPicture:[PictureNewDataModel pictureWithData:encodedString title:pictureTitle isAnonymous:isAnonymous andCategory:@"popular"] AndPerformSuccessBlock:^(NSString *createdObjId) {
        alertView = [[UIAlertView alloc] initWithTitle:@"Successfully Created" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        [self performSegueWithIdentifier:@"unwindBackToCreate" sender:self];
    } orReactToErrorWithBlock:^(NSError *error) {
        NSLog(@"error");
    }];
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    if([sender isOn]){
        isAnonymous = YES;
    } else{
        isAnonymous = NO;
    }
}

#pragma mark - UIimagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.image = info[UIImagePickerControllerEditedImage];
    if (!self.image) {
        self.image = info[UIImagePickerControllerOriginalImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Methods

-(IBAction)unwindBackToCreatePicture:(UIStoryboardSegue*)segue{
    PhotosCollectionViewController *sourceVC = [segue sourceViewController];
    self.image = sourceVC.cellForCreate.imageView.image;
}

@end
