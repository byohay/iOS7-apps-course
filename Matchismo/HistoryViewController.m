//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Ben Yohay on 03/04/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "HistoryViewController.h"

@interface  HistoryViewController()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) updateUI
{
    NSMutableAttributedString* textToDisplay = [[NSMutableAttributedString alloc] init];
    
    for (NSAttributedString* historyLine in self.history) {
        NSMutableAttributedString* historyLineWithEnter = [[NSMutableAttributedString alloc] initWithAttributedString:historyLine];
        [historyLineWithEnter appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n" ]];
        
        [textToDisplay appendAttributedString:historyLineWithEnter];
    }
    
    self.historyTextView.attributedText = textToDisplay;
}

@end
