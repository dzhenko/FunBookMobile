//
//  HomeDetailsViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/4/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import "AppData.h"
#import "CommentDataModel.h"
#import "AddCommentViewController.h"

@interface HomeDetailsViewController ()

@end

@implementation HomeDetailsViewController

static JokeDetailsDataModel *jokeModel;
static LinkDetailsDataModel *linkModel;
static PictureDetailsDataModel *pictureModel;
static NSArray *comments;
static AppData* data;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(600, 700)];
    comments = [[NSArray alloc] init];
    data = [[AppData alloc] init];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.type isEqualToString:@"joke"]) {
        [data getJokeDetailsForId:self.modelFromHome.objId AndPerformSuccessBlock:^(JokeDetailsDataModel *model) {
            jokeModel = model;
            self.modelTitle.text = jokeModel.title;
            self.modelText.text = jokeModel.text;
            self.modelViewsCount.text = [[NSString alloc] initWithFormat:@"%i", jokeModel.views];
            // todo: add category
            self.modelDate.text = jokeModel.created;
            comments = jokeModel.comments;
            [self.picker reloadAllComponents];
        } orReactToErrorWithBlock:^(NSError *error) {
            
        } ];
    } else if ([self.type isEqualToString:@"link"]){
        [data getLinkDetailsForId:self.modelFromHome.objId AndPerformSuccessBlock:^(LinkDetailsDataModel *model) {
            linkModel = model;
            self.modelTitle.text = linkModel.title;
            self.modelText.text = linkModel.url;
            self.modelViewsCount.text = [[NSString alloc] initWithFormat:@"%i", linkModel.views];
            // todo: add category
            self.modelDate.text = linkModel.created;
            comments = linkModel.comments;
            [self.picker reloadAllComponents];
        } orReactToErrorWithBlock:^(NSError *error) {
            
        }];
    } else if ([self.type isEqualToString:@"picture"]){
        [data getPictureDetailsForId:self.modelFromHome.objId AndPerformSuccessBlock:^(PictureDetailsDataModel *model) {
            pictureModel = model;
            self.modelTitle.text = pictureModel.title;
            [self getImageFromURL];
            self.modelViewsCount.text = [[NSString alloc] initWithFormat:@"%i", pictureModel.views];
            // todo: add category
            self.modelDate.text = pictureModel.created;
            comments = pictureModel.comments;
            [self.picker reloadAllComponents];
        } orReactToErrorWithBlock:^(NSError *error) {
            
        }];
    }
}

-(void)getImageFromURL{
    NSURL *imageURL = [NSURL URLWithString:pictureModel.url];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            self.imageView.image = [UIImage imageWithData:imageData];
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker datasource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [comments count];
}

#pragma mark - Picker delegate

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    CommentDataModel *comment = comments[row];
    return comment.text;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        //label size
        CGRect frame = CGRectMake(0.0, 0.0, 300, 30);
        
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        //here you can play with fonts
        [pickerLabel setFont:[UIFont fontWithName:@"Times New Roman" size:10.0]];
        
    }
    //picker view array is the datasource
    CommentDataModel *comment = comments[row];
    [pickerLabel setText:comment.text];
    
    return pickerLabel;
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    AddCommentViewController *vc = [segue destinationViewController];
    // Pass the selected object to the new view controller.
    vc.type = self.type;
    vc.modelId = self.modelFromHome.objId;
}

@end

