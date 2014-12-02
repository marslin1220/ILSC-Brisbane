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
#define ANNOTATION_ID_USER @"annotation-id_user"

#define ILSC_BRISBANE_OFFICIAL_LINK_KEY @"Official web page link"
#define ILSC_BRISBANE_OFFICIAL_LOCATION_KEY @"Geo location"
#define OFFICIAL_INFO_PROPERT_YLIST @"ILSC-Brisbane-Official-Info"

@interface MapViewController ()

@property (nonatomic) CLLocationCoordinate2D mapCenterCoordinate;
@property (nonatomic) NSDictionary *propertyList;
@property (nonatomic) MKMapItem *ilscBrisbaneMapItem;
@property (strong, nonatomic) CLLocationManager *locationManager;

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

- (MKMapItem *)ilscBrisbaneMapItem
{
    if (!_ilscBrisbaneMapItem) {

        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.mapCenterCoordinate
                                                       addressDictionary:nil];
        _ilscBrisbaneMapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    }

    return _ilscBrisbaneMapItem;
}

- (CLLocationManager *)locationManager
{
  if (!_locationManager) {
    _locationManager = [[CLLocationManager alloc] init];
  }

  return _locationManager;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];

  self.propertyList = nil;
  self.ilscBrisbaneMapItem = nil;
  self.locationManager = nil;
}

#pragma mark - UI Life Cycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self requestLocationAuthorization];

  [self initMapView];
  [self initToolbar];
  [self putAnnotation];
  [self addRouteToMap];
}

- (void)requestLocationAuthorization
{
  if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    [self.locationManager requestWhenInUseAuthorization];
  }
}

- (void)initMapView {
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.mapCenterCoordinate, REGION_DISTANCE_IN_METERS, REGION_DISTANCE_IN_METERS);

    [self.mapView setRegion:viewRegion animated:YES];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
}

- (void)initToolbar
{
  MKUserTrackingBarButtonItem *trackingItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
  [self.toolbar setItems:@[trackingItem]];
}

- (void)putAnnotation {
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    [annotation setTitle:@"ILSC-Brisbane"];
    [annotation setSubtitle:@"Learn English in Australia"];
    [annotation setCoordinate:self.mapCenterCoordinate];

    [self.mapView addAnnotation:annotation];
}

#pragma mark - Add Annotation

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *customPinView;

    if ([self isCollegeAnnotation:annotation]) {
        customPinView = [self getCollegeAnnotationViewWithAnnotation:annotation];
    }
    else {
        customPinView = [self getUserAnnotationViewWithAnnotation:annotation];
    }

    return customPinView;
}

- (BOOL)isCollegeAnnotation:(id <MKAnnotation>)annotation
{
    return [[annotation title] isEqualToString:@"ILSC-Brisbane"];
}

- (MKPinAnnotationView *)getCollegeAnnotationViewWithAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *customPinView;

    // If no pin view already exists, create a new one.
    customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                    reuseIdentifier:ANNOTATION_ID_COLLEGE];
    customPinView.pinColor = MKPinAnnotationColorRed;
    customPinView.animatesDrop = YES;
    customPinView.canShowCallout = YES;

    // Because this is an iOS app, add the detail disclosure button to display details about the annotation in another view.
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:self
                    action:@selector(calloutRightButtonTouched:)
          forControlEvents:UIControlEventTouchUpInside];
    customPinView.rightCalloutAccessoryView = rightButton;

    // Add a custom image to the left side of the callout.
    UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ILSC"]];
    myCustomImage.frame = CGRectMake(0,0,31,31);
    customPinView.leftCalloutAccessoryView = myCustomImage;

    return customPinView;
}

- (MKPinAnnotationView *)getUserAnnotationViewWithAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *customPinView;
    customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                    reuseIdentifier:ANNOTATION_ID_USER];
    customPinView.pinColor = MKPinAnnotationColorGreen;
    customPinView.animatesDrop = YES;
    customPinView.canShowCallout = NO;

    return customPinView;
}

- (void)calloutRightButtonTouched:(UIButton *)sender
{
    NSString *officialLink = [self.propertyList objectForKey:ILSC_BRISBANE_OFFICIAL_LINK_KEY];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:officialLink]];
}

#pragma mark - Add Route

- (void)addRouteToMap
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];

    request.source = [MKMapItem mapItemForCurrentLocation];

    request.destination = self.ilscBrisbaneMapItem;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];

    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             NSLog(@"Error calculating direction: %@", error);
         } else {
             [self showRoute:response];
         }
     }];
}

- (void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [self.mapView addOverlay:route.polyline
                           level:MKOverlayLevelAboveRoads];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor orangeColor];

    [self.mapView setVisibleMapRect:[overlay boundingMapRect]
                        edgePadding:UIEdgeInsetsMake(30.0, 30.0, 30.0, 30.0)
                           animated:YES];

    return renderer;
}

@end
