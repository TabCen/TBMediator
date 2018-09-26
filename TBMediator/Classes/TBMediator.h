//
//  CFMediator.h
//  CTMediator
//
//  Created by David on 2018/9/4.
//  Copyright © 2018年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>
//+ (void)mediatorLoad:(UIViewController *)fromVC params:(NSDictionary *)params handler:(MediatorBlock)block{}
static NSString * const MediatorFounctionName = @"mediatorLoad:params:handler:";

typedef void(^CallBackBlock)(NSDictionary *callBackDic);

typedef void(^MediatorBlock)(NSDictionary *callBackDic);

@interface TBMediator : NSObject
///单例创建方法
+(instancetype)sharedInstance;

/**
 运行时创建控制器方法

 @param className 控制器类名
 @param params 参数
 @param viewController 调用者控制器
 @param callBack 回调
 */
+ (void)callViewController:(NSString *)className params:(NSDictionary *)params viewController:(UIViewController *)viewController callBack:(CallBackBlock)callBack;

@end
