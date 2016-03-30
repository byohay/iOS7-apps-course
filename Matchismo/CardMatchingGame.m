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

@property (nonatomic, readwrite) NSInteger lastScore;
@property (nonatomic, strong, readwrite) NSMutableArray* cardsToDisplay;
@property (nonatomic, readwrite) BOOL isMatchingOccured;

@end

@implementation CardMatchingGame


static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;



- (NSMutableArray*) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray*) cardsToDisplay
{
    if (!_cardsToDisplay) _cardsToDisplay = [[NSMutableArray alloc] init];
    return _cardsToDisplay;
}


- (BOOL)getCardsFromDeck:(Deck *)deck count:(NSUInteger)count
{
    for (int i = 0; i < count; ++i)
    {
        
        Card* card =  [deck drawRandomCard];
        
        if (card) {
            [self.cards addObject:card];
        }
        else {
            return NO;
        }
    }
    
    return YES;
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck
             numberOfMatchingCards:(NSUInteger) matchingCardsNumber;

{
    self = [super init];
    
    if (self)
    {
        if (![self getCardsFromDeck:deck count:count]) {
            self = nil;
        }
            
    }
    
    self.matchingCardsNumber = matchingCardsNumber;
    
    return self;
}

- (void)matchOtherCardsWithCard:(NSMutableArray *)otherCardsToMatch card:(Card *)card
{
    int matchScore = [card match:otherCardsToMatch];
    
    if (matchScore > 0) {
        self.lastScore = matchScore * MATCH_BONUS;
        
        card.matched = YES;
        for (Card* otherCard in otherCardsToMatch) {
            otherCard.matched = YES;
        }
    }
    else {
        self.lastScore = -MISMATCH_PENALTY;

        for (Card* otherCard in otherCardsToMatch) {
            otherCard.chosen = NO;
        }
    }
    
    self.score += self.lastScore;
}

- (void) setCorrectCardsToDisplay:(NSMutableArray *)otherCardsToMatch card:(Card *)card
{
    [self.cardsToDisplay removeAllObjects];
    
    if (self.isMatchingOccured) {
        self.cardsToDisplay = [otherCardsToMatch mutableCopy];
        [self.cardsToDisplay insertObject:card atIndex:0];
    }
    else {
        for (Card* otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.isMatched) {
                [self.cardsToDisplay addObject:otherCard];
            }
        }
    }
}

- (NSMutableArray *)getOtherCardsToMatch:(Card*) card
{
    NSMutableArray* otherCardsToMatch = [[NSMutableArray alloc] init];
    
    for (Card* otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched &&
            otherCard != card) {
            [otherCardsToMatch addObject:otherCard];
        }
    }
    
    return otherCardsToMatch;
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card* card = [self cardAtIndex:index];

    if (card.isMatched) {
        return;
    }

    NSMutableArray* otherCardsToMatch = [self getOtherCardsToMatch:card];

    self.isMatchingOccured = [otherCardsToMatch count] + 1 == self.matchingCardsNumber;

    if (card.isChosen) {
        card.chosen = NO;
    }
    else {
        self.score -= COST_TO_CHOOSE;

        card.chosen = YES;
        card.matched = NO;
        
        if (self.isMatchingOccured) {
            [self matchOtherCardsWithCard:otherCardsToMatch card:card];
        }
    }
    
    [self setCorrectCardsToDisplay:otherCardsToMatch card:card];
}

- (Card*) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
