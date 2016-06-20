//
//  Datasource.m
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "Datasource.h"
#import "HttpClient.h"

static Datasource *sharedInstance = Nil;

@interface Datasource()
{
    NSMutableDictionary<NSString *,NSArray *> *places;
    NSMutableDictionary<NSString * , NSArray *> *transportModels;
    HttpClient *httpClient;
    PlaceLoadingCallBack callback;
    LocationLoadingCallBack locationLoadingCallback;
    CLLocationManager *locationManager;
    
}

-(void)configure;
-(NSArray *)getPlacesFromLocalStore:(NSString *)term;
-(void)addPlacesToLocalStore:(NSArray *)places WithTerm:(NSString *)term;
-(void)computeDistanceForPlaces:(NSArray *)placeObjects;
-(NSArray *)sortPlaceObjects:(NSArray *)placeObjects;
-(void)addTransportModelToLocalStore:(NSArray *)transportData ForType:(TransportType)type;

@end
@implementation Datasource
@synthesize lastLocation = _lastLocation;
@synthesize maxDistance = _maxDistance;


+(Datasource *)getInstance
{
    if(sharedInstance == Nil)
        sharedInstance = [[Datasource alloc] init];
    return sharedInstance;
}


-(id)init
{
  if(self = [super init])
  {
      [self configure];
  }
    return self;
}


-(void)configure
{
    httpClient = [HttpClient getInstance];
    
}

-(void)initLocationManager:(LocationLoadingCallBack)LocationLoadCallback
{
    if(![self isLocationManagerInitialized])
    {
        locationLoadingCallback = LocationLoadCallback;
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];
        
        self.maxDistance = -1;

    }
}


-(BOOL)isLocationManagerInitialized
{
    return (locationManager != Nil);
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.lastLocation = newLocation;
    if (!self.lastLocation)
    {   if(locationLoadingCallback)
        {
            locationLoadingCallback(self.lastLocation , Nil);
            locationLoadingCallback = Nil;
            [locationManager stopUpdatingLocation];
        }

    }
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(locationLoadingCallback)
    {
        locationLoadingCallback(Nil , error);
        locationLoadingCallback = Nil;
    }
}


-(void)getPlaceObjects:(NSString *)term withCallback:(PlaceLoadingCallBack)Callback
{
    callback = Callback;
    if([self getPlacesFromLocalStore:term])
    {
        callback([self getPlacesFromLocalStore:term] , Nil);
    }
    else
    {
        [httpClient getPlacesForTerm:term withCallback:^(id response , NSError *error)
         {
            if(!error)
            {
                [self addPlacesToLocalStore:(NSArray *)response WithTerm:term];
                callback([places objectForKey:term] , Nil);
            }
            else
            {
                callback(Nil , error);
            }
         }];
    }
    
}

-(void)getTransportDataForTransportType:(TransportType)type forCallbacl:(TransportDataLoadingCallBack)Callback
{
    callback = Callback;
    if([self getTransportModelsFromLocalStore:type])
    {
        callback([self getTransportModelsFromLocalStore:type] , Nil);
    }
    else
    {
        [httpClient getTransportDataForUrl:[TransportModel urlForTransportType:type] WithCallback:^(id response , NSError *error)
         {
             if(!error)
             {
                 [self addTransportModelToLocalStore:response ForType:type];
                 callback(response , Nil);
             }
             else
             {
                 callback(Nil , error);
             }

         }];
        
    }
}

-(void)addTransportModelToLocalStore:(NSArray *)transportData ForType:(TransportType)type
{
    if(!transportModels)
        transportModels = [[NSMutableDictionary alloc] init];
    [transportModels setObject:transportData forKey:[NSString stringWithFormat:@"%d",type]];
    
        
}

-(void)addPlacesToLocalStore:(NSArray *)Places WithTerm:(NSString *)term
{
    
    if(!places)
        places = [[NSMutableDictionary alloc] init];
    [self computeDistanceForPlaces:Places];
    [places setObject:[self sortPlaceObjects:Places] forKey:term];
}

-(void)computeDistanceForPlaces:(NSArray *)placeObjects
{
    for(PlaceObject *placeObj in placeObjects)
    {
        float currentDistance = [placeObj distanceToLocation:_lastLocation];
        placeObj.distance = [NSNumber numberWithFloat:currentDistance];
            
    }
    
}
    


-(NSArray *)sortPlaceObjects:(NSArray *)placeObjects
{
    NSMutableArray *placeObjectsCopy = [[NSMutableArray alloc] initWithArray:placeObjects];
    NSArray *sortedArray = [placeObjectsCopy sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES]]];
    
    return sortedArray;
     
 

}

-(NSArray *)getPlacesFromLocalStore:(NSString *)term
{
    NSArray *allTerms = [places allKeys];
    for(NSString *placeTerm in allTerms)
    {
        if([placeTerm isEqualToString:term])
        {
            return [places objectForKey:placeTerm];
        }
    }
    
    return Nil;
}

-(NSArray *)getTransportModelsFromLocalStore:(TransportType)type
{
    return [transportModels objectForKey:[NSString stringWithFormat:@"%d",type]];
}

-(NSArray *)getSortedTransportModelsFromLocalStore:(TransportType)type Ascending:(BOOL)isAscending
{
    NSArray *models = [transportModels objectForKey:[NSString stringWithFormat:@"%d",type]];
    return [models sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"priceInEuro" ascending:isAscending]]];
    
}




@end
