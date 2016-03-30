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

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck
             numberOfMatchingCards:(NSUInteger) matchingCardsNumber;

{
    self = [super init];
    self.cards = [[NSMutableArray alloc] init];
    
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
    
    self.matchingCardsNumber = matchingCardsNumber;
    
    return self;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (void)matchOtherCardsWithCard:(NSMutableArray *)otherCardsToMatch card:(Card *)card
{
    int matchScore = [card match:otherCardsToMatch];
    
    if (matchScore > 0) {
        self.score += matchScore * MATCH_BONUS;
        card.matched = YES;
        for (Card* otherCard in otherCardsToMatch) {
            otherCard.matched = YES;
        }
    }
    else {
        self.score -= MISMATCH_PENALTY;
        for (Card* otherCard in otherCardsToMatch) {
            otherCard.chosen = NO;
        }
    }
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card* card = [self cardAtIndex:index];
    
    if (card.isMatched) {
        return;
    }
    
    if (card.isChosen) {
        card.chosen = NO;
        return;
    }
    self.score -= COST_TO_CHOOSE;

    card.chosen = YES;
    card.matched = NO;
    
    NSMutableArray* otherCardsToMatch = [[NSMutableArray alloc] init];
    for (Card* otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched &&
            otherCard != card) {
            [otherCardsToMatch addObject:otherCard];
        }
    }
    
    if ([otherCardsToMatch count] + 1 == self.matchingCardsNumber) {
        [self matchOtherCardsWithCard:otherCardsToMatch card:card];
    }
}

- (Card*) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
