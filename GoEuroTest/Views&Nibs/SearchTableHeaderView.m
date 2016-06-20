//
//  SearchTableHeaderView.m
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "SearchTableHeaderView.h"

@interface SearchTableHeaderView()
{
    DGActivityIndicatorView *loadingSpinner;
 
}



@end
@implementation SearchTableHeaderView
@synthesize titleLabel = _titleLabel;



- (id)initWithNib
{
    UINib *nib = [UINib nibWithNibName:@"SearchTableViewHeader" bundle:[NSBundle mainBundle]];
    self = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    self.tag = kHeaderViewTag;
    return self;
}
- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if(self){
        
    }
    return self;
}
- (void)awakeFromNib
{
    _titleLabel.hidden = YES;
    _titleLabel.hidden = YES;
    _titleLabel.text = @"Nearby Places";
    loadingSpinner = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor whiteColor] size:20.0f];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:loadingSpinner];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    loadingSpinner.frame = CGRectMake(self.frame.size.width/2 - 25, self.frame.size.height/2 - 25, 50.0f, 50.0f);
    
 
    
    
}

-(void)showLoadingIndicator
{
    if(self.backgroundColor == [UIColor clearColor])
    {
        [UIView animateWithDuration:1.0 animations:^(void)
         {
             self.backgroundColor = [UIColor colorWithRed:31.0/255.0 green:74.0/255.0 blue:109.0/255.0 alpha:1.0];
         }];
        
        
    }
   
    _titleLabel.hidden = YES;
    loadingSpinner.hidden = NO;
    [loadingSpinner startAnimating];
}

-(void)hideLoadingIndicator:(BOOL)shouldShowTitle
{
    _titleLabel.hidden = NO;
    [loadingSpinner stopAnimating];
    loadingSpinner.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
