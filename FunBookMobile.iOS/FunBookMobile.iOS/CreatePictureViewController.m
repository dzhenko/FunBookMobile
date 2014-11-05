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

@interface CreatePictureViewController ()

@end

@implementation CreatePictureViewController

static BOOL isAnonymous;
static AppData *data;
static UIImage *image;

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    
    NSString *encodedString = [imageData base64EncodedStringWithOptions:0];
    
    NSString *pictureTitle = self.pictureTitle.text;
    NSString *pictureCategory = self.pictureCategory.text;
    
    [data createPicture:[PictureNewDataModel pictureWithData:encodedString title:pictureTitle isAnonymous:isAnonymous andCategory:@"popular"] AndPerformSuccessBlock:^(NSString *createdObjId) {
        NSLog(@"Successfuly added!");
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

- (IBAction)pickPhotoBtnPressed:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIimagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
