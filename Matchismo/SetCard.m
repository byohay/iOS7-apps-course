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
    NSNumber* firstCardFeature = cardsFeatures[0];
    NSNumber* secondCardFeature = cardsFeatures[1];
    NSNumber* thirdCardFeature = cardsFeatures[2];
    
    if ( ([firstCardFeature isEqualToNumber:secondCardFeature] &&
         [firstCardFeature isEqualToNumber:thirdCardFeature]) ||
        (![firstCardFeature isEqualToNumber:secondCardFeature] &&
         ![firstCardFeature isEqualToNumber:thirdCardFeature] &&
         ![secondCardFeature isEqualToNumber:thirdCardFeature])) {
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
    
  if (![self isFeatureQualifiedForSet:
  @[[NSNumber numberWithInteger:self.shape],
    [NSNumber numberWithInteger:secondCard.shape],
    [NSNumber numberWithInteger:thirdCard.shape]]]) {
        isMatched = NO;
    }
    else if (![self isFeatureQualifiedForSet:
               @[[NSNumber numberWithInteger:self.color],
                 [NSNumber numberWithInteger:secondCard.color],
                 [NSNumber numberWithInteger:thirdCard.color]]]) {
        isMatched = NO;
    }
    else if (![self isFeatureQualifiedForSet:
               @[[NSNumber numberWithInteger:self.shading],
                 [NSNumber numberWithInteger:secondCard.shading],
                 [NSNumber numberWithInteger:thirdCard.shading]]]) {
        isMatched = NO;
    }
    
    else if (![self isFeatureQualifiedForSet:
               @[[NSNumber numberWithInteger:self.numberOfSymbols],
                 [NSNumber numberWithInteger:secondCard.numberOfSymbols],
                 [NSNumber numberWithInteger:thirdCard.numberOfSymbols]]]) {
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
    return @[@1, @2, @3];
}

+ (NSArray*) validColors
{
  return @[@1, @2, @3];
}

+ (NSArray*) validShading
{
  return @[@1, @2, @3];
}


@end
