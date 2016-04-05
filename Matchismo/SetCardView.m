// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Ben Yohay.

#import "SetCardView.h"
#import "CardViewConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardView

#pragma mark -

#pragma mark Properties

#pragma mark -

#pragma mark Initialization

#pragma mark -

- (void) setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib
{
    [self setup];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


#pragma mark -

#pragma mark UIView

#pragma mark -


- (void) drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:
                               [CardViewConfiguration cornerRadius:self.bounds.size.height]];

    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if ([self.shape isEqual: @"diamond"]) {
        [self drawDiamond];
    } else {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

#pragma mark -

#pragma mark - Drawing

#pragma mark -

- (void) drawDiamond
{
    
}

#pragma mark -

@end


NS_ASSUME_NONNULL_END
