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
@property (weak, nonatomic) IBOutlet UIButton *moreCardsButton;
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

- (IBAction)touchMoreCards:(UIButton*)sender {
  NSUInteger numberOfCardsToAdd = 3;

  for (int i = 0; i < numberOfCardsToAdd; ++i) {
    Card *randomCard = [self.deck drawRandomCard];
    if (!randomCard) {
      numberOfCardsToAdd = i;
      sender.enabled = NO;
      [self.moreCardsButton setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                                      forState:UIControlStateNormal];
      break;
    }
    [self.game addCard:randomCard];
  }

  self.cardViews = [self createCardViews:([self.cardViews count] + numberOfCardsToAdd)];

  [self resetOverallCardsView];
  [self updateUI];
  [self removeMatchedCardsFromOverall];
}

static const int numberOfCardsAtStart = 12;

- (IBAction)touchResetButton:(UIButton*)sender {
  self.deck = [self createDeck];
  self.game = [self createGame];
  self.cardViews = [self createCardViews];
  [self resetOverallCardsView];
  [self updateUI];

  self.moreCardsButton.enabled = YES;
  [self.moreCardsButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                                  forState:UIControlStateNormal];
}

- (void) resetOverallCardsView
{
  [[self.overallCardsView subviews]
   makeObjectsPerformSelector:@selector(removeFromSuperview)];

  for (CardView* view in self.cardViews) {
    if (!view.isMatched) {
      [self.overallCardsView addSubview:view];
     }
  }
  [self.overallCardsView setNeedsDisplay];
}

- (void) removeMatchedCardsFromOverall
{
  for (CardView* view in self.overallCardsView.subviews) {
    if (view.isMatched) {
      [view removeFromSuperview];
    }
  }
  [self.overallCardsView setNeedsDisplay];
}


- (NSMutableArray *)createCardViews
{
  NSMutableArray *cardViews = [self createCardViews:numberOfCardsAtStart];
  return cardViews;
}

- (NSMutableArray *)createCardViews:(NSUInteger)numberOfCards
{
  NSMutableArray *cardViews = [[NSMutableArray alloc] init];
  Grid* grid = [[Grid alloc] init];

  grid.cellAspectRatio = 0.8;
  grid.size = self.overallCardsView.bounds.size;
  grid.minimumNumberOfCells = numberOfCards;

  for (int cardNum = 0; cardNum < numberOfCards; ++cardNum) {
    NSUInteger rowNum = cardNum / grid.columnCount;
    NSUInteger colNum = cardNum % grid.columnCount;
    CGRect viewFrame = [grid frameOfCellAtRow:rowNum inColumn:colNum];
    [cardViews addObject:[self createCardView:viewFrame]];
  }

  return cardViews;
}

- (CardMatchingGame*) createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:numberOfCardsAtStart
                                             usingDeck:self.deck
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

- (BOOL) isTapOnACard:(UIView *)viewTappedOn
{
  return viewTappedOn != self.overallCardsView;
}

- (void) tap:(UITapGestureRecognizer *)sender
{
  CGPoint tapPoint = [sender locationInView:self.overallCardsView];
  UIView* cardView = [self.overallCardsView hitTest:tapPoint withEvent:nil];

  if (![self isTapOnACard:cardView]) {
    return;
  }

  NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
  [self.game chooseCardAtIndex:cardIndex];
  [self updateUI];

  [self handleTapInSpecificController:self.overallCardsView
                            tappedCard:cardView];
}

@end
