//
//  HttpClient.h
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Base_Url @"http://api.goeuro.com/api/v2/position/suggest/de"

/**
 *  Callback structure for http data loading
 *
 *  @param responseData Response data as id depending on the type of response recieved by the http client
 *  @param error        Error response on failure while loading a response
 */
typedef void (^HttpClientCallback)(id responseData , NSError *error);

@interface HttpClient : NSObject

/**
 *  Singleton Access Method
 *
 *  @return Single shared instance of the HttpClient class
 */
+(HttpClient *)getInstance;
/**
 *  Method to initialize and configure HttpClient
 *
 *  @return Configured and initialied HttpClient class
 */
-(id)init;
/**
 *  Method to remotley query for PlaceObjects for a search term
 *
 *  @param term     Passed search term based on which places are loaded
 *  @param Callback Asynchronous callback block as  HttpClientCallback called after the respose is loaded.
 */
-(void)getPlacesForTerm:(NSString *)term withCallback:(HttpClientCallback)Callback;
/**
 *  Method to remotley query for TransportModels
 *
 *  @param url      The remote URL source to load the transport model
 *  @param Callback Asynchronous callback block as  HttpClientCallback called after the respose is loaded.
 */
-(void)getTransportDataForUrl:(NSString *)url WithCallback:(HttpClientCallback)Callback;


@end
