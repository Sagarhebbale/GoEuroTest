//
//  JsonMap.h
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#ifndef JsonMap_h
#define JsonMap_h
#import "PlaceObject.h"
#import "TransportModel.h"
#import <RestKit/RestKit.h>


#define PlaceObjectMap @{@"_id":@"guid",@"key":@"key",@"name":@"name",@"fullName":@"fullName",@"iata_airport_code":@"iataAirportCode",@"type":@"type",@"country":@"country",@"locationId":@"locationID",@"inEurope":@"inEurope",@"countryId":@"countryID",@"countryCode":@"countryCode",@"coreCountry":@"coreCountry",@"distance":@"distance",@"names":@"namesInLanguages",@"alternativeNames":@"alternativeNames"}

#define TransportObjetMap @{@"id":@"guid",@"provider_logo":@"logoUrl",@"price_in_euros":@"priceInEuro",@"arrival_time":@"arrivalTime",@"departure_time":@"departureTime",@"number_of_stops":@"numberOfStops"}

#define LocationObjectMap @[@"latitude",@"longitude"]

/**
 *  Method to get a Mapping from the JSON response for place objects and the PlaceObject Class
 *
 *  @return Mapping as a RKObjectMappingClass
 */
static inline RKObjectMapping* getPlacesMap()
{
    RKObjectMapping *placesMap = [RKObjectMapping mappingForClass:[PlaceObject class]];
    [placesMap addAttributeMappingsFromDictionary:PlaceObjectMap];
    
    RKObjectMapping *locationMap = [RKObjectMapping mappingForClass:[LocationObject class]];
    [locationMap addAttributeMappingsFromArray:LocationObjectMap];
    
    [placesMap addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"geo_position" toKeyPath:@"geoPosition" withMapping:locationMap]];
    
    return placesMap;

}
/**
 *  Method to get a Mapping from the JSON response for transport objects and the Transport ModelClass
 *
 *  @return Mapping as a RKObjectMapping class
 */
static inline RKObjectMapping* getTransportModelMap()
{
    RKObjectMapping *placesMap = [RKObjectMapping mappingForClass:[TransportModel class]];
    [placesMap addAttributeMappingsFromDictionary:TransportObjetMap];
    
    return placesMap;
    
}

#endif /* JsonMap_h */
