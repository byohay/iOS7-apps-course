// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Ben Yohay.

// :: Framework ::
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : UIView

@property (nonatomic) int numberOfSymbols;
@property (strong, nonatomic) NSString* shape;
@property (strong, nonatomic) UIColor* color;
@property (strong, nonatomic) NSString* shading;

@end

NS_ASSUME_NONNULL_END
