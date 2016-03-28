//
//  Deck.h
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card*)card atTop:(BOOL)atTop;
- (void) addCard:(Card*)card;

- (Card*) drawRandomCard;


@end
