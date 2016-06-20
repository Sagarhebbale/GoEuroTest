//
//  TransportModel.h
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Transport Model Class encapsulates the information of a transport offer. It has the fields and the necessary methoods to store and manipulate the transport offer data
 */

/**
 *  URL Sources for Flights, Trains & Bus Data
 *
 *  @return String with appropriate URL
 */
#define Flights_Url @"https://api.myjson.com/bins/w60i"
#define Trains_Url @"https://api.myjson.com/bins/3zmcy"
#define Buses_Url @"https://api.myjson.com/bins/37yzm"

#define REST_Urls @[Flights_Url,Trains_Url,Buses_Url]

/**
 *  Enumeration that lists all the different transport types possible. Currently, Bus, train and Flights stated.
 */
typedef enum{
    TransportTypeTrain = 0,
    TransportTypeBus = 2,
    TransportTypeFlight = 4,
}TransportType;


@interface TransportModel : NSObject
/**
 *  Property for type of transport
 */
@property(nonatomic)TransportType transportType;
/**
 *  Property as a NSNumber showing number of stops of this transport offer.
 */
@property(nonatomic , retain)NSNumber* numberOfStops;
/**
 *  Property as a float showing price in euros for this transport offer
 */
@property(nonatomic)float priceInEuro;
/**
 *  Property as a string for the unique id of this transport offer
 */
@property(nonatomic , retain)NSString *guid;
/**
 *  Property for the remote url holding the logo image for the provider of this transport offer
 */
@property(nonatomic , retain)NSString *logoUrl;
/**
 *  Property as a string holding the departure time of this Transport offer.
 */
@property(nonatomic , retain)NSString *departureTime;
/**
 *  Property as a string holding the arrival time of this Transport offer.
 */

@property(nonatomic , retain)NSString *arrivalTime;

/**
 *  Class method to return the remote url source for data of a certain transport type
 *
 *  @param type The transport Type as enumerated by the type TransportType
 *
 *  @return The remote url as a string which can be used to get the transport data.
 */
+(NSString *)urlForTransportType:(TransportType)type;
/**
 *  Class method to return a title for a given ransport type
 *
 *   @param type The transport Type as enumerated by the type TransportType
 *
 *  @return Title for the transport type as a string
 */
+(NSString *)titleForTransportType:(TransportType)type;
/**
 *  Method to return a formated and styled string of the price of this transport model offer.
 *
 *  @return String of the price as NSAttributedString
 */
-(NSAttributedString *)priceAttributedString;
/**
 *  Method to return formatted string for arrival and departure time
 *
 *  @return Return strind as DepartureDate:ArrivalDate
 */
-(NSString *)timesString;
/**
 *  Method to return duration of travel of this transport offer
 *
 *  @return Returns duration in Hours:Minutes between arrrival and departure time
 */
-(NSString *)durationString;
/**
 *  Method to return Complete logo url of the remote source for the logo of the offer provider
 *
 *  @return Remote url for the logo as a string
 */
-(NSString *)logoUrlString;


@end
