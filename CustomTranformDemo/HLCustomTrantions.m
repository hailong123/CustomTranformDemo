//
//  HLCustomTrantions.m
//  CustomTranformDemo
//
//  Created by 123456 on 2016/11/30.
//  Copyright © 2016年 KuXing. All rights reserved.
//

#import "HLCustomTrantions.h"

#import "ViewController.h"
#import "TwoViewController.h"

@interface HLCustomTrantions ()

@property (nonatomic, assign) HLTransitionType type;

@end

@implementation HLCustomTrantions

//实例化
#pragma mark - Cycle
- (instancetype)initWithTransitionType:(HLTransitionType)type {
    
    if (self = [super init]) {

        _type = type;
        
    }

    return self;
}

+ (instancetype)transitionWithType:(HLTransitionType)type {
    
    return [[[self class] alloc] initWithTransitionType:type];
    
}

//动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.25;
    
}

#pragma mark - 动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (_type) {
        case HLTransitionTypePersent:
        {
            [self presentWithTransitionContext:transitionContext];
        }
            break;
            
        case HLTransitionTypeDismiss:
        {
            [self dismissWithTransitionContext:transitionContext];
        }
            break;
    }
    
}

#pragma mark -Private
- (void)presentWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {

    //通过key取出转场后的两个控制器
    TwoViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ViewController *fromVC  = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame   = fromVC.view.frame;
    //containerView管理者所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    //将截图视图和vc2的view都加入ContainerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    //设置vc2的frame
    toVC.navgationView.frame = CGRectMake(0, -CGRectGetWidth(containerView.frame),
                                              CGRectGetWidth(containerView.frame),
                                              CGRectGetWidth(containerView.frame) * 0.3);
    
    toVC.tableView.frame     = CGRectMake(0, CGRectGetHeight(containerView.frame),
                                             CGRectGetWidth(containerView.frame),
                                             CGRectGetHeight(containerView.frame)*0.7);
    //开始自定义转场动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.8f
          initialSpringVelocity:6.5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
        toVC.navgationView.frame = CGRectMake(0, 0, CGRectGetWidth(containerView.frame),
                                                    CGRectGetWidth(containerView.frame) * 0.3);
        
        toVC.tableView.frame     = CGRectMake(0, CGRectGetHeight(containerView.frame)*0.3,
                                                 CGRectGetWidth(containerView.frame),
                                                 CGRectGetHeight(containerView.frame)*0.7);
    } completion:^(BOOL finished) {
        //标记转场的状态
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            //失败后
            fromVC.view.hidden = NO;
            [tempView removeFromSuperview];
            
        } else {
            
            fromVC.view.transform    = CGAffineTransformIdentity;
            fromVC.imgView.transform = CGAffineTransformIdentity;
            
        }
        
    }];
}

- (void)dismissWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    //取出控制器
    TwoViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView  = [transitionContext containerView];
    NSArray *subviewsArray = containerView.subviews;
    UIView *tempView       = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
    //自定义转场
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        //设置vc2的frame
        fromVC.navgationView.frame = CGRectMake(0, -CGRectGetHeight(containerView.frame),
                                                    CGRectGetWidth(containerView.frame),
                                                    CGRectGetWidth(containerView.frame) * 0.3);

        fromVC.tableView.frame        = CGRectMake(0, CGRectGetHeight(containerView.frame),
                                                      CGRectGetWidth(containerView.frame),
                                                      CGRectGetHeight(containerView.frame)*0.7);
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            //失败
            [transitionContext completeTransition:NO];
        }else{
            //成功
            [transitionContext completeTransition:YES];
            
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];

}
@end
