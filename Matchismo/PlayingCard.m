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


- (int) match: (NSArray*) otherCards
{
    if (![otherCards count]) {
        return 0;
    }
    
    int score = 0;
    for (PlayingCard* otherCard in otherCards) {
        if ([self.suit isEqualToString:otherCard.suit]) {
            score += 1;
        }
        else if (self.rank == otherCard.rank) {
            score += 4;
        }
    }
    
    score += [[otherCards objectAtIndex:0] match:[otherCards
                                                  subarrayWithRange:NSMakeRange(1, [otherCards count]-1)]];
    
    return score;
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
