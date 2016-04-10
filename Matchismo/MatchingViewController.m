//
//  MatchingViewController.m
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "MatchingViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface MatchingViewController()

@end

@implementation MatchingViewController

- (Deck*) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger) getMatchingMode
{
    return 2;
}

- (NSAttributedString*) historyTitleForCard:(Card*) card
{
    return [[NSAttributedString alloc] initWithString: card.contents];
}

- (void) updateCardView:(UIView *) cardView withCard:(Card *)card
{
    PlayingCard *playingCard = (PlayingCard *)card;
    PlayingCardView* playingCardView = (PlayingCardView *)cardView;
    
    playingCardView.suit = playingCard.suit;
    playingCardView.rank = playingCard.rank;
    playingCardView.faceUp = playingCard.isChosen;
}

- (UIView*) createCardView:(CGRect)viewFrame
{
  return [[PlayingCardView alloc] initWithFrame:viewFrame];
}

@end
