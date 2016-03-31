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


@end
