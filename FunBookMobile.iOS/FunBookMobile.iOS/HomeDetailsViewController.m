//
//  HomeDetailsViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/4/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import "AppData.h"
#import "AppDelegate.h"
#import "CommentDataModel.h"
#import "AddCommentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HomeDetailsViewController ()

@end

@implementation HomeDetailsViewController

static JokeDetailsDataModel *jokeModel;
static LinkDetailsDataModel *linkModel;
static PictureDetailsDataModel *pictureModel;
static NSArray *comments;
static AppData* data;
static UIAlertView *alertView;
static NSDictionary* contactsData;
static NSString* callNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(600, 700)];
    comments = [[NSArray alloc] init];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
    contactsData = app.contactsData;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self visualizeData];
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker Datasource Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [comments count];
}

#pragma mark - Picker Delegate Methods

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
    AddCommentViewController *vc = [segue destinationViewController];
    vc.type = self.type;
    vc.modelId = self.modelFromHome.objId;
}

#pragma mark - Private Methods

-(void)getImageFromURL{
    NSURL *imageURL = [NSURL URLWithString:pictureModel.url];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            self.imageView.image = [UIImage imageWithData:imageData];
            self.imageView.layer.cornerRadius = 15;
            self.imageView.clipsToBounds = YES;
        });
    });
    
}

- (IBAction)hateBtnPressed:(UIButton *)sender {
    if ([self.type isEqualToString:@"joke"]) {
        [data hateJokeWithId:jokeModel.objId AndPerformBlock:^(BOOL success) {
            [self visualizeData];
        }];
    } else if ([self.type isEqualToString:@"link"]){
        [data hateLinkWithId:linkModel.objId AndPerformBlock:^(BOOL success) {
            [self visualizeData];
        }];
    } else if ([self.type isEqualToString:@"picture"]){
        [data hatePictureWithId:pictureModel.objId AndPerformBlock:^(BOOL success) {
            [self visualizeData];
        }];
    }
}

- (IBAction)likeBtnPressed:(UIButton *)sender {
    if ([self.type isEqualToString:@"joke"]) {
        [data likeJokeWithId:jokeModel.objId AndPerformBlock:^(BOOL success) {
            [self visualizeData];
        }];
    } else if ([self.type isEqualToString:@"link"]){
        [data likeLinkWithId:linkModel.objId AndPerformBlock:^(BOOL success) {
            [self visualizeData];
        }];
    } else if ([self.type isEqualToString:@"picture"]){
        [data likePictureWithId:pictureModel.objId AndPerformBlock:^(BOOL success) {
            [self visualizeData];
        }];
    }
}

- (IBAction)callBtnPressed:(UIButton *)sender {
    if (callNumber) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:callNumber]]];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:nil message:@"You do not have this contact!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]
         show];
    }
}

-(void)visualizeData{
    if ([self.type isEqualToString:@"joke"]) {
        [self getJokeDetails];
    } else if ([self.type isEqualToString:@"link"]){
        [self getLinkDetails];
    } else if ([self.type isEqualToString:@"picture"]){
        [self getPictureDetails];
    }
}

-(void)getJokeDetails{
    [data getJokeDetailsForId:self.modelFromHome.objId AndPerformSuccessBlock:^(JokeDetailsDataModel *model) {
        jokeModel = model;
        
        [self makeLabel:self.modelTitle animationBetweenText:self.modelTitle.text andNewText:jokeModel.title];
        
        [self makeLabel:self.modelText animationBetweenText:self.modelText.text andNewText:jokeModel.text];
        
        [self makeLabel:self.modelViewsCount animationBetweenText:self.modelViewsCount.text andNewText:[[NSString alloc] initWithFormat:@"%li", jokeModel.views]];
        
        [self makeLabel:self.modelHatesCount animationBetweenText:self.modelHatesCount.text andNewText:[[NSString alloc] initWithFormat:@"%li", jokeModel.hates]];
        
        [self makeLabel:self.modelLikesCount animationBetweenText:self.modelLikesCount.text andNewText:[[NSString alloc] initWithFormat:@"%li", jokeModel.likes]];
        
        [self makeLabel:self.labelCreator animationBetweenText:self.labelCreator.text andNewText:jokeModel.creator];
        
        [self makeLabel:self.modelDate animationBetweenText:self.modelDate.text andNewText:jokeModel.created];
        
        comments = jokeModel.comments;
        
        callNumber = [contactsData objectForKey:model.creator];
        
        [self.picker reloadAllComponents];
    } orReactToErrorWithBlock:^(NSError *error) {
        
    } ];

}

-(void)getLinkDetails{
    [data getLinkDetailsForId:self.modelFromHome.objId AndPerformSuccessBlock:^(LinkDetailsDataModel *model) {
        linkModel = model;
        
        [self makeLabel:self.modelTitle animationBetweenText:self.modelTitle.text andNewText:linkModel.title];
        
        [self makeLabel:self.modelText animationBetweenText:self.modelText.text andNewText:linkModel.url];
        
        [self makeLabel:self.modelViewsCount animationBetweenText:self.modelViewsCount.text andNewText:[[NSString alloc] initWithFormat:@"%li", linkModel.views]];
        
        [self makeLabel:self.modelHatesCount animationBetweenText:self.modelHatesCount.text andNewText:[[NSString alloc] initWithFormat:@"%li", linkModel.hates]];
        
        [self makeLabel:self.modelLikesCount animationBetweenText:self.modelLikesCount.text andNewText:[[NSString alloc] initWithFormat:@"%li", linkModel.likes]];
        
        [self makeLabel:self.labelCreator animationBetweenText:self.labelCreator.text andNewText:linkModel.creator];
        
        [self makeLabel:self.modelDate animationBetweenText:self.modelDate.text andNewText:linkModel.created];
        
        [self setHyperlinkText];
        
        comments = linkModel.comments;
        
        callNumber = [contactsData objectForKey:model.creator];
        
        [self.picker reloadAllComponents];
    } orReactToErrorWithBlock:^(NSError *error) {
        
    }];

}

-(void)getPictureDetails{
    [data getPictureDetailsForId:self.modelFromHome.objId AndPerformSuccessBlock:^(PictureDetailsDataModel *model) {
        pictureModel = model;
        
        [self makeLabel:self.modelTitle animationBetweenText:self.modelTitle.text andNewText:pictureModel.title];
        
        [self makeLabel:self.modelViewsCount animationBetweenText:self.modelViewsCount.text andNewText:[[NSString alloc] initWithFormat:@"%li", pictureModel.views]];
        
        [self makeLabel:self.modelHatesCount animationBetweenText:self.modelHatesCount.text andNewText:[[NSString alloc] initWithFormat:@"%li", pictureModel.hates]];
        
        [self makeLabel:self.modelLikesCount animationBetweenText:self.modelLikesCount.text andNewText:[[NSString alloc] initWithFormat:@"%li", pictureModel.likes]];
        
        [self makeLabel:self.labelCreator animationBetweenText:self.labelCreator.text andNewText:pictureModel.creator];
        
        [self makeLabel:self.modelDate animationBetweenText:self.modelDate.text andNewText:pictureModel.created];
        
        [self getImageFromURL];
        
        comments = pictureModel.comments;
        
        callNumber = [contactsData objectForKey:model.creator];
        
        [self.picker reloadAllComponents];
    } orReactToErrorWithBlock:^(NSError *error) {
        
    }];
}

-(void)setHyperlinkText{
    self.modelText.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    tapGesture.numberOfTapsRequired = 1;
    [self.modelText addGestureRecognizer:tapGesture];
}

-(void)labelTap{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkModel.url]];
}

-(void)makeLabel:(UILabel *)label animationBetweenText:(NSString *)text andNewText:(NSString *)newText{
    [UIView beginAnimations:text context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.0f];
    [label setAlpha:0];
    [label setText:newText];
    [label setAlpha:1];
    [UIView commitAnimations];
}

-(IBAction)unwindBackToDetails:(UIStoryboardSegue*)segue{
    
}

@end

