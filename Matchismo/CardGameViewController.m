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
@property (strong, nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIView *overallCardsView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSMutableArray *cardViews;

@end


@implementation CardGameViewController

- (void) viewDidLoad
{
  [super viewDidLoad];

  for (UIView* view in self.cardViews) {
    [self.overallCardsView addSubview:view];
  }
}

- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  [self.overallCardsView setNeedsDisplay];
  [self updateUI];
}


- (NSMutableArray*)cardViews
{
  if (!_cardViews)
  {
    _cardViews = [[NSMutableArray alloc] init];
    Grid* grid = [[Grid alloc] init];

    grid.cellAspectRatio = 0.8;
    grid.size = self.overallCardsView.bounds.size;
    grid.minimumNumberOfCells = 12;

    for (int row = 0; row < grid.rowCount; ++row) {
      for (int col = 0; col < grid.columnCount; ++col) {
        CGRect viewFrame = [grid frameOfCellAtRow:row inColumn:col];
        [_cardViews addObject:[self createCardView:viewFrame]];
      }
    }
  }

  return _cardViews;
}


- (CardMatchingGame*)game
{
    if (!_game) _game = [self createGame];
    
    return _game;
}

- (Deck*)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}


- (IBAction)touchResetButton:(UIButton*)sender {
    self.game = [self createGame];
    [self updateUI];
}

- (CardMatchingGame*) createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count]
                                             usingDeck:[self createDeck]
                                 numberOfMatchingCards:[self getMatchingMode]];
}

- (IBAction)matchingModeSwitch:(UISwitch*)sender
{
    self.game.matchingCardsNumber = [self getMatchingMode];
}

- (void) updateUI
{
    for (UIView* cardView in self.cardViews) {
        NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
        
        Card* card = [self.game cardAtIndex:cardIndex];
        [self updateCardView:cardView withCard:card];
        [cardView setNeedsDisplay];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %@", @(self.game.score)];
}


@end
