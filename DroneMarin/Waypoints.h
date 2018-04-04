//
//  Waypoints.h
//  DroneMarin
//
//  Created by Rafa on 25/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Waypoints : NSObject
{
    bool isStationnaire;
    bool isPriseImage;
    float vitesse;
    CLLocationCoordinate2D dest;
    MKPointAnnotation *annot;
    NSString *trameNmea;
}

- (id) init;
- (void) setDest: (CLLocationCoordinate2D) dest;
- (CLLocationCoordinate2D) getDest;
- (bool) getIsStationnaire;
- (bool) getIsPrimeImage;
- (void) setIsStationnaire: (bool)stationnaire;
- (void) setIsPrimeImage: (bool)priseImage;
- (float) getVitesse;
- (void) setVitesse: (float)speed;
- (MKPointAnnotation *) getAnnot;
- (void) setAnnot: (MKPointAnnotation *)annotation;
- (void) setTrame: (NSString *)trame;
- (NSString *) getTrame;
@end
