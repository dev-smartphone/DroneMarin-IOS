//
//  Modele.h
//  DroneMarin
//
//  Created by Rafa on 26/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Waypoints.h"

@interface Modele : NSObject
{
    NSMutableArray *monTabWaypoints;
    NSMutableArray *monTabPolyline;
}

- (id) init;
- (int) getNbWaypoints;
- (void) addWaypoint: (Waypoints*)waypoint;
- (Waypoints*) getWaypointAtIndex: (int)index;
- (NSMutableArray*)getArray;
- (void)deleteWaypoint:(Waypoints *)waypoint;
- (void)addPoyline:(MKPolyline *)polyline;
- (NSMutableArray*)getPolylineArray;
@end
