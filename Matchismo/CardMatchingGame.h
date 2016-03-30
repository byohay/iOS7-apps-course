//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck*) deck
               numberOfMatchingCards:(NSUInteger) matchingCardsNumber;

- (void) chooseCardAtIndex: (NSUInteger)index;
- (Card*) cardAtIndex: (NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger matchingCardsNumber;

@end

