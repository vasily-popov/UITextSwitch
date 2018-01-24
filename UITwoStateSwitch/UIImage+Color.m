//
//  UIImage+Color.m
//  Onesti
//
//  Created by Vasily Popov on 1/24/18.
//  Copyright © 2018 home.smart. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage*) replaceColor:(UIColor*)color inImage:(UIImage*)image
{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, false, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImage imageWithCGImage:img.CGImage];
}

@end
