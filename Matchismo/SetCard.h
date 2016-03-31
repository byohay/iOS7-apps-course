//
//  SetCard.h
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSNumber* number_of_symbols;
@property (strong, nonatomic) NSString* shape;
@property (strong, nonatomic) NSString* color;
@property (strong, nonatomic) NSString* shading;

+ (NSArray*) validNumbers;
+ (NSArray*) validShapes;
+ (NSArray*) validColors;
+ (NSArray*) validShading;


@end
