//
//  TransportTableViewCell.h
//  GoEuroTest
//
// Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <UIKit/UIKit.h>


#define TransportTableViewCell_ReuseID @"TransportTableCell"

@interface TransportTableViewCell : UITableViewCell
@property(nonatomic , retain)IBOutlet UIImageView *logoImageView;
@property(nonatomic , retain)IBOutlet UILabel *timeLabel;
@property(nonatomic , retain)IBOutlet UILabel *costLabel;
@property(nonatomic , retain)IBOutlet UILabel *durationLabel;
@end
