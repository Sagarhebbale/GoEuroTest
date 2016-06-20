//
//  LocationObject.h
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 *  Location object that encapsulated the location object in latitude and longitude
 */
@interface LocationObject : NSObject
/**
 *  latitude as a NSNumber(double)
 */
@property(nonatomic , retain)NSNumber *latitude;
/**
 *  longitude as a NSNumber(double)
 */
@property(nonatomic , retain)NSNumber *longitude;

/**
 *  Instance method to compute distances given another Location object as a reference
 *
 *  @param geoPosition Geo position using which distance is computed
 *
 *  @return Computed distance as a float
 */
-(float)distanceInKms:(LocationObject *)geoPosition;
@end
