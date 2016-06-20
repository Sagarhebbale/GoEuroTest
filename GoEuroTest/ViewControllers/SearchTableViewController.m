//
//  SearchTableViewController.m
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "SearchTableViewController.h"
#import "Datasource.h"
#import "DGActivityIndicatorView.h"
#import "SearchTableHeaderView.h"

@interface SearchTableViewController ()
{
    NSMutableArray *records;
    Datasource *datasource;
    SearchTableHeaderView *tableViewHeader;
    CGSize keyBoardSize;
    BOOL isKeyboarsShown;
}
-(void)showLoadingSpinner;
-(void)invalidateLoadingSpinner;
-(void)dismissButtonPressed;
-(void)addResults:(NSArray *)results toTableViewWithError:(NSError *)error;
@end


@implementation SearchTableViewController
@synthesize searchBar = _searchBar;
@synthesize tableView = _tableView;
@synthesize delegate = _delegate;
@synthesize searchType = _searchType;
@synthesize dismissButton = _dismissButton;


#pragma Mark Search Update Methods
-(void)addResults:(NSArray *)places toTableViewWithError:(NSError *)error
{
    if(places && places.count > 0)
    {
        [_tableView setPlaces:places];
        
        if(isKeyboarsShown)
            [_tableView setFrame:CGRectMake(0,_searchBar.frame.origin.y + _searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - (_searchBar.frame.origin.y + _searchBar.frame.size.height))];
        
        _tableView.userInteractionEnabled = YES;
        [_tableView reloadData];
    }
    else
    {
        _tableView.userInteractionEnabled = NO;
    }
    
    [self performSelectorOnMainThread:@selector(invalidateLoadingSpinner) withObject:Nil waitUntilDone:NO];

    
}

#pragma mark UIViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
     datasource = [Datasource getInstance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    _dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(8, [[UIApplication sharedApplication] statusBarFrame].size.height, 40, 40)];
    [_dismissButton addTarget:self action:@selector(dismissButtonPressed) forControlEvents:UIControlEventTouchDown];
    [_dismissButton setImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, _dismissButton.frame.size.height + _dismissButton.frame.origin.y + 8, self.view.frame.size.width, 44)];
    [_searchBar setBarTintColor:[UIColor colorWithRed:33.0/255.0 green:73.0/255.0 blue:108.0/255.0 alpha:1.0]];
    
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeyDone;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:_searchBar action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.items = [NSArray arrayWithObject:barButton];
    
    _searchBar.inputAccessoryView = toolbar;
    [self.view addSubview:_dismissButton];
    [self.view addSubview:_searchBar];
    self.view.backgroundColor = [UIColor whiteColor];


}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_tableView)
    {
        _tableView = [[PlacesTableView alloc] initWithFrame:CGRectMake(0,_searchBar.frame.origin.y + _searchBar.frame.size.height , self.view.frame.size.width, self.view.frame.size.height - (_searchBar.frame.origin.y + _searchBar.frame.size.height)) style:UITableViewStylePlain];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.userInteractionEnabled = NO;
        [self.view addSubview:_tableView];

    }
    
   
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(didMakeSelection:forSearchType:)])
    {
        [self.delegate didMakeSelection:[_tableView.places objectAtIndex:indexPath.section] forSearchType:_searchType];
       
    }
    
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 80;
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        if(!tableViewHeader)
            tableViewHeader = [[SearchTableHeaderView alloc] initWithNib];
        return tableViewHeader;
    }
    return Nil;
}


#pragma Mark SearchBar Delegate Methods
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchBar.text.length > 2)
    {   _tableView.delegate = self;

        [self showLoadingSpinner];
        [datasource getPlaceObjects:searchText withCallback:^(NSArray *places , NSError *error)
         {
             
             [self addResults:places toTableViewWithError:error];
         }];
    }
    else
    {
        [_tableView setPlaces:Nil];
        [tableViewHeader setBackgroundColor:[UIColor clearColor]];
        [_tableView reloadData];
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
}


#pragma Mark Keyboard Notifications
- (void)keyboardWasShown:(NSNotification *)notification
{
    
    CGSize size = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    int height = MIN(size.height,size.width);
    int width = MAX(size.height,size.width);
    
    keyBoardSize = CGSizeMake(width, height);
    isKeyboarsShown = YES;
    
    
}

-(void)keyboardDidHide:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^(void)
     {
         [self.tableView setFrame:CGRectMake(0,_searchBar.frame.origin.y + _searchBar.frame.size.height , self.view.frame.size.width, self.view.frame.size.height - (_searchBar.frame.origin.y + _searchBar.frame.size.height))];
     }];
    isKeyboarsShown = NO;
}


#pragma mark Loading Indicator Handlers
-(void)showLoadingSpinner
{
    
    
    [tableViewHeader showLoadingIndicator];

}


-(void)invalidateLoadingSpinner
{
    
    [tableViewHeader hideLoadingIndicator:YES];
}

-(void)dismissButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}


@end
