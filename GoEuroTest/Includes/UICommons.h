//
//  UICommons.h
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#ifndef UICommons_h
#define UICommons_h

#import<UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <LGAlertView/LGAlertView.h>
#import "THDatePickerViewController.h"

#define SearchTableVIewController_Identifier @"SearchTableVC"
#define TransportNavController_Identifier @"NavVC"
static inline UIStoryboard * mainStoryBoard()
{
    return [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
}

static inline UIColor *primaryColor()
{
    return [UIColor colorWithRed:14.0/255.0 green:97.0/255.0 blue:165.0/255.0 alpha:1.0];
}
static inline UIColor * secondaryColor()
{
    return [UIColor colorWithRed:252.0/255.0 green:156.0/255.0 blue:33.0/255.0 alpha:1.0];
}

static inline LGAlertView *alertWithTitleAndMessage(NSString *title , NSString *message)
{
    return [[LGAlertView alloc] initWithTitle:title message:message style:LGAlertViewStyleAlert buttonTitles:@[@"Ok"] cancelButtonTitle:Nil destructiveButtonTitle:Nil];
}

static inline LGAlertView *loadingIndicator()
{
    return [[LGAlertView alloc] initWithActivityIndicatorAndTitle:@"Loading" message:@"Please wait while we load this for you" style:LGAlertViewStyleAlert buttonTitles:Nil cancelButtonTitle:Nil destructiveButtonTitle:Nil];
}

static inline THDatePickerViewController *createDatePicker()
{
    
    THDatePickerViewController *datePicker = [THDatePickerViewController datePicker];
    datePicker.date = [NSDate date];
    [datePicker setAllowClearDate:NO];
    [datePicker setClearAsToday:YES];
    [datePicker setAutoCloseOnSelectDate:YES];
    [datePicker setAllowSelectionOfSelectedDate:YES];
    [datePicker setDisableHistorySelection:YES];
    [datePicker setDisableFutureSelection:NO];
    
    return datePicker;
    
}
static inline CATransition *pushPopTransition()
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    return transition;
}
#endif /* UICommons_h */
