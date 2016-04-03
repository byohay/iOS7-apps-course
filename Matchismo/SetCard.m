//
//  SetCard.m
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString*) contents
{
    return nil;
}

- (BOOL) isFeatureQualifiedForSet: (NSArray*) cardsFeatures
{
    NSString* firstCardFeature = cardsFeatures[0];
    NSString* secondCardFeature = cardsFeatures[1];
    NSString* thirdCardFeature = cardsFeatures[2];
    
    if ( ([firstCardFeature isEqualToString:secondCardFeature] &&
         [firstCardFeature isEqualToString:thirdCardFeature]) ||
        (![firstCardFeature isEqualToString:secondCardFeature] &&
         ![firstCardFeature isEqualToString:thirdCardFeature] &&
         ![secondCardFeature isEqualToString:thirdCardFeature])) {
            return YES;
        }
    return NO;
}

- (int) match: (NSArray*) otherCards
{
    int isMatched = YES;
    if ([otherCards count] < 2) {
        return 0;
    }
    
    SetCard* secondCard = otherCards[0];
    SetCard* thirdCard = otherCards[1];
    
    if (![self isFeatureQualifiedForSet:@[self.shape, secondCard.shape, thirdCard.shape]]) {
        isMatched = NO;
    }
    else if (![self isFeatureQualifiedForSet:@[self.color, secondCard.color, thirdCard.color]]) {
        isMatched = NO;
    }
    else if (![self isFeatureQualifiedForSet:@[self.shading, secondCard.shading, thirdCard.shading]]) {
        isMatched = NO;
    }
    
    else if (![self isFeatureQualifiedForSet:@[[@(self.numberOfSymbols) stringValue], [@(secondCard.numberOfSymbols) stringValue], [@(thirdCard.numberOfSymbols) stringValue]]]) {
        isMatched = NO;
    }
    
    return isMatched ? 1 : 0;
}

+ (int) maxNumberOfSymbols
{
    return 3;
}

+ (NSArray*) validShapes
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray*) validColors
{
    return @[@"red", @"green", @"blue"];
}

+ (NSArray*) validShading
{
    return @[@"solid", @"transparent", @"open"];
}


@end
