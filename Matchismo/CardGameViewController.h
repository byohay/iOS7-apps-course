//
//  ViewController.h
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController


- (Deck*) createDeck; // abstract
- (NSUInteger) getMatchingMode; // abstract
- (NSAttributedString*) historyTitleForCard:(Card*) card; // abstract
- (void) updatedCardView:(UIView *) cardView withCard:(Card *)card; // abstract
@end
