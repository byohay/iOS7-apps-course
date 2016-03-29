//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray* cards;

@end

@implementation CardMatchingGame

- (NSMutableArray*) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self)
    {
        for (int i = 0; i < count; ++i)
        {
            Card* card =  [deck drawRandomCard];
            
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
            
        }
            
    }
    
    return self;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card* card = [self cardAtIndex:index];
    
    if (card.isMatched) {
        return;
    }
    
    self.score -= COST_TO_CHOOSE;

    if (card.isChosen) {
        card.chosen = NO;
        return;
    }

    card.chosen = YES;
    card.matched = NO;
    
    for (Card* otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched &&
            otherCard != card) {
            int matchScore = [card match:@[otherCard]];
            if (matchScore) {
                self.score += matchScore * MATCH_BONUS;
                card.matched = YES;
                otherCard.matched = YES;
            }
            else {
                self.score -= MISMATCH_PENALTY;
                otherCard.chosen = NO;
            }
        }
    }
}

- (Card*) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
