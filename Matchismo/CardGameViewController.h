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
- (NSString*) titleForCard:(Card*) card; // abstract
- (UIImage*) imageForCard:(Card*) card;  // abstract

@end
