//
//  ViewController.m
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) Deck* deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastConsiderationLabel;

@end


@implementation CardGameViewController

- (void) viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

- (CardMatchingGame*)game
{
    if (!_game) _game = self.game = [self createGame];
    
    return _game;
}

- (IBAction)touchResetButton:(UIButton*)sender {
    self.game = [self createGame];
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

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void) updateUI
{
    for (UIButton* cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        
        Card* card = [self.game cardAtIndex:cardIndex];
        
        [cardButton setAttributedTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card]
                    forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %@", @(self.game.score)];
    
    [self updateLastConsideration];
}

- (void) updateLastConsideration
{
    NSString* matchedCardsString = @"";
    
    for (Card* card in self.game.cardsToDisplay) {
        matchedCardsString = [matchedCardsString stringByAppendingFormat: @"%@ ", card.contents];
    }
    
    if (self.game.isMatchingOccured) {
        if (self.game.lastScore > 0) {
            self.lastConsiderationLabel.text = [NSString stringWithFormat: @"Matched %@ for %@ points.", matchedCardsString, @(self.game.lastScore)];
        }
        else {
            self.lastConsiderationLabel.text = [NSString stringWithFormat: @"%@ don't match! %@ points penalty!", matchedCardsString, @(self.game.lastScore)];
        }
    }
    else {
        self.lastConsiderationLabel.text = matchedCardsString;
    }
}

- (Deck*)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}



@end
