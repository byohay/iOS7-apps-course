//
//  SetCard.h
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) int numberOfSymbols;
@property (nonatomic) int shape;
@property (nonatomic) int color;
@property (nonatomic) int shading;

+ (int) maxNumberInEachFeature;


@end
