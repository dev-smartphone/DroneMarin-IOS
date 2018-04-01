//
//  Modele.m
//  DroneMarin
//
//  Created by Rafa on 26/03/2018.
//  Copyright © 2018 dev-smartphone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Modele.h"

@implementation Modele

- (id) init {
    monTabWaypoints = [NSMutableArray array];
    return self;
}

- (int)getNbWaypoints {
    return (int)monTabWaypoints.count;
}

- (Waypoints *)getWaypointAtIndex:(int)index {
    return [monTabWaypoints objectAtIndex:index];
}

- (void)addWaypoint:(Waypoints *)waypoint {
    [monTabWaypoints addObject:waypoint];
}

- (void)addPoyline:(MKPolyline *)polyline {
    [monTabWaypoints addObject:polyline];
}

-(NSMutableArray*)getArray {
    return monTabWaypoints;
}

-(NSMutableArray*)getPolylineArray {
    return monTabPolyline;
}

-(void)deleteWaypoint:(Waypoints *)waypoint {
    [monTabWaypoints removeObject:waypoint];
}

@end
