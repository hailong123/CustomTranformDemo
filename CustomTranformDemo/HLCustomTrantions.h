//
//  HLCustomTrantions.h
//  CustomTranformDemo
//
//  Created by 123456 on 2016/11/30.
//  Copyright © 2016年 KuXing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//转场的类型
typedef NS_ENUM(NSInteger, HLTransitionType) {
    
    HLTransitionTypePersent,
    HLTransitionTypeDismiss
    
};

@interface HLCustomTrantions : NSObject<UIViewControllerAnimatedTransitioning>

//构建实例
+ (instancetype)transitionWithType:(HLTransitionType)type;
- (instancetype)initWithTransitionType:(HLTransitionType)type;


@end
