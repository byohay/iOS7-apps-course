// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Ben Yohay.

#import "CardViewConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CardViewConfiguration

#define CORNER_RADIUS 12.0
#define CORNER_FONT_STANDARD_HEIGHT 180.0

+ (CGFloat) cornerScaleFactor: (CGFloat) cardHeight; { return cardHeight / CORNER_FONT_STANDARD_HEIGHT; }
+ (CGFloat) cornerRadius: (CGFloat) cardHeight; { return CORNER_RADIUS * [self cornerScaleFactor:cardHeight]; }
+ (CGFloat) cornerOffset: (CGFloat) cardHeight; { return [self cornerRadius:cardHeight] / 3.0; }

@end

NS_ASSUME_NONNULL_END
