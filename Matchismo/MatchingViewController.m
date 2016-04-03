//
//  MatchingViewController.m
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "MatchingViewController.h"
#import "PlayingCardDeck.h"


@implementation MatchingViewController

- (Deck*) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger) getMatchingMode
{
    return 2;
}

- (NSAttributedString*) titleForCard:(Card*) card
{
    return [[NSAttributedString alloc] initWithString: (card.isChosen ? card.contents : @"")];
}

- (UIImage*) imageForCard:(Card*) card
{
    return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSAttributedString*) historyTitleForCard:(Card*) card
{
    return [[NSAttributedString alloc] initWithString: card.contents];
}


@end
