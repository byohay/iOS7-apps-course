// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Ben Yohay.

// :: Framework ::
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : CardView

@property (nonatomic) int numberOfSymbols;
@property (strong, nonatomic) NSString* shape;
@property (strong, nonatomic) UIColor* color;
@property (strong, nonatomic) NSString* fill;
@property (nonatomic) BOOL isChosen;

@end

NS_ASSUME_NONNULL_END
