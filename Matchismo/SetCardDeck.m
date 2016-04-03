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
        for (int i = 1; i <= [SetCard maxNumberOfSymbols]; ++i) {
            for(NSString* shape in [SetCard validShapes]) {
                for(NSString* color in [SetCard validColors]) {
                    for(NSString* shading in [SetCard validShading]) {
                        SetCard* card = [[SetCard alloc] init];
                        card.numberOfSymbols = i;
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
