//
//  ViewController.h
//  DroneMarin
//
//  Created by Hugo Bidois on 09/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController{
    IBOutlet MKMapView *mapView;
}

@property MKMapView *mapView;
@end

