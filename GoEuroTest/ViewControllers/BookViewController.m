 //
//  ViewController.m
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "BookViewController.h"
#import "Datasource.h"
#import "PlaceTableViewCell.h"
#import "PlacesTableView.h"


@interface ViewController ()
{
    Datasource *datasource;
    NSMutableDictionary *placesTableView;
    SearchState searchState;
    NSMutableDictionary *searchTableVCs;
    CGSize keyBoardSize;
    
    THDatePickerViewController *fromDatePicker;
    THDatePickerViewController *toDatePicker;
    
}


@end



@implementation ViewController
@synthesize fromCityTextField = _fromCityTextField;
@synthesize toCityTextField = _toCityTextField;
@synthesize fromDateView = _fromDateView;
@synthesize toDateView = _toDateView;
@synthesize fromDateLabel = _fromDateLabel;
@synthesize toDateLabel = _toDateLabel;
@synthesize searchButton = _searchButton;



#pragma mark Nib Creation Methods
+(ViewController *)createFromNib
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:BookViewController_StoryboardID];
}

#pragma mark Create SearchTableViewController Methods
-(SearchTableViewController *)createSearchTableViewControllerForSearchType:(SearchState)searchType
{
    SearchTableViewController *searchVC = [[SearchTableViewController alloc] init];
    searchVC.delegate = self;
    searchVC.searchType = searchType;
   
    return searchVC;

}

#pragma mark Create DatePicker Methods
-(THDatePickerViewController *)datePickerForType:(SearchState)type
{
    if(type == SearchStateFromLocation)
    {
        if(!fromDatePicker)
        {
            fromDatePicker = createDatePicker();
            fromDatePicker.date = [NSDate date];
            fromDatePicker.delegate = self;
            [fromDatePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
            fromDatePicker.title = @"Choose Start Date";
            
            [fromDatePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
            
            [fromDatePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
                int tmp = (arc4random() % 30)+1;
                if(tmp % 5 == 0)
                    return YES;
                return NO;
            }];

        }
        
        return fromDatePicker;
        

    }
    else if(type == SearchStateToLocation)
    {
        if(!toDatePicker)
        {
            toDatePicker = [THDatePickerViewController datePicker];
            toDatePicker.date = [NSDate date];
            toDatePicker.delegate = self;
            [toDatePicker setAllowClearDate:NO];
            [toDatePicker setClearAsToday:YES];
            [toDatePicker setAutoCloseOnSelectDate:YES];
            [toDatePicker setAllowSelectionOfSelectedDate:YES];
            [toDatePicker setDisableHistorySelection:YES];
            [toDatePicker setDisableFutureSelection:NO];
            [toDatePicker setSelectedBackgroundColor:primaryColor()];
            toDatePicker.title = @"Choose End Date";
            
            [toDatePicker setCurrentDateColor:secondaryColor()];
            
            [toDatePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
                int tmp = (arc4random() % 30)+1;
                if(tmp % 5 == 0)
                    return YES;
                return NO;
            }];

        }
        return toDatePicker;
        
    }
    return Nil;
}


#pragma mark DatePicker Handler Methods
-(void)showDatePickerForType:(SearchState)type
{
    
    [self presentSemiViewController:[self datePickerForType:type] withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}

-(void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate
{
    
}

-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker
{
    if(datePicker == fromDatePicker)
        _fromDateLabel.text = [[PlaceObject defaultDateFormatter] stringFromDate:datePicker.date];
    if(datePicker == toDatePicker)
        _toDateLabel.text = [[PlaceObject defaultDateFormatter] stringFromDate:datePicker.date];
    
}

-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker
{
    [self dismissSemiModalView];
}

-(void)fromDateTapped:(id)sender
{
    [self showDatePickerForType:SearchStateFromLocation];
}

-(void)toDateTapped:(id)sender
{
    [self showDatePickerForType:SearchStateToLocation];
}

-(IBAction)searchButtonPressed:(id)sender
{
    [alertWithTitleAndMessage(@"Search Error!",@"Search is not yet implemented!") showAnimated:YES completionHandler:Nil];

}

#pragma mark UIViewController Override Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    searchState = SearchStateNone;
    _fromCityTextField.delegate = self;
    _toCityTextField.delegate = self;
    
    [self addRoundedEdges:_fromCityTextField];
    [self addRoundedEdges:_toCityTextField];
    [self addRoundedEdges:_fromDateView];
    [self addRoundedEdges:_toDateView];
    [self addRoundedEdges:_searchButton];
    
    datasource = [Datasource getInstance];
    [datasource initLocationManager:^(CLLocation *lastLocation , NSError *error)
     {
         
     }];
    
    placesTableView = [[NSMutableDictionary alloc] initWithCapacity:2];
    self.navigationController.navigationBarHidden = YES;
    
    
    UITapGestureRecognizer *fromDateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fromDateTapped:)];
    [_fromDateView addGestureRecognizer:fromDateTap];
    
    UITapGestureRecognizer *toDateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toDateTapped:)];
    [_toDateView addGestureRecognizer:toDateTap];
    
    _fromDateLabel.text = @"";
    _toDateLabel.text = @"";
    
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.75
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                         
                         
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                     }];
    [self.view endEditing:YES];
}

#pragma Mark Styling Methods
-(void)addRoundedEdges:(UIView *)view
{
    view.layer.cornerRadius = 3.0;
    view.layer.masksToBounds = YES;
    
}

#pragma mark SearchTableViewController Delegate Methods
-(void)didMakeSelection:(PlaceObject *)placeObject forSearchType:(SearchState)type
{
    switch (searchState) {
        case SearchStateNone:
            _fromCityTextField.text = placeObject.name;
            searchState = SearchStateFromLocation;
          
            [self pushSearchTableVC];
            break;
        case SearchStateFromLocation:
            _toCityTextField.text = placeObject.name;
            searchState = SearchStateComplete;
            [self pushSearchTableVC];

            break;
        case SearchStateComplete:
            if(type == SearchStateFromLocation)
                _fromCityTextField.text = placeObject.name;
            if(type == SearchStateToLocation)
                _toCityTextField.text = placeObject.name;
           
            break;
        default:
            break;
    }
}


#pragma mark UITextField Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(searchState ==  SearchStateComplete)
    {
        if(textField == _fromCityTextField)
            [self presentViewController:[searchTableVCs objectForKey:[NSNumber numberWithInt:SearchStateFromLocation]] animated:YES completion:Nil];
        
        if(textField == _toCityTextField)
            [self presentViewController:[searchTableVCs objectForKey:[NSNumber numberWithInt:SearchStateToLocation]] animated:YES completion:Nil];
        
    }
    else if((searchState == SearchStateNone && textField == _fromCityTextField) ||
            (searchState == SearchStateFromLocation && textField == _toCityTextField))
        [self pushSearchTableVC];
       return NO;
        
}

#pragma Mark Navigation Methods
-(void)pushSearchTableVC
{
    if(!searchTableVCs)
        searchTableVCs = [[NSMutableDictionary alloc] init];
    
    if(![searchTableVCs objectForKey:[NSNumber numberWithInt:SearchStateFromLocation]])
    {
        [searchTableVCs setObject:[self createSearchTableViewControllerForSearchType:SearchStateFromLocation] forKey:[NSNumber numberWithInt:SearchStateFromLocation]];
    }
   if(![searchTableVCs objectForKey:[NSNumber numberWithInt:SearchStateToLocation]])
    {
        [searchTableVCs setObject:[self createSearchTableViewControllerForSearchType:SearchStateToLocation] forKey:[NSNumber numberWithInt:SearchStateToLocation]];
    }
    
    switch (searchState) {
        case SearchStateNone:
            [self presentViewController:[searchTableVCs objectForKey:[NSNumber numberWithInt:SearchStateFromLocation]] animated:YES completion:Nil];
            break;

        case SearchStateFromLocation:
            [self presentViewController:[searchTableVCs objectForKey:[NSNumber numberWithInt:SearchStateToLocation]] animated:YES completion:Nil];

            break;
        case SearchStateComplete:
        default:
            break;
    }
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
