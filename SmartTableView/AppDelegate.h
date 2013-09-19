//
//  AppDelegate.h
//  SmartTableView
//
//  Created by Sanjay on 17/09/13.
//  Copyright (c) 2013 Times mobile ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SmartTableViewController;
@class SmartMarkableViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SmartTableViewController *viewController;
@property (strong, nonatomic) SmartMarkableViewController *viewController2;



@end
