//
//  Deck.m
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray* cards;
@end

@implementation Deck

- (NSMutableArray*) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void) addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

- (void) addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

// TODO: check why need to check for count before
- (Card*) drawRandomCard
{
    Card* random_card = nil;
    
    if ([self.cards count])
    {
        unsigned int index =  arc4random() % [self.cards count];
    
        random_card = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return random_card;
}

@end
