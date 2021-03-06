// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Ben Yohay.

#import "SetCardView.h"
#import "CardViewConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView()

@property (strong, nonatomic) NSDictionary* stringToUIColor;

@end

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


- (void)fillCardBack
{
  if (self.isChosen) {
    UIGraphicsBeginImageContext(self.frame.size);
    [[UIImage imageNamed:@"bluebackground"] drawInRect:self.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[UIColor colorWithPatternImage:image] setFill];
  }
  else {
    [[UIColor whiteColor] setFill];
  }
}

- (void) drawRect:(CGRect)rect
{
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:
                               [CardViewConfiguration cornerRadius:self.bounds.size.height]];

  [roundedRect addClip];

  [self fillCardBack];

  UIRectFill(self.bounds);

  [[UIColor blackColor] setStroke];
  [roundedRect stroke];

  if (self.numberOfSymbols == 1) {
    [self drawRightShapeAtHeight:self.bounds.size.height / 2];
  }
  else if (self.numberOfSymbols == 2) {
    [self drawRightShapeAtHeight:self.bounds.size.height / 3];
    [self drawRightShapeAtHeight:self.bounds.size.height / 3 * 2];
  }
  else {
    [self drawRightShapeAtHeight:self.bounds.size.height / 4];
    [self drawRightShapeAtHeight:self.bounds.size.height / 2];
    [self drawRightShapeAtHeight:self.bounds.size.height / 4 * 3];
  }
}

#pragma mark -

#pragma mark - Drawing By Features

- (void) drawRightShapeAtHeight:(CGFloat) height
{
  if ([self.shape isEqual: @"squiggle"]) {
    [self drawSquiggle:height];
  }
  else if ([self.shape isEqual: @"diamond"]) {
    [self drawDiamond:height];
  }
  else if ([self.shape isEqual:@"roundedRect"]) {
    [self drawRoundedRect:height];
  }
}

#pragma mark -

#pragma mark - Drawing

#pragma mark -

#define DISTANCE_FROM_CORNER_FACTOR 0.2
#define HEIGHT_SIZE_REVERSE_FACTOR 10

- (CGFloat) shapeHeight { return self.bounds.size.height / HEIGHT_SIZE_REVERSE_FACTOR; }
- (CGFloat) shapeLeftmostX { return self.bounds.size.width * DISTANCE_FROM_CORNER_FACTOR; }
- (CGFloat) shapeWidth { return self.bounds.size.width * (1 - DISTANCE_FROM_CORNER_FACTOR * 2); }

- (UIBezierPath*) getUpsideDownPath:(UIBezierPath *)bezierPath withOrigin:(CGPoint)origin
                          withYMove:(CGFloat)YMove
{
  CGFloat XMove = - self.bounds.size.width + (origin.x / DISTANCE_FROM_CORNER_FACTOR);

  UIBezierPath* upsideDownPath = [UIBezierPath bezierPathWithCGPath:bezierPath.CGPath];
  CGAffineTransform mirror = CGAffineTransformMakeRotation(M_PI);
  CGAffineTransform moveWithinBounds = CGAffineTransformMakeTranslation(self.bounds.size.width, self.bounds.size.height);
  CGAffineTransform moveToPlace = CGAffineTransformMakeTranslation(XMove,
                                                                   YMove);

  [upsideDownPath applyTransform:mirror];
  [upsideDownPath applyTransform:moveWithinBounds];
  [upsideDownPath applyTransform:moveToPlace];

  return [upsideDownPath bezierPathByReversingPath];
}

#define STRIPE_LINE_WIDTH_FACTOR 80
#define STRIPE_JUMP_FACTOR 40

- (CGFloat) stripeWidth { return self.bounds.size.width / STRIPE_LINE_WIDTH_FACTOR; }
- (int) stripeJump { return roundf(self.bounds.size.width / STRIPE_JUMP_FACTOR); }

- (void) setStripedFill: (UIBezierPath *)bezierPath
{
  UIBezierPath *stripes = [UIBezierPath bezierPath];
  for ( int x = 0; x < bezierPath.bounds.size.width; x += [self stripeJump])
  {
    [stripes moveToPoint:CGPointMake( bezierPath.bounds.origin.x + x, bezierPath.bounds.origin.y)];
    [stripes addLineToPoint:CGPointMake( bezierPath.bounds.origin.x + x, bezierPath.bounds.origin.y + bezierPath.bounds.size.height)];
  }
  [stripes setLineWidth:[self stripeWidth]];

  [self.color set];
  [stripes stroke];
}

- (void) fillShape: (UIBezierPath *)bezierPath
{
  if ([self.fill isEqualToString:@"transparent"]) {
    return;
  }
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);

  [bezierPath addClip];

  if ([self.fill isEqualToString:@"filled"]) {
    [self.color setFill];
    UIRectFill(CGPathGetBoundingBox(bezierPath.CGPath));
  }
  else {
    [self setStripedFill:bezierPath];
  }

  CGContextRestoreGState(context);
}

- (void) drawShape: (UIBezierPath *)bezierPath
{
  bezierPath.lineWidth = [self strokeWidth];
  [self.color setStroke];

  [bezierPath stroke];
  [self fillShape:bezierPath];
}

#define STROKE_WIDTH_PICTURE_RELATION 50
- (CGFloat) strokeWidth { return  sqrt(self.bounds.size.height * self.bounds.size.width)
    / STROKE_WIDTH_PICTURE_RELATION; }

#pragma mark -

#pragma mark - Drawing Squiggles

#pragma mark -


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

  [bezierPath addCurveToPoint: CGPointMake(point.x, point.y + [self shapeHeight])
                controlPoint1: CGPointMake(point.x + amplitude, firstPointHeight)
                controlPoint2: CGPointMake(point.x + amplitude, secondPointHeight)];
}

- (void) drawSquiggle:(CGFloat)height
{
  UIBezierPath* bezierPath = [UIBezierPath bezierPath];

  CGFloat originHeight = height - [self shapeHeight] / 2;

  CGPoint origin = CGPointMake([self shapeLeftmostX], originHeight);

  CGPoint secondPoint = [self drawLongCurve:bezierPath startingAt:origin];
  [self drawShortCurve:bezierPath startingAt:secondPoint];

  CGFloat YMove = origin.y + [self shapeHeight] -
  origin.y * (self.bounds.size.height / origin.y - 1);

  UIBezierPath* upsideDownPath = [self getUpsideDownPath:bezierPath withOrigin:origin
                                               withYMove:YMove];

  [bezierPath appendPath:upsideDownPath];

  [self drawShape:bezierPath];
}

#pragma mark -

#pragma mark - Drawing Diamonds

- (void) drawDiamond:(CGFloat)height
{
  UIBezierPath* bezierPath = [UIBezierPath bezierPath];

  CGPoint origin = CGPointMake([self shapeLeftmostX], height);

  [bezierPath moveToPoint: origin];
  [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width / 2,
                                         origin.y - [self shapeHeight] / 2)];
  [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width - origin.x, origin.y)];

  UIBezierPath* upsideDownPath = [self getUpsideDownPath:bezierPath withOrigin:origin
                                               withYMove:0];

  [bezierPath appendPath:upsideDownPath];

  [self drawShape:bezierPath];
}

#pragma mark -

#pragma mark - Drawing Rounded Rect

#define SHAPE_CORNER_RADIUS 20

- (void) drawRoundedRect:(CGFloat)height
{
  CGRect shapeRect;
  shapeRect.origin = CGPointMake([self shapeLeftmostX], height - [self shapeHeight] / 2);
  shapeRect.size = CGSizeMake([self shapeWidth], [self shapeHeight]);

  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:shapeRect cornerRadius:
                              SHAPE_CORNER_RADIUS];

  [self drawShape:bezierPath];
}

@end


NS_ASSUME_NONNULL_END
