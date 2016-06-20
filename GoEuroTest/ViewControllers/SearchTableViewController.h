//
//  SearchTableViewController.h
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlacesTableView.h"

/**
 Enum that describes the various possible search states while searching and booking.
 */
typedef enum
{   SearchStateFromLocation = 0,
    SearchStateToLocation = 2,
    SearchStateNone = 4,
    SearchStateComplete = 8,
}SearchState;


/**
 *  Custom delegate methods for this view controller.
 */
@protocol SearchTableViewDelegate <NSObject>

/**
 *  Delegate method that is trigered on tableViewDidSelect from this view controller
 */

-(void)didMakeSelection:(PlaceObject *)placeObject forSearchType:(SearchState)type;

@end
@interface SearchTableViewController : UIViewController<UITabBarDelegate , UISearchBarDelegate , UITableViewDelegate>
/**
 *  Property search bar. Inserted programatically
 */
@property(nonatomic , retain)UISearchBar *searchBar;
/**
 *  Property of table view that lists all the querie places. Instered programatically
 */
@property(nonatomic , retain)PlacesTableView *tableView;
/**
 *  Property for button that is used to dismiss this view controller. Instered Programatically
 */
@property(nonatomic , retain)UIButton *dismissButton;
/**
 *  delegate that can be assigned to an object to react to table view select events
 */
@property(nonatomic , assign)id delegate;
/**
 *  Property that indicates the current search state of this view controller
 */
@property(nonatomic)SearchState searchType;
@end
