//
//  YZQRImageTool.h
//  Funny
//
//  Created by yanzhen on 17/1/7.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZQRImageTool : NSObject
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;
@end
