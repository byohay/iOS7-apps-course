//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString*) contents
{
    NSArray* rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

@synthesize suit = _suit;


+ (NSArray*) validSuits
{
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

+ (NSArray*) rankStrings
{
    return @[@"?", @"A", @"1", @"2", @"3", @"4", @"5", @"6", @"7",
             @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank
{
    return [[self rankStrings] count] - 1;
}

@end
