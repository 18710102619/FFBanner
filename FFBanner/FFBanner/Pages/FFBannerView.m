//
//  QHBanner.m
//  WBQuickToHire
//
//  Created by 张玲玉 on 16/3/11.
//  Copyright © 2016年 bj.58.com. All rights reserved.
//

#import "FFBannerView.h"

@implementation FFBannerView

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapGesture:(UITapGestureRecognizer *)tap
{
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(bannerClicked:)]) {
        [self.delegate bannerClicked:self.model];
    }
}

@end
