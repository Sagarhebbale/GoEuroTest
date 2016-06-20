//
//  LocationObject.m
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "LocationObject.h"

@implementation LocationObject
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;


-(float)distanceInKms:(LocationObject *)geoPosition
{

    return [self kilometersfromPlace:CLLocationCoordinate2DMake(_latitude.doubleValue , _longitude.doubleValue) andToPlace:CLLocationCoordinate2DMake(geoPosition.latitude.doubleValue , geoPosition.longitude.doubleValue)];
    
}
-(float)kilometersfromPlace:(CLLocationCoordinate2D)from andToPlace:(CLLocationCoordinate2D)to  {
    
    CLLocation *userloc = [[CLLocation alloc]initWithLatitude:from.latitude longitude:from.longitude];
    CLLocation *dest = [[CLLocation alloc]initWithLatitude:to.latitude longitude:to.longitude];
    
    CLLocationDistance dist = [userloc distanceFromLocation:dest]/1000;
    
    //NSLog(@"%f",dist);
    NSString *distance = [NSString stringWithFormat:@"%f",dist];
    
    return [distance floatValue];
    
}

@end
