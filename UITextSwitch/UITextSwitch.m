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
    CALayer *_commonLayer;
    CAShapeLayer *_pointLayer;
    CALayer *_textLayer;
    UILabel *textLabel;
    int switchInset;
}

@property (nonatomic, strong, readonly) CALayer *commonLayer;
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
    switchInset = 2.0f;
}

-(void)setup {
    self.layer.delegate = self;
    [self.layer addSublayer:self.commonLayer];
    [self.layer addSublayer:self.pointLayer];
    [self.layer addSublayer:self.textLayer];
}

-(CALayer*)commonLayer
{
    if(!_commonLayer) {
        CGFloat height = self.bounds.size.height;
        _commonLayer = [CALayer new];
        _commonLayer.cornerRadius = height/2.0;
        _commonLayer.anchorPoint = CGPointMake(0,0);
        _commonLayer.bounds = self.bounds;
        _commonLayer.backgroundColor = _backgroundColor.CGColor;
        _commonLayer.position = CGPointMake(0, 0);
        _commonLayer.borderColor = _borderColor.CGColor;
        _commonLayer.borderWidth = _borderWidth;
    }
    return _commonLayer;
}

-(CAShapeLayer*)pointLayer
{
    if(!_pointLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.switchPointDiameter, self.switchPointDiameter)];
        _pointLayer = [CAShapeLayer new];
        [_pointLayer setPath:path.CGPath];
        _pointLayer.anchorPoint = CGPointMake(0,0);
        _pointLayer.fillColor = _onColor.CGColor;
    }
    return _pointLayer;
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
    return MIN(self.layer.bounds.size.height, self.layer.bounds.size.width)/2 - switchInset;
}

@end
