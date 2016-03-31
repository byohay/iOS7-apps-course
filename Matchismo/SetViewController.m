//
//  SetViewController.m
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardDeck.h"

@implementation SetViewController

- (Deck*) createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSUInteger) getMatchingMode
{
    return 3;
}


@end

