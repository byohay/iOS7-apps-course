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

- (NSAttributedString*) titleForCard:(Card*) card
{
    NSMutableAttributedString* title = [[NSMutableAttributedString alloc] init];
    SetCard* setCard = (SetCard*) card;
    
    for (int i = 1; i <= (int)setCard.number_of_symbols; ++i) {
        [title appendAttributedString:[[NSAttributedString alloc] initWithString:setCard.shape]];
    }
    
    NSString* color = setCard.color;
    
    if ([setCard.shading isEqualToString:@"transparent"]) {
        [title addAttributes: @{ NSForegroundColorAttributeName: [self getCardColorToUIColor:color withTransparency:0.1],
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
    
    return title;
}


- (UIColor*) getCardColorToUIColor:(NSString*) stringColor
                   withTransparency:(float)transparency{
    NSDictionary* cardColorToUIColor = @{
                                         @"red" : [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:transparency],
                                         @"green" : [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:transparency],
                                         @"blue" : [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:transparency]
                                };
    
    return cardColorToUIColor[stringColor];
}

- (UIColor*) getCardColorToUIColor:(NSString*) stringColor{
    
    return [self getCardColorToUIColor:stringColor withTransparency:1];
}


- (UIImage*) imageForCard:(Card*) card
{
    return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

@end

