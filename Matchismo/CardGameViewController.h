//
//  ViewController.h
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "Grid.h"

@interface CardGameViewController : UIViewController


- (Deck*) createDeck; // abstract
- (NSUInteger) getMatchingMode; // abstract
- (void) updateCardView:(UIView *) cardView withCard:(Card *)card; // abstract
- (UIView*) createCardView:(CGRect)frame; // abstract
- (void)handleTapInSpecificController:(UIView *)overallCardsView
                               tappedCard:(UIView *)cardView; // abstract

@end
