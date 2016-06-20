//
//  ViewController.h
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICommons.h"
#import "SearchTableViewController.h"


#define BookViewController_StoryboardID @"BookVC"

@interface ViewController : UIViewController<UITextFieldDelegate , SearchTableViewDelegate , THDatePickerDelegate>


/**
 *  Propertys and IBOutlets Hooked to the Main Storyboard
 */

/**
 *  Text Field to select Departure City
 */
@property(nonatomic , retain)IBOutlet UITextField *fromCityTextField;

/**
 *  Text Field to select destination city
 */
@property(nonatomic , retain)IBOutlet UITextField *toCityTextField;
/**
 *  Custom View to select and input start date into
 */
@property(nonatomic , retain)IBOutlet UIView *fromDateView;
/**
 *  Custom View to select and input end date into
 */
@property(nonatomic , retain)IBOutlet UIView *toDateView;
/**
 *  Label that displays from date afte selecting it
 */
@property(nonatomic , retain)IBOutlet UILabel *fromDateLabel;
/**
 *  Label that displays to date after selecting it
 */
@property(nonatomic , retain)IBOutlet UILabel *toDateLabel;
/**
 *  Clickable button to perform search
 */
@property(nonatomic , retain)IBOutlet UIButton *searchButton;


/**
 *  Button click handler for search button. Hooked to story board
 *
 *  @param sender UIButton searchButton
 
 */
-(IBAction)searchButtonPressed:(id)sender;

/**
 *  Factory method for creation of this ViewController
 *
 *  @return instance of this view controller
 */
+(ViewController *)createFromNib;
@end

