//
//  GreetZAPFestivals.h
//  greetZAPFestivals
//
//  Created by Sanjay on 11/16/12.
//  Copyright (c) 2012 TML. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GreetZAPFestivals : NSObject
{
    
}

@property(nonatomic, strong) NSString*      title;
@property(nonatomic, strong) NSString*      displayTitle;
@property(nonatomic, strong) NSString*      festId;
@property(nonatomic, strong) NSString*      imgLarge;
@property(nonatomic, strong) NSString*      imgLargeModified;
@property(nonatomic, strong) NSString*      imgSmall;
@property(nonatomic, strong) NSString*      imgSmallModified;
@property(nonatomic, strong) NSString*      startDate;
@property(nonatomic, strong) NSString*      endDate;
@property(nonatomic, strong) UIImage*       thumbImage;
@property(nonatomic, strong) UIImage*       largeImage;

@end
