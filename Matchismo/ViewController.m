//
//  ViewController.m
//  Matchismo
//
//  Created by Ben Yohay on 28/03/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flips_label;
@property (nonatomic) int flipsCount;
@property (strong, nonatomic) Deck* deck;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setFlipsCount:(int)flipsCount
{
    _flipsCount = flipsCount;
    self.flips_label.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
}


- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]){
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState: (UIControlStateNormal)];
        [sender setTitle:@"" forState: (UIControlStateNormal)];
    }
    else{
        Card* card = [self.deck drawRandomCard];
        
        if (!card) {
            return;
        }

        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState: (UIControlStateNormal)];
        
        [sender setTitle:card.contents forState: (UIControlStateNormal)];
    }
    
    self.flipsCount++;
}

- (Deck*)deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}


@end
