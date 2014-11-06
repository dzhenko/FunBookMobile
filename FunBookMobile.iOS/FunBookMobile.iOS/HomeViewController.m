//
//  HomeViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/3/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableUIViewCell.h"
#import "AppData.h"
#import "AppDelegate.h"
#import "HomeDetailsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

static AppData* data;
static ContentHomeDataModel *homeModel;
static NSString *cellIdentifier = @"HomeTableUIViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
    [self setCustomTableCellForReusing];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self getHomeContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Datasource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableUIViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.cellTitle.text = homeModel.lastJoke.title;
            cell.cellContent.text = homeModel.lastJoke.content;
            cell.cellDate.text = homeModel.lastJoke.date;
        } else if (indexPath.row == 1) {
            cell.cellTitle.text = homeModel.lastLink.title;
            cell.cellContent.text = homeModel.lastLink.content;
            cell.cellDate.text = homeModel.lastLink.date;
        } else if (indexPath.row == 2) {
            cell.cellTitle.text = homeModel.lastPicture.title;
            cell.cellContent.text = homeModel.lastPicture.content;
            cell.cellDate.text = homeModel.lastPicture.date;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.cellTitle.text = homeModel.bestJoke.title;
            cell.cellContent.text = homeModel.bestJoke.content;
            cell.cellDate.text = homeModel.bestJoke.date;
        } else if (indexPath.row == 1) {
            cell.cellTitle.text = homeModel.bestLink.title;
            cell.cellContent.text = homeModel.bestLink.content;
            cell.cellDate.text = homeModel.bestLink.date;
        } else if (indexPath.row == 2) {
            cell.cellTitle.text = homeModel.bestPicture.title;
            cell.cellContent.text = homeModel.bestPicture.content;
            cell.cellDate.text = homeModel.bestPicture.date;
        }
    }
    
    
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 1, 320, 20);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:175.0f/255.0f green:202.0f/255.0f blue:87.0f/255.0f alpha:0.75f];
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset = CGSizeMake(-1.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor grayColor];
    [view addSubview:label];
    
    return view;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Most Recent";
    } else {
        return @"Most Popular";
    }
}

#pragma mark - UITableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"fromHomeToDetails" sender:nil];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    HomeDetailsViewController *vc = [segue destinationViewController];
    NSIndexPath *path = [self.homeTable indexPathForSelectedRow];
    if (path.section == 0) {
        if (path.row == 0) {
            vc.modelFromHome = homeModel.lastJoke;
            vc.type = @"joke";
        } else if (path.row == 1){
            vc.modelFromHome = homeModel.lastLink;
            vc.type = @"link";
        } else if (path.row == 2){
            vc.modelFromHome = homeModel.lastPicture;
            vc.type = @"picture";
        }
    } else {
        if (path.row == 0) {
            vc.modelFromHome = homeModel.bestJoke;
            vc.type = @"joke";
        } else if (path.row == 1){
            vc.modelFromHome = homeModel.bestLink;
            vc.type = @"link";
        } else if (path.row == 2){
            vc.modelFromHome = homeModel.bestPicture;
            vc.type = @"picture";
        }
    }
    
    // Pass the selected object to the new view controller.
}

#pragma mark - Private Methods

-(void)setCustomTableCellForReusing{
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.homeTable registerNib:nib forCellReuseIdentifier:cellIdentifier];
}

-(void)getHomeContent{
    [data getContentHomeAndPerformSuccessBlock:^(ContentHomeDataModel* model){
        homeModel = model;
        [self.homeTable reloadData];
        NSLog(@"%@",model);
    } orReactToErrorWithBlock:^(NSError* error){
        
        NSLog(@"%@",error);
    }];
}

@end