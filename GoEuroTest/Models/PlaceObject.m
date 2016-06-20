//
//  PlaceObject.m
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "PlaceObject.h"

@implementation PlaceObject
@synthesize guid = _guid;
@synthesize name = _name;
@synthesize locationID = _locationID;
@synthesize countryID = _countryID;
@synthesize distance = _distance;
@synthesize key = _key;
@synthesize fullName = _fullName;
@synthesize iataAirportCode = _iataAirportCode;
@synthesize type = _type;
@synthesize country = _country;
@synthesize countryCode = _countryCode;
@synthesize namesInLanguages = _namesInLanguages;
@synthesize alternativeNames = _alternativeNames;
@synthesize inEurope = _inEurope;
@synthesize coreCountry = _coreCountry;
@synthesize geoPosition = _geoPosition;


+(NSDateFormatter *)defaultDateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd:MM:yyyy"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    return dateFormatter;
}
-(float)distanceTo:(LocationObject *)position
{
    return [_geoPosition distanceInKms:position];
}

-(float)distanceToLocation:(CLLocation *)location
{
    LocationObject *locObj = [[LocationObject alloc] init];
    locObj.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
    locObj.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
    
    return [_geoPosition distanceInKms:locObj];
}
@end
