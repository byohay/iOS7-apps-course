//
//  Card.h
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString* contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match: (NSArray *) other_cards;

@end
