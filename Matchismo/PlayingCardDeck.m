//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck : Deck


- (instancetype) init
{
    self = [super init];
    
    if (self){
        for (NSString* suit in [PlayingCard validSuits]) {
            for(NSUInteger rank = 1; rank < [PlayingCard maxRank]; ++rank) {
                PlayingCard* card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                
                [self addCard:card];
            }
        }
    }
    
    return self;
}


@end
