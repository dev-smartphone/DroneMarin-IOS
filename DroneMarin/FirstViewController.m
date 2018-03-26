//
//  FirstViewController.m
//  DroneMarin
//
//  Created by Hugo Bidois on 26/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#import "FirstViewController.h"
#import "parser.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    mapView.delegate =(id)self;
    
    //Set map on a specific position and zoom
    
    CLLocationCoordinate2D userLocation = CLLocationCoordinate2DMake(46.134739, -1.150361);
    CLLocationDistance distance = 50*50;
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation, distance, distance)];
    
    [self performSelectorInBackground:@selector(beginGetData) withObject:nil];
}

- (void) beginGetData {
    app("127.0.0.1");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor redColor]];
        [renderer setLineWidth:3.0];
        return renderer;
    }
    return nil;
}

@end
