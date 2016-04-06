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

  self.shape = @"diamond";

    if ([self.shape isEqual: @"diamond"]) {
      [self drawSquiggle:self.bounds.size.height/2];
    } else {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

#pragma mark -

#pragma mark - Drawing Squiggles

#pragma mark -

#define DISTANCE_FROM_CORNER_FACTOR 0.2
#define HEIGHT_SIZE_REVERSE_FACTOR 10


- (CGFloat) shapeHeight { return self.bounds.size.height / HEIGHT_SIZE_REVERSE_FACTOR; }


#define CONTROL_POINTS_RELATION_FACTOR 2
#define ORIGIN_SECOND_CONTROL_POINT_DISTANCE_FRACTION 0.5
#define REVERSE_AMPLITUDE_FACTOR 5
- (CGFloat) splitFactor
{
  return CONTROL_POINTS_RELATION_FACTOR > 1 ?
  CONTROL_POINTS_RELATION_FACTOR + 1 :
  CONTROL_POINTS_RELATION_FACTOR / 1 + 1;
}
- (CGFloat) amplitude { return self.bounds.size.height / REVERSE_AMPLITUDE_FACTOR; }

- (CGPoint) drawLongCurve:(UIBezierPath*) bezierPath startingAt:(CGPoint)point
{
  CGPoint nextPoint = CGPointMake(self.bounds.size.width - point.x, point.y);
  CGFloat distanceBetweenPoints = nextPoint.x - point.x;
  CGFloat firstPointSecondControlPointDistance = distanceBetweenPoints *
  ORIGIN_SECOND_CONTROL_POINT_DISTANCE_FRACTION;

  CGFloat first_control_point_x = point.x + (firstPointSecondControlPointDistance
    / [self splitFactor] * CONTROL_POINTS_RELATION_FACTOR);
  CGFloat second_control_point_x = point.x + firstPointSecondControlPointDistance;

  [bezierPath moveToPoint: point];
  [bezierPath addCurveToPoint: nextPoint
                controlPoint1: CGPointMake(first_control_point_x, point.y + [self amplitude])
                controlPoint2: CGPointMake(second_control_point_x, point.y - [self amplitude])];

  return nextPoint;
}

#define SHORT_CURVE_CONTROL_POINTS_RELATION_FACTOR 1
- (void) drawShortCurve:(UIBezierPath*) bezierPath startingAt:(CGPoint)point
{
  CGFloat pointsDelta = [self shapeHeight] * (1 / (SHORT_CURVE_CONTROL_POINTS_RELATION_FACTOR + 2));
  CGFloat firstPointHeight = point.y + pointsDelta;
  CGFloat secondPointHeight = firstPointHeight + pointsDelta;

  CGFloat amplitude = 1;

  [bezierPath moveToPoint: point];
  [bezierPath addCurveToPoint: CGPointMake(point.x, point.y + [self shapeHeight])
                controlPoint1: CGPointMake(point.x + amplitude, firstPointHeight)
                controlPoint2: CGPointMake(point.x + amplitude, secondPointHeight)];
}

- (void)drawShapeUpsideDown:(UIBezierPath *)bezierPath withOrigin:(CGPoint)origin
                secondPoint:(CGPoint)secondPoint
{
  CGFloat mirrorYMove = origin.y + [self shapeHeight] -
  origin.y * (self.bounds.size.height / origin.y - 1);
  
  CGAffineTransform mirror = CGAffineTransformMakeRotation(M_PI);
  CGAffineTransform translate = CGAffineTransformMakeTranslation(self.bounds.size.width, self.bounds.size.height);
  CGAffineTransform moveToPlace = CGAffineTransformMakeTranslation(-secondPoint.x + 4 * origin.x,
                                                                   mirrorYMove);
  
  [bezierPath applyTransform:mirror];
  [bezierPath applyTransform:translate];
  [bezierPath applyTransform:moveToPlace];
  
  [bezierPath stroke];
}

- (void) drawSquiggle:(CGFloat)height
{
  UIBezierPath* bezierPath = [UIBezierPath bezierPath];
  [[UIColor blackColor] setStroke];

  CGFloat originHeight = height - [self shapeHeight] / 2;

  CGPoint origin = CGPointMake(self.bounds.size.width * DISTANCE_FROM_CORNER_FACTOR,
                               originHeight);

  CGPoint secondPoint = [self drawLongCurve:bezierPath startingAt:origin];
  [self drawShortCurve:bezierPath startingAt:secondPoint];
  [bezierPath stroke];

  [self drawShapeUpsideDown:bezierPath withOrigin:origin
                secondPoint:secondPoint];
}

#pragma mark -

@end


NS_ASSUME_NONNULL_END
