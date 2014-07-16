//
//  MapViewController.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/7/1.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "MapViewController.h"
#import "PropertyListReader.h"

#define REGION_DISTANCE_IN_METERS 1000
#define ANNOTATION_ID_COLLEGE @"annotation-id_college"

#define ILSC_BRISBANE_OFFICIAL_LINK_KEY @"Official web page link"
#define ILSC_BRISBANE_OFFICIAL_LOCATION_KEY @"Geo location"
#define OFFICIAL_INFO_PROPERT_YLIST @"ILSC-Brisbane-Official-Info"

@interface MapViewController ()

@property (nonatomic) CLLocationCoordinate2D mapCenterCoordinate;
@property (nonatomic) NSDictionary *propertyList;

@end

@implementation MapViewController

#pragma mark - Member Accessor

- (CLLocationCoordinate2D)mapCenterCoordinate {
    CLLocationCoordinate2D centerLocation;

    NSDictionary *geoLocation = [self.propertyList objectForKey:ILSC_BRISBANE_OFFICIAL_LOCATION_KEY];
    centerLocation.latitude = [[geoLocation objectForKey:@"latitude"] doubleValue];
    centerLocation.longitude= [[geoLocation objectForKey:@"longitude"] doubleValue];

    return centerLocation;
}

- (NSDictionary *)propertyList
{
    if (!_propertyList) {
        _propertyList = [PropertyListReader getDataByPropertyListFileName:OFFICIAL_INFO_PROPERT_YLIST];
    }

    return _propertyList;
}

#pragma mark - UI Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [self initMapView];
    [self putAnnotation];
}

- (void)initMapView {
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.mapCenterCoordinate, REGION_DISTANCE_IN_METERS, REGION_DISTANCE_IN_METERS);

    [self.mapView setRegion:viewRegion animated:YES];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setDelegate:self];
}

- (void)putAnnotation {
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    [annotation setTitle:@"ILSC-Brisbane"];
    [annotation setSubtitle:@"Learn English in Australia"];
    [annotation setCoordinate:self.mapCenterCoordinate];

    [self.mapView addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // Try to dequeue an existing pin view first (code not shown).

    // If no pin view already exists, create a new one.
    MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
                                          initWithAnnotation:annotation reuseIdentifier:ANNOTATION_ID_COLLEGE];
    customPinView.pinColor = MKPinAnnotationColorRed;
    customPinView.animatesDrop = YES;
    customPinView.canShowCallout = YES;

    // Because this is an iOS app, add the detail disclosure button to display details about the annotation in another view.
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:self action:@selector(calloutRightButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    customPinView.rightCalloutAccessoryView = rightButton;

    // Add a custom image to the left side of the callout.
    UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ILSC"]];
    myCustomImage.frame = CGRectMake(0,0,31,31);
    customPinView.leftCalloutAccessoryView = myCustomImage;

    return customPinView;
}

- (void)calloutRightButtonTouched:(UIButton *)sender
{
    NSString *officialLink = [self.propertyList objectForKey:ILSC_BRISBANE_OFFICIAL_LINK_KEY];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:officialLink]];
}

@end
