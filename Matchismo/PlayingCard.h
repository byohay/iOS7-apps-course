//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString* suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray*) validSuits;
+ (NSUInteger) maxRank;
@end
