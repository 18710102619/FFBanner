//
//  UIView+WBJobExtension.h
//  Pods
//
//  Created by 张玲玉 on 16/8/12.
//
//

#import <UIKit/UIKit.h>

#define kMainScreen_Width [[UIScreen mainScreen] bounds].size.width
#define kMainScreen_Height [[UIScreen mainScreen] bounds].size.height

@interface UIView (WBJobExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@end
