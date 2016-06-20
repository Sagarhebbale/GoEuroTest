//
//  Datasource.h
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceObject.h"
#import "TransportModel.h"

/**
 *  The data source class acts as a single class source for all the data required for this app. It is a singleton and can be used in multiple classed to access data. It interacts with the http client and also makes a choice on whehther data needs to be downloaded after checking with the cache
 */

/**
 *  PlaceLoading Callback. A asynchronous call back encapsulating a block callback that returns place objects (NSArray<PlaceObject *> or an NSError if the loading fails)
 *
 *  @param places NSArray<PlaceObject *> returns all the place objects in an NSArray
 *  @param error  NSError, returns error if loading of places has failed.
 */
typedef void (^PlaceLoadingCallBack)(NSArray *places , NSError *error);
/**
 *  Transport Callback. A asynchronou call back encapsulating a block callback that returns transport objects (NSArray<TransportModel *> or an NSError if the loading fails)
 *
 *  @param transportData NSArray<TransportModel *> returns all the transport models objects in an NSArray
 *  @param error  NSError, returns error if loading of places has failed.
 */
typedef void (^TransportDataLoadingCallBack)(NSArray *transportData , NSError *error);
/**
 *  Location Loading Callback. A asynchronou call back encapsulating a block callback that returns the users current location after it has been acquired
 *
 *  @param lastLocation CLLocation returns the last updated location as a CLLocation
 *  @param error  NSError, returns error if loading of location has failed.
 */
typedef void (^LocationLoadingCallBack)(CLLocation *lastLocation , NSError *error);

@interface Datasource : NSObject<CLLocationManagerDelegate>
/**
 *  Last location property with the last updated location of the user
 */
@property(nonatomic , retain)CLLocation *lastLocation;
/**
 *  Max distance for the furtherest place from the users location to all queried places.
 */
@property(nonatomic)float maxDistance;


/**
 *  Singleton access method
 *
 *  @return A shared single instance of this Datasource Class
 */
+(Datasource *)getInstance;
/**
 *  Initialize method
 *
 *  @return Way to configure and initialize this class
 */
-(id)init;
/**
 *  Methiod to Initialize location manager and get last updated location
 *
 *  @param locationLoadCallback Last updated location as an asynchronous callback
 */
-(void)initLocationManager:(LocationLoadingCallBack)locationLoadCallback;
/**
 *  Methiod to query if the location manager has been started
 *
 *  @return Yes if location manager has been staretd.  No otherwise
 */
-(BOOL)isLocationManagerInitialized;

/**
 *  Query method to get place objects. This class checks for a local copy of the place objects and queries it remotley only if the local copies are absent
 *
 *  @param term     The search term passed while qurying for a place
 *  @param Callback Asynchronous callback as a PlaceLoaingCallBack structure.
 */
-(void)getPlaceObjects:(NSString *)term withCallback:(PlaceLoadingCallBack)Callback;
/**
 *  Query method to get transport models.
 *  @param type     The transport type passed so that a query may be made to the appropriate transport type
 *  @param Callback Asynchronous callback as a TransportLoadingCallback structure.
 */
-(void)getTransportDataForTransportType:(TransportType)type forCallbacl:(TransportDataLoadingCallBack)callback;
/**
 *  Method to do a purley local query of all transport models
 *
 *  @param type The transport type to be passed for the concerning transport models
 *
 *  @return NSArray of all transport models for a certain transport type
 */
-(NSArray *)getTransportModelsFromLocalStore:(TransportType)type;
/**
 *  Method to sort by price and query locally for transport models
 *
 *  @param type        The transport type to be passed for the concerning transport models
 *  @param isAscending Bool parameter to state how he sorting should be done (Ascending/Descending)
 *
 *  @return NSArray of all transport models sorted by Price
 */
-(NSArray *)getSortedTransportModelsFromLocalStore:(TransportType)type Ascending:(BOOL)isAscending;

@end
