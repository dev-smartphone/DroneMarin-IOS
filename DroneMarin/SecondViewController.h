//
//  ViewController.h
//  DroneMarin
//
//  Created by Hugo Bidois on 09/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SecondViewController : UIViewController{
    IBOutlet MKMapView *mapView;
    IBOutlet UIButton *valideWaypoints;
    IBOutlet UIButton *exporterWaypoints;
}

@property MKMapView *mapView;
@property UIButton *valideWaypoints;
@property UIButton *exporterWaypoints;

-(IBAction) buttonClick:(id)sender;
-(IBAction) exporterClick:(id)sender;
@end

