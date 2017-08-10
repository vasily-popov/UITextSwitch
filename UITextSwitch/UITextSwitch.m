//
//  UITextSwitch.m
//  TextSwitch
//
//  Created by Vasily Popov on 8/10/17.
//  Copyright © 2017 Vasily Popov. All rights reserved.
//

#import "UITextSwitch.h"

@interface UITextSwitch ()
{
    CAShapeLayer *_pointLayer;
    CALayer *_textLayer;
    UILabel *textLabel;
    int switchInset;
    NSInteger _pointLayerWidth;
}

@property (nonatomic, strong, readonly) CAShapeLayer *pointLayer;
@property (nonatomic, strong, readonly) CALayer *textLayer;

@end

@implementation UITextSwitch

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
    _isOn = NO;
    _onText = @"ON";
    _offText = @"OFF";
    _offColor = [UIColor redColor];
    _onColor = [UIColor greenColor];
    _borderColor = [UIColor colorWithRed:231.0/255.0 green:220.0/255.0 blue:235.0/255.0 alpha:1.0];
    _backgroundColor = [UIColor whiteColor];
    _borderWidth = 1.0f;
    switchInset = 4.0f;
}

-(void)setup {
    self.layer.delegate = self;
    [self.layer addSublayer:self.pointLayer];
    [self.layer addSublayer:self.textLayer];
    CGFloat height = self.bounds.size.height;
    self.layer.cornerRadius = height/2.0;
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.backgroundColor = _backgroundColor.CGColor;
    self.layer.borderWidth = _borderWidth;
}

-(CAShapeLayer*)pointLayer
{
    if(!_pointLayer) {
        _pointLayer = [CAShapeLayer new];
        [_pointLayer setPath:self.getCirclePath.CGPath];
        _pointLayer.anchorPoint = CGPointMake(0,0);
        _pointLayer.fillColor = _offColor.CGColor;
        _pointLayer.position = CGPointMake(switchInset, switchInset/2);
        
    }
    return _pointLayer;
}

-(UIBezierPath*) getCirclePath {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.switchPointDiameter, self.switchPointDiameter)];
    return path;
}

-(CALayer*)textLayer
{
    if(!_textLayer) {
        textLabel = [UILabel new];
        textLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.adjustsFontSizeToFitWidth = YES;
        textLabel.minimumScaleFactor = 0.5;
        _textLayer = textLabel.layer;
        _textLayer.backgroundColor = [UIColor clearColor].CGColor;
        _textLayer.anchorPoint = CGPointMake(0,0);
    }
    return _textLayer;
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
    
    //point layer
    {
        NSInteger startPointX = switchInset;
        if(_isOn) {
            startPointX = self.layer.bounds.size.width - self.switchPointDiameter-switchInset;
        }
        [_pointLayer setPath:self.getCirclePath.CGPath];
        _pointLayer.position =  CGPointMake(startPointX, switchInset/2);
        [_pointLayer setFillColor:_isOn?_onColor.CGColor:_offColor.CGColor];
    }
    //textlayer
    {
        int width = self.layer.bounds.size.width - self.pointLayerWidth - switchInset;
        NSInteger startPointX = switchInset;
        if(_isOn) {
            textLabel.textColor = _onColor;
            textLabel.text = _onText;
        }
        else {
            textLabel.textColor = _offColor;
            textLabel.text = _offText;
            startPointX += _pointLayerWidth;
        }
        [textLabel sizeToFit];
        _textLayer.bounds = CGRectMake(0, 0, width, self.switchPointDiameter);
        _textLayer.position = CGPointMake(startPointX, 0);
    }
}


-(void) updatePointPosition:(BOOL) animated {
    
    CGPoint point = CGPointMake(switchInset, switchInset/2);
    if(_isOn) {
        int startPoint = self.layer.bounds.size.width - self.switchPointDiameter-switchInset;
        point = CGPointMake(startPoint, switchInset/2);
    }
    
    if (!animated) {
        [CATransaction begin];
        [CATransaction setValue:@YES forKey: kCATransactionDisableActions];
        _pointLayer.position = point;
        [_pointLayer setFillColor:_isOn?_onColor.CGColor:_offColor.CGColor];
        [CATransaction commit];
    } else {
        _pointLayer.position = point;
        [_pointLayer setFillColor:_isOn?_onColor.CGColor:_offColor.CGColor];
    }
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    if(_isOn != on) {
        _isOn = on;
        [self updatePointPosition:animated];
        [self.layer setNeedsLayout];
    }
}

#pragma mark -property

-(void)setIsOn:(BOOL)isOn {
    if(_isOn != isOn) {
        _isOn = isOn;
        [self updatePointPosition:NO];
        [self.layer setNeedsLayout];
    }
}

-(void)setOnText:(NSString *)onText {
    if(![_onText isEqualToString:onText]) {
        _onText = onText;
        [self.layer setNeedsLayout];
    }
}

-(void)setOffText:(NSString *)offText {
    if(![_offText isEqualToString:offText]) {
        _offText = offText;
        [self.layer setNeedsLayout];
    }
}

-(void)setOnColor:(UIColor *)onColor {
    if(![_onColor isEqual:onColor]) {
        _onColor = onColor;
        if(_isOn) {
            [_pointLayer setFillColor:_onColor.CGColor];
            textLabel.textColor = _onColor;
        }
    }
}

-(void)setOffColor:(UIColor *)offColor {
    if(![_offColor isEqual:offColor]) {
        _offColor = offColor;
        if(!_isOn) {
            [_pointLayer setFillColor:_offColor.CGColor];
            textLabel.textColor = _offColor;
        }
    }
}

-(void)setBorderColor:(UIColor *)borderColor {
    
    if(![_borderColor isEqual:borderColor]) {
        _borderColor = borderColor;
        self.layer.borderColor = _borderColor.CGColor;
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

@end
