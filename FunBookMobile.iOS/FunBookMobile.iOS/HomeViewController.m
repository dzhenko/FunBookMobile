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

@interface HomeViewController ()

@end

@implementation HomeViewController

static ContentHomeDataModel *homeModel;
static NSString *cellIdentifier = @"HomeTableUIViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppData* data = [[AppData alloc] init];
    [data getContentHomeAndPerformSuccessBlock:^(ContentHomeDataModel* model){
        homeModel = model;
        [self.homeTable reloadData];
        NSLog(@"%@",model);
    } orReactToErrorWithBlock:^(NSError* error){
        
        NSLog(@"%@",error);
    }];
    
    
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    
    [self.homeTable registerNib:nib forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
