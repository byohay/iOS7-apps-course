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
                         usingDeck:(Deck*) deck;

- (void) chooseCardAtIndex: (NSUInteger)index;
- (Card*) cardAtIndex: (NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end

