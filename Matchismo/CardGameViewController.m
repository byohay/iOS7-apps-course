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
@property (strong, nonatomic) Grid* grid;

@property (weak, nonatomic) IBOutlet UIView *overallCardsView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSMutableArray *cardViews;
@property (weak, nonatomic) IBOutlet UIButton *moreCardsButton;
@end


@implementation CardGameViewController

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self updateUI];

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

- (Grid*)grid
{
  if (!_grid) {
    _grid = [[Grid alloc] init];
    _grid.cellAspectRatio = 0.8;
    _grid.size = self.overallCardsView.bounds.size;
  }

  return _grid;
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

  [self addMoreCards:numberOfCardsToAdd];
  [self updateUI];
}

static const int numberOfCardsAtStart = 12;

- (IBAction)touchResetButton:(UIButton*)sender {
  self.deck = [self createDeck];
  self.game = [self createGame];
  self.cardViews = [self createCardViews];
  [self updateUI];

  self.moreCardsButton.enabled = YES;
  [self.moreCardsButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                                  forState:UIControlStateNormal];
}

- (BOOL) areRectsEqual:(CGRect)rect1 withRect:(CGRect)rect2
{
  return rect1.origin.x == rect2.origin.x &&
  rect1.origin.y == rect2.origin.y &&
  rect1.size.height == rect2.size.height &&
  rect1.size.width == rect2.size.width;
}

- (void) updateOverallCardsView
{
  [[self.overallCardsView subviews]
   makeObjectsPerformSelector:@selector(removeFromSuperview)];

  NSUInteger cardNum = 0;

  for (CardView* view in self.cardViews) {
    if (!view.isMatched) {
      CGRect cardFrame = [self getCardFrame:cardNum];
      if (![self areRectsEqual:view.frame withRect:cardFrame]) {
        [view setFrame:cardFrame];
      }
      cardNum++;
      [self.overallCardsView addSubview:view];
     }
  }

  [self.overallCardsView setNeedsDisplay];
}

- (CGRect) getCardFrame:(NSUInteger)cardNum
{
  NSUInteger rowNum = cardNum / self.grid.columnCount;
  NSUInteger colNum = cardNum % self.grid.columnCount;
  CGRect viewFrame = [self.grid frameOfCellAtRow:rowNum inColumn:colNum];

  return viewFrame;
}

- (NSMutableArray *)createCardViews
{
  NSMutableArray *cardViews = [[NSMutableArray alloc] init];

  self.grid.minimumNumberOfCells = numberOfCardsAtStart;

  for (int cardNum = 0; cardNum < numberOfCardsAtStart; ++cardNum) {
    [cardViews addObject:[self createCardView:CGRectMake(0, 0, 0, 0)]];
  }

  return cardViews;
}

- (void) addMoreCards:(NSUInteger)numberOfCardsToAdd
{
  self.grid.minimumNumberOfCells = [self.cardViews count] + numberOfCardsToAdd;

  for (NSUInteger cardNum = 0; cardNum < numberOfCardsToAdd; ++cardNum) {
    [self.cardViews addObject:[self createCardView:CGRectMake(0, 0, 0, 0)]];
  }
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
  BOOL isUpdatingOverallView = YES;

  for (CardView* cardView in self.cardViews) {
    NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];

    Card* card = [self.game cardAtIndex:cardIndex];
    [self updateCardView:cardView withCard:card];

    if (cardView.isMatched != card.isMatched) {
      isUpdatingOverallView = NO;
    }

    cardView.isMatched = card.isMatched;
    [cardView setNeedsDisplay];
  }

  if (isUpdatingOverallView) {
    [self updateOverallCardsView];
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

  [self handleTapInSpecificController:cardView];
  [self removeMatchedCards];
}

- (void) handleTapInSpecificController:(UIView *)cardView
{
}


- (void)removeMatchedCards
{
  NSMutableArray* matchedCardViews = [[NSMutableArray alloc] init];

  for (CardView* cardView in self.overallCardsView.subviews) {
    if (cardView.isMatched) {
      [matchedCardViews addObject:cardView];
    }
  }
  
  [self animateMatchedCardsRemoval:matchedCardViews];
}

- (void)animateMatchedCardsRemoval:(NSArray *)cardsToRemove
{
  [UIView animateWithDuration:1.0
                   animations:^{
                     for (UIView *card in cardsToRemove) {
                       int x = (arc4random()%(int)(self.view.bounds.size.width*5)) - (int)self.view.bounds.size.width*2;
                       int y = self.view.bounds.size.height;
                       card.center = CGPointMake(x, -y);
                     }
                   }
                   completion:^(BOOL finished) {
                     [self updateOverallCardsView];
                   }
   ];
}


@end
