//
//  MainTabBarController.m
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "MainTabBarController.h"
#import "TransportTableViewController.h"
#import "BookViewController.h"


#define TabBarHeight_Portrait 80
#define TabBarHeight_Landscape 50
@interface MainTabBarController ()

-(void)configureTabBarItemsForViewController:(UIViewController *)viewController;

@end


@implementation MainTabBarController



-(void)configureTabBarItemsForViewController:(UINavigationController *)viewController
{
   
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    label.font = [UIFont boldSystemFontOfSize: 14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Berlin - Munich \n Jun 07";
    viewController.navigationBar.topItem.titleView = label;
    
    [viewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:16.0f],
                                                                                      NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                                      } forState:UIControlStateNormal];
    
    
    [viewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:16.0f],
                                                                                      NSForegroundColorAttributeName : secondaryColor()
                                                                                      } forState:UIControlStateSelected];
    
    [viewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -15)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
   
    for(int i=0 ; i< self.viewControllers.count ; i++)
    {
        UINavigationController *navController = [[self viewControllers] objectAtIndex:i];
        TransportTableViewController *transportVC = [[navController viewControllers] objectAtIndex:0];
        [self configureTabBarItemsForViewController:navController];
        if(i == 0)
        {
            
            [transportVC setTransportType:TransportTypeTrain];
            [transportVC.navigationController.tabBarItem setTitle:@"Train"];
           
            

        }
        if(i == 1)
        {
            
            [transportVC setTransportType:TransportTypeBus];
             [transportVC.navigationController.tabBarItem setTitle:@"Bus"];
          
            
        }
        if(i == 2)
        {
            
            [transportVC setTransportType:TransportTypeFlight];
             [transportVC.navigationController.tabBarItem setTitle:@"Flight"];
        
            
        }
        if(i == 3)
        {
            
        
        }
    }
    
   
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
   
    
    CGRect tabFrame = self.tabBar.frame;
    
    CGRect frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, tabFrame.size.height);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[UIColor colorWithRed:14.0/255.0 green:97.0/255.0 blue:163.0/255.0 alpha:1.0]];
    [v setAlpha:1.0];
    [[self tabBar] insertSubview:v atIndex:0];
  
    
    
    
    
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    self.navigationController.navigationBarHidden = YES;
    NSArray *tabViewControllers = tabBarController.viewControllers;
    UIView * fromView = tabBarController.selectedViewController.view;
    UIView * toView = viewController.view;
    if (fromView == toView)
        return false;
    NSUInteger fromIndex = [tabViewControllers indexOfObject:tabBarController.selectedViewController];
    NSUInteger toIndex = [tabViewControllers indexOfObject:viewController];
    
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.3
                       options: toIndex > fromIndex ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL finished) {
                        if (finished) {
                            tabBarController.selectedIndex = toIndex;
                        }
                    }];
    return true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   
}


@end
