//
//  ViewController.m
//  DroneMarin
//
//  Created by Hugo Bidois on 09/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mapView, polyline, lineView;
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    
    //Non fonctionel
    [self.mapView removeOverlay:self.polyline];

    CLLocationCoordinate2D coordinates[2];
    CLLocationCoordinate2D userLocation = CLLocationCoordinate2DMake(46.1620507, -1.2463008);
    CLLocationCoordinate2D userLocation2 = CLLocationCoordinate2DMake(48.8588377, 2.2770207);
    coordinates[0] = userLocation;
    coordinates[1] = userLocation2;
    MKPolyline *polyline2 = [MKPolyline polylineWithCoordinates:coordinates count:2];
    [self.mapView addOverlay:polyline2];
    self.polyline = polyline2;
    
    [mapView addGestureRecognizer:tgr];
}

-(void)tapGestureHandler:(UITapGestureRecognizer *)tgr
{
    CGPoint touchPoint = [tgr locationInView:mapView];
    CLLocationCoordinate2D touchMapCoordinate = [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc]init];
    point1.coordinate = touchMapCoordinate;
    [mapView addAnnotation:point1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
