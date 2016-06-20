//
//  TransportTableViewController.m
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "TransportTableViewController.h"
#import "TransportTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UICommons.h"

@interface TransportTableViewController ()
{
    Datasource *datasource;
    NSMutableArray *transportModels;
    BOOL sortAscending;
    LGAlertView *loadIndicator;
    
    
}

-(void)sortButtonPressed:(id)sender;
-(void)showLoadingIndicator;
-(void)invalidateLoadingIndicator;
@end

@implementation TransportTableViewController
@synthesize tableView = _tableView;
@synthesize transportType = _transportType;

#pragma mark Nib Creation Method
+(UINavigationController *)createFromNib
{
    UINavigationController *navController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:TransportNavController_Identifier];
    navController.navigationBarHidden = NO;
    return navController;
}

#pragma mark UIViewController Overrides
- (void)viewDidLoad
{
    [super viewDidLoad];
    datasource = [Datasource getInstance];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = Nil;
    sortAscending = YES;
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(_tableView.dataSource != self)
    {
    [self showLoadingIndicator];
      [datasource getTransportDataForTransportType:_transportType forCallbacl:^(NSArray *transportData , NSError *error)
         {
             if(!error && transportData.count > 0)
             {   _tableView.delegate = self;
                 _tableView.dataSource = self;
                 transportModels = [[NSMutableArray alloc] initWithArray:transportData];
                 [self.tableView reloadData];
                 [self invalidateLoadingIndicator];
             }
         }];
        

    }
    
}

#pragma mark Load Indicator Handlers
-(void)showLoadingIndicator
{
    if(!loadIndicator)
        loadIndicator = loadingIndicator();
    if(!loadIndicator.isShowing)
        [loadIndicator showAnimated:YES completionHandler:Nil];
    
}

-(void)invalidateLoadingIndicator
{
    if(loadIndicator.isShowing)
    {
        [loadIndicator dismissAnimated:YES completionHandler:Nil];
        loadIndicator = Nil;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


#pragma mark UITableViewDataSource & UITableViewDelegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [transportModels count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TransportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TransportTableViewCell_ReuseID];
    
    if (!cell) {
        cell = [[TransportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TransportTableViewCell_ReuseID];
    }
    
        TransportModel *transportObj = [transportModels objectAtIndex:indexPath.section];
        [[cell costLabel] setAttributedText:[transportObj priceAttributedString]];
        [[cell timeLabel] setText:[transportObj timesString]];
        [[cell durationLabel] setText:[transportObj durationString]];
        [[cell logoImageView] sd_setImageWithURL:[NSURL URLWithString:[transportObj logoUrlString]]];
        
    cell.layer.cornerRadius = 2.0;
    cell.layer.masksToBounds = YES;
    
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [alertWithTitleAndMessage(@"Offer Error!",@"Offer details are not yet implemented!") showAnimated:YES completionHandler:Nil];
}

#pragma mark Button Handlers
-(IBAction)sortButtonPressed:(id)sender
{
   if(_tableView.dataSource)
   {
       transportModels = Nil;
       transportModels = [[NSMutableArray alloc] initWithArray:[datasource getSortedTransportModelsFromLocalStore:_transportType Ascending:sortAscending]];
       sortAscending = !sortAscending;
       [_tableView reloadData];
       
   }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
