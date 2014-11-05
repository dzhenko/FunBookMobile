//
//  AllJokesViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/4/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "AllJokesViewController.h"
#import "HomeTableUIViewCell.h"
#import "AppData.h"
#import "AppDelegate.h"
#import "HomeDetailsViewController.h"

@interface AllJokesViewController ()

@end

@implementation AllJokesViewController

static AppData *data;
static NSInteger page;
static NSArray *jokeModels;
static NSMutableArray *allJokeModels;
static NSString *cellIdentifier = @"HomeTableUIViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    jokeModels = [[NSArray alloc] init];
    allJokeModels = [[NSMutableArray alloc] init];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
    
    [data getJokesAllAtPage:page AndPerformSuccessBlock:^(NSArray *models) {
        [allJokeModels addObject:models];
        jokeModels = models;
        [self.allJokesTable reloadData];
    } orReactToErrorWithBlock:^(NSError *error) {
        
    }];
    
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.allJokesTable registerNib:nib forCellReuseIdentifier:cellIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [jokeModels count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableUIViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (jokeModels.count != 0) {
        ContentOverviewDataModel *currentJoke = jokeModels[indexPath.row];
        cell.cellTitle.text = currentJoke.title;
        cell.cellContent.text = currentJoke.content;
        cell.cellDate.text = currentJoke.date;
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
    return @"All Jokes";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"FromAllJokesToDetails" sender:nil];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HomeDetailsViewController *vc = [segue destinationViewController];
    NSIndexPath *path = [self.allJokesTable indexPathForSelectedRow];
    
    vc.modelFromHome = jokeModels[path.row];
    vc.type = @"joke";
}

- (IBAction)stepperValueChanged:(UIStepper *)sender {
    page = [sender value];
    NSLog(@"%d", page );
    [data getJokesAllAtPage:page AndPerformSuccessBlock:^(NSArray *models) {
        jokeModels = models;
        NSLog(@"loaded");
        [_allJokesTable reloadData];
    } orReactToErrorWithBlock:^(NSError *error) {
        
    }];
}

//- (IBAction)nextButtonPressed:(id)sender {
//    page++;
//    NSLog(@"%d", page );
//    if ((page - 1) == allJokeModels.count - 1) {
//        jokeModels = allJokeModels[page-1];
//        [_allJokesTable reloadData];
//    } else {
//        [data getJokesAllAtPage:page AndPerformSuccessBlock:^(NSArray *models) {
//            [allJokeModels addObject:models];
//            jokeModels = models;
//            NSLog(@"loaded");
//            [_allJokesTable reloadData];
//        } orReactToErrorWithBlock:^(NSError *error) {
//            
//        }];
//    }
//}
//
//- (IBAction)prevButtonPressed:(id)sender {
//    page--;
//    NSLog(@"%d", page );
//    if (page == 0) {
//        page = 1;
//        jokeModels = allJokeModels[page -1 ];
//        [_allJokesTable reloadData];
//    } else {
//        jokeModels = allJokeModels[page - 1];
//        [_allJokesTable reloadData];
//    }
//}

@end
