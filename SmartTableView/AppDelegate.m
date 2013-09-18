//
//  AppDelegate.m
//  SmartTableView
//
//  Created by Sanjay on 17/09/13.
//  Copyright (c) 2013 Times mobile ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "SmartTableViewController.h"

#import "JSON.h"
#import "GreetZAPFestivals.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSArray* parsedItemArray = [self parseFestivalsData];
    
    // Override point for customization after application launch.
    self.viewController = [[SmartTableViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self.viewController setItemsForTableView:parsedItemArray];
    
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSArray*)parseFestivalsData
{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"list" ofType:@"json"];
    NSError *error;
    SBJSON *json = [SBJSON new] ;
    NSString* requestData = [[NSString alloc]initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
    NSArray* dataArray  = [json objectWithString:requestData error:&error];
    
    NSMutableArray* parsedItemArray = [[NSMutableArray alloc]init];
    
    if (dataArray && [dataArray count]>0)
    {
        for (int index=0; index<[dataArray count]; index++ ) {
            
            GreetZAPFestivals* greetZapObj = [[GreetZAPFestivals alloc]init];
            
            NSString* stringValue=nil;
            NSDictionary *stream = (NSDictionary *)[dataArray objectAtIndex:index];
            
            stringValue = [stream valueForKey:@"FestName"];
            if (stringValue != (id)[NSNull null]) {
                greetZapObj.title = stringValue;
            }
            
            stringValue = [stream valueForKey:@"FestDisplayName"];
            if (stringValue != (id)[NSNull null]) {
                greetZapObj.displayTitle = stringValue;
            }
            
            stringValue = [stream valueForKey:@"FestId"];
            if (stringValue != (id)[NSNull null]) {
                greetZapObj.festId = stringValue;
            }
            
            stringValue = [stream valueForKey:@"ImgLarge"];
            if (stringValue != (id)[NSNull null]) {
                
                stringValue = [stringValue stringByReplacingOccurrencesOfString:@".png" withString:@"_hdpi.jpg"];
                greetZapObj.imgLarge = stringValue;
            }
            
            stringValue = [stream valueForKey:@"ImgLModifiedDate"];
            if (stringValue != (id)[NSNull null]) {
                greetZapObj.imgLargeModified = stringValue;
            }
            
            
            stringValue = [stream valueForKey:@"ImgSmall"];
            if (stringValue != (id)[NSNull null]) {
                
                stringValue = [stringValue stringByReplacingOccurrencesOfString:@".png" withString:@"_mdpi.png"];
                greetZapObj.imgSmall = stringValue;
            }
            
            stringValue = [stream valueForKey:@"ImgSModifiedDate"];
            if (stringValue != (id)[NSNull null]) {
                greetZapObj.imgSmallModified = stringValue;
            }
            
            stringValue = [stream valueForKey:@"FestStartDate"];
            if (stringValue != (id)[NSNull null]) {
                greetZapObj.startDate = stringValue;
            }
            
            stringValue = [stream valueForKey:@"FestEndDate"];
            if (stringValue != (id)[NSNull null]) {
                greetZapObj.endDate = stringValue;
            }
            
            [parsedItemArray addObject:greetZapObj];
            
        }
    }
    
    return parsedItemArray;
}


@end
