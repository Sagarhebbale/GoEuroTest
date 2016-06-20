//
//  PlacesTableView.m
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "PlacesTableView.h"
#import "PlaceTableViewCell.h"
#import "Datasource.h"

@implementation PlacesTableView
@synthesize places =_places;


-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if(self = [super initWithFrame:frame style:style])
    {
       
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"PlaceCell" bundle:nil] forCellReuseIdentifier:@"PlaceCell"];

}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_places.count > 0)
        return _places.count;
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell"];
    
    if (!cell) {
        cell = [[PlaceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlaceCell"];
    }
    if(_places && indexPath.section <= _places.count)
    {
        PlaceObject *placeObj = [_places objectAtIndex:indexPath.section];
        [[cell cityLabel] setText:placeObj.name];
        [[cell countryLabel] setText:placeObj.country];
        [[cell distanceIndicator] setHidden:NO];
        float distance = [placeObj distanceToLocation:[[Datasource getInstance] lastLocation]];
        [[cell distanceLabel] setText:[NSString stringWithFormat:@"%f Kms",distance]];
        [[cell distanceIndicator] setProgress:distance/[[[_places lastObject] distance] floatValue]];
       
    }
    else
    {
        [[cell cityLabel] setText:@""];
        [[cell countryLabel] setText:@""];
        [[cell distanceLabel] setText:@""];
        [[cell distanceIndicator] setHidden:YES];

    }
    
    
    cell.layer.cornerRadius = 5.0;
    cell.layer.masksToBounds = YES;

    return cell;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
