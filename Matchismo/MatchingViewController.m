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

- (double)handleTapInSpecificController:(UIView *)cardView
{
  double duration = 0.5;
  [UIView transitionWithView:cardView
                    duration:duration
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:^{}
                  completion:^(BOOL fin){}];

  return duration + 0.2;
}

@end
