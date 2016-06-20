//
//  PlacesTableView.h
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceObject.h"

@interface PlacesTableView : UITableView<UITableViewDelegate , UITableViewDataSource>
@property(nonatomic , retain)NSArray *places;


-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

@end
