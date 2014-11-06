//
//  UserViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 11/6/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "UserViewController.h"
#import "AppData.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface UserViewController ()<CLLocationManagerDelegate>

@end

@implementation UserViewController

static CLLocationManager *locationManager;
static CLPlacemark *mark;
static AppData *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    data = app.data;
    
    [self initializeLocationManager];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        mark = [placemarks lastObject];
        NSDictionary *address = mark.addressDictionary;
        NSString *city = [address objectForKey:@"City"];
        NSString *country = [address objectForKey:@"Country"];
        
        self.cityLabel.text = city;
        self.countryLabel.text = country;
    }];
    [locationManager pausesLocationUpdatesAutomatically];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private Methods

-(void)initializeLocationManager{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    
    [locationManager requestAlwaysAuthorization];
    
    [locationManager startUpdatingLocation];
}

- (IBAction)loggOutBtnPressed:(UIButton *)sender {
    if (data.isUserLoggedIn) {
        [data logoutAndPerformBlock:^(BOOL success) {
            [self performSegueWithIdentifier:@"fromUserToLogin" sender:self];
        }];
    }
}

@end
