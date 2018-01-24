//
//  UITwoStateSwitch.h
//  TextSwitch
//
//  Created by Vasily Popov on 1/24/18.
//  Copyright © 2018 Vasily Popov. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE @interface UITwoStateSwitch : UIControl

@property (nonatomic, readonly) IBInspectable BOOL isActive;

//left state
@property (nonatomic, strong) IBInspectable NSString *leftText;
@property (nonatomic, strong) IBInspectable UIImage *leftIcon;
@property (nonatomic, strong) IBInspectable UIColor *leftColor;
@property (nonatomic, strong) IBInspectable UIColor *leftTextColor;

//right state
@property (nonatomic, strong) IBInspectable NSString *rightText;
@property (nonatomic, strong) IBInspectable UIImage *rightIcon;
@property (nonatomic, strong) IBInspectable UIColor *rightColor;
@property (nonatomic, strong) IBInspectable UIColor *rightTextColor;

//colors for inactive state
@property (nonatomic, strong) IBInspectable UIColor *offColor;
@property (nonatomic, strong) IBInspectable UIColor *offTextColor;
@property (nonatomic, strong) IBInspectable UIColor *offItemBorderColor;

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, strong) IBInspectable UIColor *backgroundColor;
@property (nonatomic) IBInspectable NSInteger borderWidth;

@property (nonatomic, copy) void (^leftItemClickedBlock)(UITwoStateSwitch *control);
@property (nonatomic, copy) void (^rightItemClickedBlock)(UITwoStateSwitch *control);

- (void)setActive:(BOOL)active animated:(BOOL)animated;

@end
