//
//  SetViewController.m
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetViewController()

@property (strong, nonatomic) NSDictionary* cardColorToUIColor;
@end

@implementation SetViewController

- (Deck*) createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSUInteger) getMatchingMode
{
    return 3;
}

- (NSString*) titleForCard:(Card*) card
{
    NSMutableAttributedString* title;
    SetCard* setCard = (SetCard*) card;
    
    for (int i = 1; i <= (int)setCard.number_of_symbols; ++i) {
        [title appendAttributedString:[[NSAttributedString alloc] initWithString:setCard.shape]];
    }
    
    NSLog(@"lol %@", setCard.shading);
    
    
    NSString* color = setCard.color;
    
    if ([setCard.shading isEqualToString:@"transparent"]) {
        [title addAttributes: @{ NSForegroundColorAttributeName: [self getCardColorToUIColor:color],
                                 NSStrokeWidthAttributeName: @-5,
                                 NSStrokeColorAttributeName: [UIColor blackColor]}
                       range:NSMakeRange(0, [title length])];
    }
    else if([setCard.shading isEqualToString:@"open"]) {
        [title addAttributes: @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                 NSStrokeWidthAttributeName: @-5,
                                 NSStrokeColorAttributeName: [self getCardColorToUIColor:color]}
                       range:NSMakeRange(0, [title length])];
    }
    else {
        [title addAttributes: @{ NSForegroundColorAttributeName: [self getCardColorToUIColor:color]}
                       range:NSMakeRange(0, [title length])];
    }
    
    return [title string];
}

- (UIColor*) getCardColorToUIColor:(NSString*) stringColor{
    NSDictionary *cardColorToUIColor = @{
                                         @"red" : [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1],
                                         @"green" : [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:1],
                                         @"blue" : [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:1]
                                };
    
    return cardColorToUIColor[stringColor];
}

- (UIImage*) imageForCard:(Card*) card
{
    return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

@end

