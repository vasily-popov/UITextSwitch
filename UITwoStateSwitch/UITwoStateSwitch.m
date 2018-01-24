//
//  UITwoStateSwitch.m
//  TextSwitch
//
//  Created by Vasily Popov on 1/24/18.
//  Copyright © 2018 Vasily Popov. All rights reserved.
//

#import "UITwoStateSwitch.h"
#import "UIImage+Color.h"

@interface UITwoStateSwitch ()
{
    CAShapeLayer *_leftLayer;
    CAShapeLayer *_rightLayer;
    CALayer *_leftTextLayer;
    CALayer *_rightTextLayer;
    UILabel *leftLabel;
    UILabel *rightLabel;
    int switchInset;
    NSInteger _pointLayerWidth;
    
    CAShapeLayer *_rightBorderLayer;
    CAShapeLayer *_leftBorderLayer;
    
    CALayer *_leftImageLayer;
    CALayer *_rightImageLayer;
}

@property (nonatomic, strong, readonly) CAShapeLayer *leftLayer;
@property (nonatomic, strong, readonly) CAShapeLayer *rightLayer;
@property (nonatomic, strong, readonly) CALayer *leftTextLayer;
@property (nonatomic, strong, readonly) CALayer *rightTextLayer;

@end

@implementation UITwoStateSwitch

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setDefaultValues];
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setDefaultValues];
        [self setup];
    }
    
    return self;
}

-(void)dealloc {
    
}

-(void)setDefaultValues {
    _isActive = NO;
    _leftText = @"ON";
    _rightText = @"OFF";
    _offColor = [UIColor grayColor];
    _leftColor = [UIColor greenColor];
    _rightColor = [UIColor redColor];
    _borderColor = [UIColor colorWithRed:231.0/255.0 green:220.0/255.0 blue:235.0/255.0 alpha:1.0];
    _offItemBorderColor = [UIColor colorWithRed:231.0/255.0 green:220.0/255.0 blue:235.0/255.0 alpha:1.0];
    _backgroundColor = [UIColor whiteColor];
    _borderWidth = 1.0f;
    switchInset = 10.0f;
}

-(void)setup {
    self.layer.delegate = self;
    [self.layer addSublayer:self.leftLayer];
    [self.layer addSublayer:self.rightLayer];
    
    [self.layer addSublayer:self.leftTextLayer];
    [self.layer addSublayer:self.rightTextLayer];
    
    [self.layer addSublayer:self.leftImageLayer];
    [self.layer addSublayer:self.rightImageLayer];
    
    [self.layer addSublayer:self.leftBorderLayer];
    [self.layer addSublayer:self.rightBorderLayer];
    
    CGFloat height = self.bounds.size.height;
    self.layer.cornerRadius = height/2.0;
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.backgroundColor = _backgroundColor.CGColor;
    self.layer.borderWidth = _borderWidth;
}

-(CAShapeLayer* )leftBorderLayer {
    if(!_leftBorderLayer) {
        _leftBorderLayer = [CAShapeLayer new];
        [_leftBorderLayer setPath:_leftLayer.path];
        _leftBorderLayer.fillColor = [UIColor clearColor].CGColor;
        _leftBorderLayer.strokeColor = _offItemBorderColor.CGColor;
        _leftBorderLayer.lineWidth = 1;
        _leftBorderLayer.position =  CGPointMake(switchInset, switchInset/2);
    }
    return _leftBorderLayer;
}

-(CAShapeLayer* )rightBorderLayer {
    if(!_rightBorderLayer) {
        NSInteger startPointX = self.layer.bounds.size.width - self.switchPointDiameter-switchInset;
        _rightBorderLayer = [CAShapeLayer new];
        [_rightBorderLayer setPath:_rightLayer.path];
        _rightBorderLayer.fillColor = [UIColor clearColor].CGColor;
        _rightBorderLayer.strokeColor = _offItemBorderColor.CGColor;
        _rightBorderLayer.lineWidth = 1;
        _rightBorderLayer.position =  CGPointMake(startPointX, switchInset/2);
    }
    return _rightBorderLayer;
}

-(CAShapeLayer*)leftLayer
{
    if(!_leftLayer) {
        _leftLayer = [CAShapeLayer new];
        [_leftLayer setPath:self.getCirclePath.CGPath];
        _leftLayer.anchorPoint = CGPointMake(0,0);
        _leftLayer.fillColor = _offColor.CGColor;
        _leftLayer.borderWidth = 1;
        _leftLayer.borderColor = [UIColor blackColor].CGColor;
        _leftLayer.position = CGPointMake(switchInset, switchInset/2);
        
    }
    return _leftLayer;
}

-(CAShapeLayer*)rightLayer
{
    if(!_rightLayer) {
        _rightLayer = [CAShapeLayer new];
        [_rightLayer setPath:self.getCirclePath.CGPath];
        _rightLayer.anchorPoint = CGPointMake(0,0);
        _rightLayer.fillColor = _offColor.CGColor;
        _rightLayer.position = CGPointMake(switchInset, switchInset/2);
    }
    return _rightLayer;
}

-(UIBezierPath*) getCirclePath {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.switchPointDiameter, self.switchPointDiameter)];
    return path;
}

-(CALayer*)leftTextLayer
{
    if(!_leftTextLayer) {
        leftLabel = [UILabel new];
        leftLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.adjustsFontSizeToFitWidth = YES;
        leftLabel.minimumScaleFactor = 0.5;
        _leftTextLayer = leftLabel.layer;
        _leftTextLayer.backgroundColor = [UIColor clearColor].CGColor;
        _leftTextLayer.anchorPoint = CGPointMake(0,0);
    }
    return _leftTextLayer;
}

-(CALayer*)rightTextLayer
{
    if(!_rightTextLayer) {
        rightLabel = [UILabel new];
        rightLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.adjustsFontSizeToFitWidth = YES;
        rightLabel.minimumScaleFactor = 0.5;
        _rightTextLayer = rightLabel.layer;
        _rightTextLayer.backgroundColor = [UIColor clearColor].CGColor;
        _rightTextLayer.anchorPoint = CGPointMake(0,0);
    }
    return _rightTextLayer;
}


-(CALayer*)leftImageLayer
{
    if(!_leftImageLayer) {
        
        _leftImageLayer = [CALayer new];
        _leftImageLayer.anchorPoint = CGPointMake(0,0);
        _leftImageLayer.position = CGPointMake(switchInset, switchInset/2);
        
    }
    return _leftImageLayer;
}


-(CALayer*)rightImageLayer
{
    if(!_rightImageLayer) {
        NSInteger startPointX = self.layer.bounds.size.width - self.switchPointDiameter-switchInset;
        _rightImageLayer = [CALayer new];
        _rightImageLayer.anchorPoint = CGPointMake(0,0);
        _rightImageLayer.position = CGPointMake(startPointX, switchInset/2);
        
    }
    return _rightImageLayer;
}

-(NSInteger) switchPointDiameter {
    return MIN(self.layer.bounds.size.height, self.layer.bounds.size.width) - switchInset;
}

-(NSInteger)pointLayerWidth {
    _pointLayerWidth = self.switchPointDiameter + 2*switchInset;
    return _pointLayerWidth;
}

-(void)layoutSublayersOfLayer:(CALayer *)layer {
    
    [super layoutSublayersOfLayer:layer];
    
    if(layer != self.layer) {
        return;
    }
    
    //left layer
    {
        NSInteger startPointX = switchInset;
        [_leftLayer setPath:self.getCirclePath.CGPath];
        _leftLayer.position =  CGPointMake(startPointX, switchInset/2);
        [_leftLayer setFillColor:_isActive?_leftColor.CGColor:_offColor.CGColor];
        
        if(_leftIcon != nil) {
            _leftTextLayer.hidden = YES;
            _leftImageLayer.hidden = NO;
            UIImage *newImg = [UIImage replaceColor:_isActive?_leftTextColor:_offTextColor inImage:_leftIcon];
            _leftImageLayer.contents = (id)newImg.CGImage;
            _leftImageLayer.contentsGravity = kCAGravityResizeAspectFill;
            _leftImageLayer.bounds = CGRectMake(0, 0, self.switchPointDiameter/2, self.switchPointDiameter/2);
            _leftImageLayer.position = CGPointMake(startPointX + self.switchPointDiameter/4,
                                                   switchInset/2 + self.switchPointDiameter/4);
        }
        else {
            _leftTextLayer.hidden = NO;
            _leftImageLayer.hidden = YES;
            leftLabel.text = _leftText;
            leftLabel.textColor = _isActive?_leftTextColor:_offTextColor;
            [leftLabel sizeToFit];
            _leftTextLayer.bounds = CGRectMake(0, 0, self.switchPointDiameter, self.switchPointDiameter);
            _leftTextLayer.position = CGPointMake(startPointX, switchInset/2);
        }
        _leftBorderLayer.hidden = _isActive;
        
    }
    
    //right layer
    {
        NSInteger startPointX = self.layer.bounds.size.width - self.switchPointDiameter-switchInset;
        [_rightLayer setPath:self.getCirclePath.CGPath];
        _rightLayer.position =  CGPointMake(startPointX, switchInset/2);
        [_rightLayer setFillColor:!_isActive?_rightColor.CGColor:_offColor.CGColor];
        
        if(_rightIcon != nil) {
            _rightTextLayer.hidden = YES;
            _rightImageLayer.hidden = NO;
            UIImage *newImg = [UIImage replaceColor:!_isActive?_rightTextColor:_offTextColor inImage:_rightIcon];
            _rightImageLayer.contents = (id)newImg.CGImage;
            _rightImageLayer.contentsGravity = kCAGravityResizeAspectFill;
            _rightImageLayer.bounds = CGRectMake(0, 0,
                                                 self.switchPointDiameter/2, self.switchPointDiameter/2);
            _rightImageLayer.position = CGPointMake(startPointX + self.switchPointDiameter/4,
                                                    switchInset/2 + self.switchPointDiameter/4);
        }
        else {
            _rightTextLayer.hidden = NO;
            _rightImageLayer.hidden = YES;
            rightLabel.text = _rightText;
            rightLabel.textColor = !_isActive?_rightTextColor:_offTextColor;
            [rightLabel sizeToFit];
            _rightTextLayer.bounds = CGRectMake(0, 0, self.switchPointDiameter, self.switchPointDiameter);
            _rightTextLayer.position = CGPointMake(startPointX, switchInset/2);
        }
        
        _rightBorderLayer.hidden = !_isActive;
    }
}


-(void) updatePointPosition:(BOOL) animated {
    if (!animated) {
        [CATransaction begin];
        [CATransaction setValue:@YES forKey: kCATransactionDisableActions];
        [_leftLayer setFillColor:_isActive?_leftColor.CGColor:_offColor.CGColor];
        [_rightLayer setFillColor:!_isActive?_rightColor.CGColor:_offColor.CGColor];
        [CATransaction commit];
    } else {
        [_leftLayer setFillColor:_isActive?_leftColor.CGColor:_offColor.CGColor];
        [_rightLayer setFillColor:!_isActive?_rightColor.CGColor:_offColor.CGColor];
    }
}

- (void)setActive:(BOOL)active animated:(BOOL)animated
{
    if(_isActive != active) {
        _isActive = active;
        [self updatePointPosition:animated];
        [self.layer setNeedsLayout];
    }
}

#pragma mark -property

-(void)setIsActive:(BOOL)active {
    if(_isActive != active) {
        _isActive = active;
        [self updatePointPosition:NO];
        [self.layer setNeedsLayout];
    }
}

-(void)setLeftText:(NSString *)leftText {
    if(![_leftText isEqualToString:leftText]) {
        _leftText = leftText;
        if(_leftIcon == nil) {
            [self.layer setNeedsLayout];
        }
    }
}

-(void)setRightText:(NSString *)rightText {
    if(![_rightText isEqualToString:rightText]) {
        _rightText = rightText;
        if(_rightIcon == nil) {
            [self.layer setNeedsLayout];
        }
    }
}

-(void)setLeftIcon:(UIImage *)leftIcon {
    if(![_leftIcon isEqual:leftIcon]) {
        _leftIcon = leftIcon;
        [self.layer setNeedsLayout];
    }
}

-(void)setRightIcon:(UIImage *)rightIcon {
    if(![_rightIcon isEqual:rightIcon]) {
        _rightIcon = rightIcon;
        [self.layer setNeedsLayout];
    }
}

-(void)setLeftColor:(UIColor *)leftColor {
    if(![_leftColor isEqual:leftColor]) {
        _leftColor = leftColor;
        if(_isActive) {
            [_leftLayer setFillColor:_leftColor.CGColor];
        }
        else {
            [_leftLayer setFillColor:_offColor.CGColor];
        }
    }
}

-(void)setRightColor:(UIColor *)rightColor {
    if(![_rightColor isEqual:rightColor]) {
        _rightColor = rightColor;
        if(!_isActive) {
            [_rightLayer setFillColor:_rightColor.CGColor];
        }
        else {
            [_rightLayer setFillColor:_offColor.CGColor];
        }
    }
}

-(void)setOffColor:(UIColor *)offColor {
    if(![_offColor isEqual:offColor]) {
        _offColor = offColor;
        if(!_isActive) {
            [_leftLayer setFillColor:_offColor.CGColor];
        }
        else {
            [_rightLayer setFillColor:_offColor.CGColor];
        }
    }
}

-(void)setBorderColor:(UIColor *)borderColor {
    
    if(![_borderColor isEqual:borderColor]) {
        _borderColor = borderColor;
        self.layer.borderColor = _borderColor.CGColor;
    }
}

-(void)setOffItemBorderColor:(UIColor *)offItemBorderColor {
    if(![_offItemBorderColor isEqual:offItemBorderColor]) {
        _offItemBorderColor = offItemBorderColor;
        _rightBorderLayer.borderColor = _offItemBorderColor.CGColor;
        _leftBorderLayer.borderColor = _offItemBorderColor.CGColor;
    }
}


-(void)setBackgroundColor:(UIColor *)backgroundColor {
    if(![_backgroundColor isEqual:backgroundColor]) {
        _backgroundColor = backgroundColor;
        self.layer.backgroundColor = _backgroundColor.CGColor;
    }
}

-(void)setBorderWidth:(NSInteger)borderWidth {
    if(_borderWidth != borderWidth) {
        _borderWidth = borderWidth;
        self.layer.borderWidth = _borderWidth;
    }
}

#pragma mark - delegate

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if(touch) {
        CGPoint pt = [touch locationInView:self];
        CGPoint leftEdge = _leftLayer.position;
        CGFloat diameter = self.switchPointDiameter;
        CGRect r = CGRectMake(leftEdge.x, leftEdge.y, diameter,  diameter);
        if(CGRectContainsPoint(r, pt)) {
            
            if(!_isActive) {
                [self setActive:YES animated:YES];
                if(self.leftItemClickedBlock) {
                    self.leftItemClickedBlock(self);
                }
            }
        }
        else {
            leftEdge = _rightLayer.position;
            r = CGRectMake(leftEdge.x, leftEdge.y, diameter,  diameter);
            if(CGRectContainsPoint(r, pt)) {
                if(_isActive) {
                    [self setActive:NO animated:YES];
                    if(self.rightItemClickedBlock) {
                        self.rightItemClickedBlock(self);
                    }
                }
            }
        }
    }
}

@end

