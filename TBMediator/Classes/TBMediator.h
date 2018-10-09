//
//  CFMediator.h
//  CTMediator
//
//  Created by David on 2018/9/4.
//  Copyright © 2018年 casa. All rights reserved.
/**  本库的主要思想源于 https://github.com/casatwy/CTMediator 作者是个大帅哥
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


/**
 调用某一个类的实例（类名className）方法action，可变参数为params

 @param className 类名
 @param action 方法
 @param params 参数
 @return 返回
 */
+ (id)performTargetClassName:(NSString *)className action:(SEL)action params:(id)params,... NS_REQUIRES_NIL_TERMINATION;


/**
 调用target对象中的某一个action方法，并且传递参数params，参数为可变参数

 @param target 对象
 @param action 方法
 @param params 参数
 @return 返回
 */
+ (id)performTarget:(NSObject *)target action:(SEL)action params:(id)params,... NS_REQUIRES_NIL_TERMINATION;

/**
 URL调用法
 scheme://[target]/[action]?[params]
 参数被拼接成一个字典
 所以在类中写法如
 -(NSString *)testForUrl:(id)sender{
 NSLog(@"%@",sender);
 return @"12345678";
 }
 @param url 传递的url 如 "tb://TBViewController/testForUrl:?a=12&b=14"
 @param completion 结束回掉
 @return 调用方法的返回
 */
+ (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *dict))completion;

@end
