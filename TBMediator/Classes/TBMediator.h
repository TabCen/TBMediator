//
//  CFMediator.h
//  CTMediator
//
//  Created by David on 2018/9/4.
//  Copyright © 2018年 casa. All rights reserved.
/**  本库的主要思想源于 https://github.com/casatwy/CTMediator 作者是个大帅哥
 *   前缀TB为公司项目糖吧的缩写，本人不喜欢用自己名字的缩写，很low
 */

#import <UIKit/UIKit.h>

typedef void(^CallBackBlock)(NSDictionary *callBackDic);

typedef void(^MediatorBlock)(NSDictionary *callBackDic);

///用协议的目的是在控制器头部方便重写方法
@protocol TBMediator <NSObject>

+ (void)mediatorLoad:(UIViewController *)fromVC params:(NSDictionary *)params handler:(MediatorBlock)block;

@end

///同协议名相同
static NSString * const MediatorFounctionName = @"mediatorLoad:params:handler:";

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

+ (id)performTargetClassName:(NSString *)className action:(SEL)action params:(id)params,... NS_REQUIRES_NIL_TERMINATION;

+ (id)performTarget:(NSObject *)target action:(SEL)action params:(id)params,... NS_REQUIRES_NIL_TERMINATION;
@end
