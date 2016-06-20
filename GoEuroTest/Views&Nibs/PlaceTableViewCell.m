//
//  PlaceTableViewCell.m
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "PlaceTableViewCell.h"

@implementation PlaceTableViewCell
@synthesize cityLabel = _cityLabel;
@synthesize countryLabel = _countryLabel;
@synthesize distanceLabel = _distanceLabel;
@synthesize distanceIndicator = _distanceIndicator;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
