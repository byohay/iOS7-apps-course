//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) init
{
    self = [super init];
    
    if (self){
        for (int symbol = 1; symbol <= [SetCard maxNumberInEachFeature]; ++symbol) {
            for(int shading = 1; shading <= [SetCard maxNumberInEachFeature]; ++shading) {
                for(int color = 1; color <= [SetCard maxNumberInEachFeature]; ++color) {
                    for(int shape = 1; shape <= [SetCard maxNumberInEachFeature]; ++shape) {

                        SetCard* card = [[SetCard alloc] init];
                        card.numberOfSymbols = symbol;
                        card.shape = shape;
                        card.color = color;
                        card.shading = shading;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}


@end
