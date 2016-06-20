//
//  PlaceTableViewCell.h
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceTableViewCell : UITableViewCell
@property(nonatomic , retain)IBOutlet UILabel *cityLabel;
@property(nonatomic , retain)IBOutlet UILabel *countryLabel;
@property(nonatomic , retain)IBOutlet UILabel *distanceLabel;
@property(nonatomic , retain)IBOutlet UIProgressView *distanceIndicator;
@end
