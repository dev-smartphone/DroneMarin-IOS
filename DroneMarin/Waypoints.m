//
//  Waypoints.m
//  DroneMarin
//
//  Created by Rafa on 25/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Waypoints.h"
@implementation Waypoints

- (id) init {
    isStationnaire = false;
    isPriseImage = false;
    vitesse = 10.0f;
    return self;
}

- (void) setDest:(CLLocationCoordinate2D)maDest {
    dest = maDest;
}

- (CLLocationCoordinate2D) getDest {
    return dest;
}

- (bool) getIsStationnaire {
    return isStationnaire;
}

- (bool) getIsPrimeImage {
    return isPriseImage;
}

- (void) setIsStationnaire: (bool) stationnaire{
    isStationnaire = stationnaire;
}

- (void) setIsPrimeImage:(bool)priseImage {
    isPriseImage = priseImage;
}

- (float) getVitesse {
    return vitesse;
}

- (void) setVitesse:(float)speed {
    vitesse = speed;
}

@end
