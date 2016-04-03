//
//  SetCard.m
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString*) contents
{
    return nil;
}


- (int) match: (NSArray*) otherCards
{
    if ([otherCards count] < 3) {
        return 0;
    }
    
    return 1;
}

+ (int) maxNumberOfSymbols
{
    return 3;
}

+ (NSArray*) validShapes
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray*) validColors
{
    return @[@"red", @"green", @"blue"];
}

+ (NSArray*) validShading
{
    return @[@"solid", @"transparent", @"open"];
}


@end
