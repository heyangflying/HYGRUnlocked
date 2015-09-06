//
//  HYLockView.h
//  HYGestureUnlocked
//
//  Created by heyang on 15/8/20.
//  Copyright (c) 2015年 com.scxingdun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYLockView;

//连线协议
@protocol HYLockViewDelegate <NSObject>

- (void)HYLockView:(HYLockView *)lockView didSelectedPassword:(NSString *)password;

@end

@interface HYLockView : UIView

@property (weak,nonatomic) id<HYLockViewDelegate> delegate;


+ (id)showInView:(UIView *)view andTarget:(id)target;

@end
