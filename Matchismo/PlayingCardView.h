// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Ben Yohay.

// :: Framework ::
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView : CardView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
