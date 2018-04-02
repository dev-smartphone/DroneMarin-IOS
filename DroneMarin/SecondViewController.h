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
}

@property MKMapView *mapView;
@property UIButton *valideWaypoints;

-(IBAction) buttonClick:(id)sender;
@end

