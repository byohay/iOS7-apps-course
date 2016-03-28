//
//  Card.m
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card 

- (int)match:(NSArray *)other_cards
{
    int score = 0;
    
    for (Card* card in other_cards) {
        if ([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}

@end
