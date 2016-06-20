//
//  TransportTableViewCell.m
//  GoEuroTest
//
// Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "TransportTableViewCell.h"

@implementation TransportTableViewCell
@synthesize logoImageView = _logoImageView;
@synthesize timeLabel = _timeLabel;
@synthesize costLabel = _costLabel;
@synthesize durationLabel = _durationLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    _logoImageView.clipsToBounds = YES;
    
    _timeLabel.textColor = [UIColor grayColor];
    _durationLabel.textColor = [UIColor grayColor];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
