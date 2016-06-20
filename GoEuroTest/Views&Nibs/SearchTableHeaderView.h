//
//  SearchTableHeaderView.h
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"

#define kHeaderViewTag 100

@interface SearchTableHeaderView : UIView
@property(nonatomic , weak)IBOutlet UILabel *titleLabel;


-(id)initWithNib;
-(void)showLoadingIndicator;
-(void)hideLoadingIndicator:(BOOL)shouldShowTitle;

@end
