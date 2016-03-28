//
//  ViewController.m
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface ViewController ()

@property (strong, nonatomic) Deck* deck;

@end


@implementation ViewController


{
}


- (IBAction)touchCardButton:(UIButton *)sender {
}

- (Deck*)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}


@end
