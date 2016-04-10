//
//  SetViewController.m
//  Matchismo
//
//  Created by Ben Yohay on 31/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

@interface SetViewController()

@end

@implementation SetViewController

- (Deck*) createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSUInteger) getMatchingMode
{
    return 3;
}

- (NSString*) getShape:(int) shape
{
  if (shape == 1) {
    return @"squiggle";
  }
  else if (shape == 2) {
    return @"diamond";
  }

  return @"roundedRect";
}

- (UIColor*) getColor:(int) color
{
  if (color == 1) {
    return [UIColor redColor];
  }
  else if (color == 2) {
    return [UIColor purpleColor];
  }

  return [UIColor greenColor];
}

- (NSString*) getShading:(int) shading
{
  if (shading == 1) {
    return @"transparent";
  }
  else if (shading == 2) {
    return @"filled";
  }

  return @"striped";
}

- (void) updateCardView:(UIView *) cardView withCard:(Card *)card
{
  SetCard *setCard = (SetCard *)card;
  SetCardView* setCardView = (SetCardView *)cardView;

  setCardView.shape = [self getShape:setCard.shape];
  setCardView.color = [self getColor:setCard.color];
  setCardView.fill = [self getShading:setCard.shading];
  setCardView.numberOfSymbols = setCard.numberOfSymbols;
}


- (UIView*) createCardView:(CGRect)frame
{
  return [[SetCardView alloc] initWithFrame:frame];
}

@end

