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
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) Deck* deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *matchingCardsSwitch;

@end


@implementation ViewController


- (CardMatchingGame*)game
{
    if (!_game) _game = self.game = [self createGame];
    
    return _game;
}

- (IBAction)touchResetButton:(UIButton*)sender {
    self.game = [self createGame];
    self.matchingCardsSwitch.enabled = YES;
    [self updateUI];
}

- (CardMatchingGame*) createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]
                                 numberOfMatchingCards:[self getMatchingMode]];
}

- (IBAction)matchingModeSwitch:(UISwitch*)sender
{
    self.game.matchingCardsNumber = [self getMatchingMode];
}

- (NSUInteger) getMatchingMode
{
    if ([self.matchingCardsSwitch isOn]) {
        return 3;
    }
    else {
        return 2;
    }
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    self.matchingCardsSwitch.enabled = NO;
}

- (void) updateUI
{
    for (UIButton* cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        
        Card* card = [self.game cardAtIndex:cardIndex];
        
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card]
                    forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %@", @(self.game.score)];
}

- (NSString*) titleForCard:(Card*) card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage*) imageForCard:(Card*) card
{
    return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

- (Deck*)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck*) createDeck
{
    return [[PlayingCardDeck alloc] init];
}


@end
