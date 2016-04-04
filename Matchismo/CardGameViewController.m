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
#import "HistoryViewController.h"

@interface CardGameViewController ()

@property (strong, nonatomic) Deck* deck;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardViews;
@property (strong, nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSMutableArray* history;
@property (strong, nonatomic) NSAttributedString* lastConsiderationLabel;

@end


@implementation CardGameViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController* historyController = (HistoryViewController*)segue.destinationViewController;
            
            historyController.history = self.history;
        }
    }
}

- (CardMatchingGame*)game
{
    if (!_game) _game = [self createGame];
    
    return _game;
}

- (NSMutableArray*)history
{
    if (!_history) _history = [self createHistory];
    
    return _history;
}

- (Deck*)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}




- (IBAction)touchResetButton:(UIButton*)sender {
    self.game = [self createGame];
    self.history = [self createHistory];
    [self updateUI];
}

- (CardMatchingGame*) createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count]
                                             usingDeck:[self createDeck]
                                 numberOfMatchingCards:[self getMatchingMode]];
}

- (NSMutableArray*) createHistory
{
    return [[NSMutableArray alloc] init];
}


- (IBAction)matchingModeSwitch:(UISwitch*)sender
{
    self.game.matchingCardsNumber = [self getMatchingMode];
}

// history is added only here. If it were inside updateUI, it would have changed every time
// we return to this view. This is why it is added here.
- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardViews indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    [self.history addObject:self.lastConsiderationLabel];
}

- (void) updateUI
{
    for (UIView* cardView in self.cardViews) {
        NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
        
        Card* card = [self.game cardAtIndex:cardIndex];
        [self updatedCardView:cardView withCard:card];
        [cardView setNeedsDisplay];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %@", @(self.game.score)];
    
    [self updateLastConsideration];
}

- (void) updateLastConsideration
{
    NSMutableAttributedString* matchedCardsString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (Card* card in self.game.cardsToDisplay) {
        [matchedCardsString appendAttributedString:[self historyTitleForCard:card]];
        [matchedCardsString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\t"]];
    }
    
    if (self.game.isMatchingOccured) {
        self.lastConsiderationLabel = [self getTextInCaseOfMatch:matchedCardsString];
    }
    else {
        self.lastConsiderationLabel = matchedCardsString;
    }
}

- (NSAttributedString*) getTextInCaseOfMatch:(NSMutableAttributedString*) matchedCardsString
{
    NSMutableAttributedString* text;
    NSString* textToAdd;
    
    if (self.game.lastScore > 0) {
        text = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
        [text appendAttributedString:matchedCardsString];
        
        textToAdd = [[NSString alloc] initWithFormat:@" for %@ points.", @(self.game.lastScore)];
    }
    else {
        text = matchedCardsString;
        
        textToAdd = [ [NSString alloc] initWithFormat:@" don't match! %@ points penalty!", @(self.game.lastScore)];
        
    }
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:textToAdd]];
    
    return text;
}



@end
