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
#import "CardView.h"


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

  [self resetOverallCardsView];

  [self.overallCardsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:
   self action:@selector(tap:)]];
}

- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  [self updateUI];
}


- (NSMutableArray*)cardViews
{
  if (!_cardViews)
  {
    _cardViews = [self createCardViews];
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
    self.cardViews = [self createCardViews];
  [self resetOverallCardsView];

    [self updateUI];
}

- (void) resetOverallCardsView
{
  [[self.overallCardsView subviews]
   makeObjectsPerformSelector:@selector(removeFromSuperview)];

  for (UIView* view in self.cardViews) {
    [self.overallCardsView addSubview:view];
  }

}

- (NSMutableArray *)createCardViews
{
  NSMutableArray *cardViews = [[NSMutableArray alloc] init];
  Grid* grid = [[Grid alloc] init];

  grid.cellAspectRatio = 0.8;
  grid.size = self.overallCardsView.bounds.size;
  grid.minimumNumberOfCells = 12;

  for (int row = 0; row < grid.rowCount; ++row) {
    for (int col = 0; col < grid.columnCount; ++col) {
      CGRect viewFrame = [grid frameOfCellAtRow:row inColumn:col];
      [cardViews addObject:[self createCardView:viewFrame]];
    }
  }

  return cardViews;
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
    for (CardView* cardView in self.overallCardsView.subviews) {
        NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
        
        Card* card = [self.game cardAtIndex:cardIndex];
        [self updateCardView:cardView withCard:card];
        cardView.isMatched = card.isMatched;
        [cardView setNeedsDisplay];
    }

  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %@", @(self.game.score)];
}

- (void) removeMatchedCards
{
  NSMutableArray* matchedCardViews = [[NSMutableArray alloc] init];

  for (CardView* cardView in self.overallCardsView.subviews) {
    if (cardView.isMatched) {
      [matchedCardViews addObject:cardView];
    }
  }

  [self removeCards:matchedCardViews];
  [self.overallCardsView setNeedsDisplay];
}

- (void) removeCards:(NSArray *)cardsToRemove
{
}

- (void) tap:(UITapGestureRecognizer *)sender
{
  CGPoint tapPoint = [sender locationInView:self.overallCardsView];
  UIView* cardView = [self.overallCardsView hitTest:tapPoint withEvent:nil];

  if (cardView == self.overallCardsView) {
    return;
  }

  NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
  [self.game chooseCardAtIndex:cardIndex];
  [self updateUI];

  [self removeMatchedCards];
}

@end
