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

@property (strong, nonatomic) NSDictionary* stringToUIColor;

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

- (NSDictionary*) stringToUIColor
{
    if(!_stringToUIColor) _stringToUIColor = @{
                                         @"red" : [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1],
                                         @"green" : [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:1],
                                         @"blue" : [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:1]
                                         };
    
    return _stringToUIColor;
}

- (NSAttributedString*) titleForCard:(Card*) card
{
    NSMutableAttributedString* title = [[NSMutableAttributedString alloc] initWithString:@""];
    SetCard* setCard = (SetCard*) card;
    
    for (int i = 1; i <= (int)setCard.numberOfSymbols; ++i) {
        [title appendAttributedString:[[NSAttributedString alloc] initWithString:setCard.shape]];
    }
    
    NSString* color = setCard.color;
    
    if ([setCard.shading isEqualToString:@"transparent"]) {
        [title addAttributes: @{ NSForegroundColorAttributeName: [[self getStringToUIColor:color] colorWithAlphaComponent:0.1],
                                 NSStrokeWidthAttributeName: @-5,
                                 NSStrokeColorAttributeName: [UIColor blackColor]}
                       range:NSMakeRange(0, [title length])];
    }
    else if([setCard.shading isEqualToString:@"open"]) {
        [title addAttributes: @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                 NSStrokeWidthAttributeName: @-5,
                                 NSStrokeColorAttributeName: [self getStringToUIColor:color]}
                       range:NSMakeRange(0, [title length])];
    }
    else {
        [title addAttributes: @{ NSForegroundColorAttributeName: [self getStringToUIColor:color]}
                       range:NSMakeRange(0, [title length])];
    }
    
    return title;
}


- (UIColor*) getStringToUIColor:(NSString*) stringColor
{
    return self.stringToUIColor[stringColor];
}


- (UIImage*) imageForCard:(Card*) card
{
    return [UIImage imageNamed: card.isChosen ? @"bluebackground" : @"cardfront"];
}

- (NSAttributedString*) historyTitleForCard:(Card*) card
{
    return [self titleForCard:card];
}

@end

