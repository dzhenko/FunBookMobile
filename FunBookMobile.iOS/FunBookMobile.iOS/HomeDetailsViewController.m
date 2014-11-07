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
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
    
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
        });
    });
    
}

- (IBAction)hateBtnPressed:(UIButton *)sender {
    if ([self.type isEqualToString:@"joke"]) {
        [data hateJokeWithId:jokeModel.objId AndPerformBlock:^(BOOL success) {
            NSLog(@"hated");
        }];
    } else if ([self.type isEqualToString:@"link"]){
        [data hateLinkWithId:linkModel.objId AndPerformBlock:^(BOOL success) {
            NSLog(@"hated");
        }];
    } else if ([self.type isEqualToString:@"picture"]){
        [data hatePictureWithId:pictureModel.objId AndPerformBlock:^(BOOL success) {
            NSLog(@"hated");
        }];
    }
}

- (IBAction)likeBtnPressed:(UIButton *)sender {
    if ([self.type isEqualToString:@"joke"]) {
        [data likeJokeWithId:jokeModel.objId AndPerformBlock:^(BOOL success) {
            NSLog(@"liked");
        }];
    } else if ([self.type isEqualToString:@"link"]){
        [data likeLinkWithId:linkModel.objId AndPerformBlock:^(BOOL success) {
            NSLog(@"liked");
        }];
    } else if ([self.type isEqualToString:@"picture"]){
        [data likePictureWithId:pictureModel.objId AndPerformBlock:^(BOOL success) {
            NSLog(@"liked");
        }];
    }
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)sender {
    CGFloat lastScaleFactor = 1;
    CGFloat factor = [(UIPinchGestureRecognizer *) sender scale];
    
    if (factor > 1) { // zooming in
        self.imageView.transform = CGAffineTransformMakeScale(
                                                              lastScaleFactor + (factor - 1),
                                                              lastScaleFactor + (factor - 1));
    } else { // zooming out
        self.imageView.transform = CGAffineTransformMakeScale(
                                                              lastScaleFactor * factor,
                                                              lastScaleFactor * factor);
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (factor > 1) {
            lastScaleFactor += (factor - 1);
        } else {
            lastScaleFactor *= factor;
        }
    }
}

-(void)visualizeData{
    if ([self.type isEqualToString:@"joke"]) {
        [data getJokeDetailsForId:self.modelFromHome.objId AndPerformSuccessBlock:^(JokeDetailsDataModel *model) {
            jokeModel = model;
            self.modelTitle.text = jokeModel.title;
            self.modelText.text = jokeModel.text;
            self.modelViewsCount.text = [[NSString alloc] initWithFormat:@"%i", jokeModel.views];
            self.modelHatesCount.text = [[NSString alloc] initWithFormat:@"%i", jokeModel.hates];
            self.modelLikesCount.text = [[NSString alloc] initWithFormat:@"%i", jokeModel.likes];
            self.modelDate.text = jokeModel.created;
            comments = jokeModel.comments;
            [self.picker reloadAllComponents];
        } orReactToErrorWithBlock:^(NSError *error) {
            
        } ];
    } else if ([self.type isEqualToString:@"link"]){
//        [self.view bringSubviewToFront:self.modelText];
        [data getLinkDetailsForId:self.modelFromHome.objId AndPerformSuccessBlock:^(LinkDetailsDataModel *model) {
            linkModel = model;
            self.modelTitle.text = linkModel.title;
            self.modelText.text = linkModel.url;
            
            [self setHyperlinkText];
            
            self.modelViewsCount.text = [[NSString alloc] initWithFormat:@"%i", linkModel.views];
            self.modelHatesCount.text = [[NSString alloc] initWithFormat:@"%i", linkModel.hates];
            self.modelLikesCount.text = [[NSString alloc] initWithFormat:@"%i", linkModel.likes];
            self.modelDate.text = linkModel.created;
            comments = linkModel.comments;
            [self.picker reloadAllComponents];
        } orReactToErrorWithBlock:^(NSError *error) {
            
        }];
    } else if ([self.type isEqualToString:@"picture"]){
//        [self.view bringSubviewToFront:self.imageView];
        [data getPictureDetailsForId:self.modelFromHome.objId AndPerformSuccessBlock:^(PictureDetailsDataModel *model) {
            pictureModel = model;
            self.modelTitle.text = pictureModel.title;
            [self getImageFromURL];
            self.modelViewsCount.text = [[NSString alloc] initWithFormat:@"%i", pictureModel.views];
            self.modelHatesCount.text = [[NSString alloc] initWithFormat:@"%i", pictureModel.hates];
            self.modelLikesCount.text = [[NSString alloc] initWithFormat:@"%i", pictureModel.likes];
            self.modelDate.text = pictureModel.created;
            comments = pictureModel.comments;
            [self.picker reloadAllComponents];
        } orReactToErrorWithBlock:^(NSError *error) {
            
        }];
    }
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

@end

