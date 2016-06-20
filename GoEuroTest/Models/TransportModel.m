//
//  TransportModel.m
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "TransportModel.h"


static NSDateFormatter *defaultDateFormatter = Nil;

@implementation TransportModel
@synthesize  transportType = _transportType;
@synthesize  numberOfStops = _numberOfStops;
@synthesize  priceInEuro = _priceInEuro;
@synthesize  guid = _guid;
@synthesize  logoUrl = _logoUrl;
@synthesize  departureTime = _departureTime;
@synthesize  arrivalTime = _arrivalTime;


+(NSDate *)getDateForString:(NSString *)inputString
{
    return [[TransportModel defaultDateFormatter] dateFromString:inputString];
}

+(NSString *)getFormattedDateString:(NSString *)inputString
{
    return [[TransportModel defaultDateFormatter] stringFromDate:[TransportModel getDateForString:inputString]];
}


+(NSString *)urlForTransportType:(TransportType)type
{
    switch (type) {
        case TransportTypeBus:
            return Buses_Url;
            break;
        case TransportTypeTrain:
            return Trains_Url;
            break;
        case TransportTypeFlight:
            return Flights_Url;
        default:
            return Nil;
            break;
    }
}

+(NSString *)titleForTransportType:(TransportType)type
{
    switch (type) {
    case TransportTypeBus:
        return @"Bus";
        break;
    case TransportTypeTrain:
        return @"Train";
        break;
    case TransportTypeFlight:
            return @"Flight";
            break;
    default:
        return Nil;
        break;
    }

}

+(NSDateFormatter *)defaultDateFormatter
{
    if(!defaultDateFormatter)
    {
        defaultDateFormatter = [[NSDateFormatter alloc] init];
        [defaultDateFormatter setDateFormat:@"HH:mm"];
        [defaultDateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [defaultDateFormatter setLocale:[NSLocale currentLocale]];
    }
    return defaultDateFormatter;
}

-(NSAttributedString *)priceAttributedString
{
    NSMutableAttributedString *priceInEuroString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\u20ac%0.2f",_priceInEuro]];

    
    [priceInEuroString addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:20.0]
                              range:NSMakeRange(0, 3)];
    

    
    return priceInEuroString;
    
}

-(NSString *)timesString
{
    return [NSString stringWithFormat:@"%@ - %@",[TransportModel getFormattedDateString:_departureTime],[TransportModel getFormattedDateString:_arrivalTime]];
}

-(NSString *)durationString
{
    NSLog(@"%@",_arrivalTime);
    NSDate *arrivalDate = [[TransportModel defaultDateFormatter] dateFromString:_arrivalTime];
    NSDate *departureDate = [[TransportModel defaultDateFormatter] dateFromString:_departureTime];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:departureDate toDate:arrivalDate options:0];
    
    return [NSString stringWithFormat:@"%ld:%ldh",(long)components
            .hour,(long)components.minute];
    
    
}

-(NSString *)logoUrlString
{
    return [_logoUrl stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
}
@end
