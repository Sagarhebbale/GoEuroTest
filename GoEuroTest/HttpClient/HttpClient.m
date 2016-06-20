//
//  HttpClient.m
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "HttpClient.h"
#import "JsonMap.h"






static HttpClient *sharedInstance = Nil;

@interface HttpClient()
{
    AFHTTPClient *afHttpClient;
    RKObjectManager *objManager;
    HttpClientCallback callback;
    NSMutableDictionary *restKitManagers;
}

-(void)configure;
-(void)addResponseDescriptorForExtension:(NSString *)extension;
@end
@implementation HttpClient

+(HttpClient *)getInstance
{
    if(sharedInstance == Nil)
        sharedInstance = [[HttpClient alloc] init];
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

-(RKObjectMapping *)mapForUrlPath:(NSString *)path
{
    if([path isEqualToString:Base_Url])
        return getPlacesMap();
    else if([path isEqualToString:Flights_Url] || [path isEqualToString:Trains_Url] || [path isEqualToString:Buses_Url])
        return getTransportModelMap();
    return Nil;
    
}

-(RKObjectManager *)objManagerForUrl:(NSString *)url
{
    return [restKitManagers objectForKey:url];
}

-(void)configure
{
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    afHttpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:Base_Url]];
    restKitManagers = [[NSMutableDictionary alloc] init];
    for(NSString *restUrl in REST_Urls)
    {
        RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:restUrl]];
        ;
        [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[self mapForUrlPath:restUrl]
                                                                                       method:RKRequestMethodGET
                                                                                  pathPattern:Nil
                                                                                      keyPath:Nil
                                                                                  statusCodes:[NSIndexSet indexSetWithIndex:200]]];
        [restKitManagers setObject:objectManager forKey:restUrl];
                                       
    }
        
    objManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:Base_Url]];
    objManager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    [restKitManagers setObject:objManager forKey:Base_Url];
    
}

-(void)addResponseDescriptorForExtension:(NSString *)extension
{
    RKResponseDescriptor *placesResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:getPlacesMap()
                                                 method:RKRequestMethodGET
                                            pathPattern:extension
                                                keyPath:Nil
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [[restKitManagers objectForKey:Base_Url] addResponseDescriptor:placesResponseDescriptor];

}

-(void)getPlacesForTerm:(NSString *)term withCallback:(HttpClientCallback)Callback
{
    callback = Callback;
    [self addResponseDescriptorForExtension:term];
    
    [[restKitManagers objectForKey:Base_Url] getObjectsAtPath:term parameters:Nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         callback((id)mappingResult.array , Nil);
     }
    failure:^(RKObjectRequestOperation *operation, NSError *error) {
         callback(Nil , error);
    }];
    
}

-(void)getTransportDataForUrl:(NSString *)url WithCallback:(HttpClientCallback)Callback
{
    callback = Callback;
    [[self objManagerForUrl:url] getObjectsAtPath:@"" parameters:Nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         callback((id)mappingResult.array , Nil);
     }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  callback(Nil , error);
                                              }];

}





@end
