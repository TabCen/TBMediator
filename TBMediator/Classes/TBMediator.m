//
//  CFMediator.m
//  CTMediator
//
//  Created by David on 2018/9/4.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "TBMediator.h"

@implementation TBMediator

static TBMediator *shareFile = nil;

#pragma mark - 单例

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareFile = [super allocWithZone:zone];
    });
    return shareFile;
}

+(instancetype)sharedInstance{
    shareFile = [[self alloc] init];
    return shareFile;
}

-(id)copyWithZone:(NSZone *)zone{
    return shareFile;
}

#pragma mark - 本地方法调用

+ (void)callViewController:(NSString *)className params:(NSDictionary *)params viewController:(UIViewController *)viewController callBack:(CallBackBlock)callBack{
    NSAssert(className, @"类名不能为空");
    NSAssert(viewController, @"类名不能为空");
    ///类
    Class targetClass = NSClassFromString(className);
    if (!targetClass) {
        NSLog(@"调用控制器不存在_className:> %@",className);
        return;
    }
    SEL action = NSSelectorFromString(MediatorFounctionName);

    ///方法签名
    NSMethodSignature *methodSig = [targetClass methodSignatureForSelector:action];
    
    if (!methodSig) {
        NSLog(@"方法不存在_Founction:> [%@ %@]",className,MediatorFounctionName);
        return;
    }
    ///
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setTarget:targetClass];//0
    [invocation setSelector:action];//1
    [invocation setArgument:&viewController atIndex:2];//fromVC
    [invocation setArgument:&params atIndex:3];//params
    [invocation setArgument:&callBack atIndex:4];//block
    [invocation invoke];
}

#pragma mark - 远程方法调用

@end
