// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Ben Yohay.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardViewConfiguration : NSObject

+ (CGFloat) cornerScaleFactor: (CGFloat) cardHeight;
+ (CGFloat) cornerRadius: (CGFloat) cardHeight;
+ (CGFloat) cornerOffset: (CGFloat) cardHeight;

@end

NS_ASSUME_NONNULL_END
