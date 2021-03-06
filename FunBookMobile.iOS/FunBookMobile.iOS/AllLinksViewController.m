//
//  AllLinksViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/4/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "AllLinksViewController.h"
#import "HomeTableUIViewCell.h"
#import "AppData.h"
#import "AppDelegate.h"
#import "HomeDetailsViewController.h"

@interface AllLinksViewController ()

@end

@implementation AllLinksViewController

static AppData *data;
static NSInteger page;
static NSArray *linkModels;
static NSString *cellIdentifier = @"HomeTableUIViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    linkModels = [[NSArray alloc] init];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
    
    [data getLinksAllAtPage:page AndPerformSuccessBlock:^(NSArray *models) {
        linkModels = models;
        [self.allLinksTable reloadData];
    } orReactToErrorWithBlock:^(NSError *error) {
        
    }];
    
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.allLinksTable registerNib:nib forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [linkModels count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableUIViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (linkModels.count != 0) {
        ContentOverviewDataModel *currentLink = linkModels[indexPath.row];
        cell.cellTitle.text = currentLink.title;
        cell.cellContent.text = currentLink.content;
        cell.cellDate.text = currentLink.date;
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
    label.textColor = [UIColor colorWithRed:238.0f/255.0f green:57.0f/255.0f blue:99.0f/255.0f alpha:0.75f];
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset = CGSizeMake(-1.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    return view;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"All Links";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"FromAllLinksToDetails" sender:nil];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HomeDetailsViewController *vc = [segue destinationViewController];
    NSIndexPath *path = [self.allLinksTable indexPathForSelectedRow];
    
    vc.modelFromHome = linkModels[path.row];
    vc.type = @"link";
}

- (IBAction)stepperValueChanged:(UIStepper *)sender {
    page = [sender value];
    NSLog(@"%d", page );
    [data getLinksAllAtPage:page AndPerformSuccessBlock:^(NSArray *models) {
        linkModels = models;
        [_allLinksTable reloadData];
    } orReactToErrorWithBlock:^(NSError *error) {
        
    }];
}
@end
