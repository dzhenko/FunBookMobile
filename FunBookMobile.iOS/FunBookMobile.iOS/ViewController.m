//
//  ViewController.m
//  FunBookMobile.iOS
//
//  Created by Kris Kichev on 10/30/14.
//  Copyright (c) 2014 TelerikAcademyTeamwork. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@end

@implementation ViewController

static CLLocationManager *locationManager;
static CLPlacemark *mark;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    
    [locationManager requestAlwaysAuthorization];
    
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    __weak id weakSelf = self;
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        mark = [placemarks lastObject];
//        [weakSelf label].text ...
    }];
    [locationManager pausesLocationUpdatesAutomatically];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
