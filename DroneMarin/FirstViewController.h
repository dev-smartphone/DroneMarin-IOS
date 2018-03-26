//
//  FirstViewController.h
//  DroneMarin
//
//  Created by Hugo Bidois on 26/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#ifndef FirstViewController_h
#define FirstViewController_h


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FirstViewController : UIViewController{
    IBOutlet MKMapView *mapView;
}

@property MKMapView *mapView;
@end

#endif /* FirstViewController_h */
