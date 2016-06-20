//
//  PlaceObject.h
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationObject.h"

/**
 *  Place Object that encapsulates all the travel data of a place required for travel information..
 */
@interface PlaceObject : NSObject
/**
 *  Unique guid of a place object
 */
@property(nonatomic , retain)NSNumber *guid;
/**
 *  Name of the place
 */
@property(nonatomic , retain)NSString *name;
/**
 *  Location ID of a particular place
 */
@property(nonatomic , retain)NSNumber *locationID;
/**
 *  CountryID for the country this place belongs to
 */
@property(nonatomic , retain)NSNumber *countryID;
/**
 *  Distance from this place to the users location (computed at run time)
 */
@property(nonatomic , retain)NSNumber *distance;
/**
 *  Key describing the place
 */
@property(nonatomic , retain)NSString *key;
/**
 *  Full name of the place
 */
@property(nonatomic , retain)NSString *fullName;
/**
 *  The airport code as provided by IATA if any
 */
@property(nonatomic , retain)NSString *iataAirportCode;
/**
 *  The type of place this belongs to
 */
@property(nonatomic , retain)NSString *type;
/**
 *  Name of the country this plae belongs to
 */
@property(nonatomic , retain)NSString *country;
/**
 *  The accepeted country code for the country the place belongs to
 */
@property(nonatomic , retain)NSString *countryCode;
/**
 *  Name of this place in other languages
 */
@property(nonatomic , retain)NSDictionary *namesInLanguages;
/**
 *  Altrnative accepted names of this place
 */
@property(nonatomic , retain)NSDictionary *alternativeNames;
/**
 *  Location of this place in latitude and longitude as specified by the LocationObject
 */
@property(nonatomic , retain)LocationObject *geoPosition;
/**
 *  Bool stating if this place is in europe
 */
@property(nonatomic)BOOL inEurope;
/**
 *  Bool describing if this place is in a core country
 */
@property(nonatomic)BOOL coreCountry;

/**
 *  Method to compute the distance of this place from a given location
 *
 *  @param position From location using which the distance has to be computed
 *
 *  @return Distance as a float
 */
-(float)distanceTo:(LocationObject *)position;
/**
 *  Method to compute the distance of this place from a given location
 *
 *  @param position From location as a CLLocation using which the distance has to be computed
 *
 *  @return Distance as a float
 */
-(float)distanceToLocation:(CLLocation *)location;
/**
 *  factory to create and get default date formatter for the dates used by this object
 *
 *  @return Date formatter as NSDateFormatter
 */
+(NSDateFormatter *)defaultDateFormatter;


@end
