//
//  CFMediator.m
//  CTMediator
//
//  Created by David on 2018/9/4.
//  Copyright © 2018年 casa. All rights reserved.
/**  本库的主要思想源于 https://github.com/casatwy/CTMediator 作者是个大帅哥
 *   前缀TB为公司项目 糖吧 的缩写
 */
#import "TBMediator.h"

#define tbStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO ||[str isEqualToString:@"(null)"])

@interface TBMediator ()

///用于缓存可能需要缓存的target
@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

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
    
    NSString *errStr = [NSString stringWithFormat:@"调用控制器不存在_className:>%@",className];
    NSAssert(targetClass, errStr);
    
    SEL action = NSSelectorFromString(MediatorFounctionName);
    
    ///方法签名
    NSMethodSignature *methodSig = [targetClass methodSignatureForSelector:action];
    
    NSString *errStr2 = [NSString stringWithFormat:@"方法不存在action:>[%@ %@]",className,MediatorFounctionName];
    NSAssert(methodSig, errStr2);

    ///消息发送其实也可以采用代理的方法，调用代理方法
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setTarget:targetClass];//0
    [invocation setSelector:action];//1
    [invocation setArgument:&viewController atIndex:2];//fromVC
    [invocation setArgument:&params atIndex:3];//params
    [invocation setArgument:&callBack atIndex:4];//block
    [invocation invoke];
}

+ (id)performTargetClassName:(NSString *)className action:(SEL)action params:(id)params,... NS_REQUIRES_NIL_TERMINATION{
    NSAssert(!tbStringIsEmpty(className), @"类名不能为空");
    NSObject *target;
    Class targetClass = NSClassFromString(className);
    target = [[targetClass alloc]init];
    
    NSString *errStr = [NSString stringWithFormat:@"对象生成失败_className:>%@",className];
    NSAssert(target, errStr);

    if([target respondsToSelector:action]){////不定参数的传递不会m，所以直接将下面的方法原封不动得超过来、
        va_list args;
        va_start(args, params);
        id value = [self performTarget:target action:action params:params orVAList:args];
        va_end(args);
        return value;
    }else{
        return nil;
    }
}
///本地调用对象方法
+ (id)performTarget:(NSObject *)target action:(SEL)action params:(id)params,... NS_REQUIRES_NIL_TERMINATION{
    va_list args;
    va_start(args, params);
    id value = [self performTarget:target action:action params:params orVAList:args];
    va_end(args);
    return value;
}
///调用方法
+ (id)performTarget:(NSObject *)target action:(SEL)action params:(id)params orVAList:(va_list)args{
    ///方法签名
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    NSString *errStr = [NSString stringWithFormat:@"方法不存在action:>[%@ %@]",NSStringFromClass([target class]),NSStringFromSelector(action)];
    NSAssert(methodSig, errStr);
  
    ///传参、调用
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setTarget:target];  //0
    [invocation setSelector:action];//1
    //如果无参数则直接invoke
    if(!params){
        [invocation invoke];
    }else{
        [invocation setArgument:&params atIndex:2];
        if (args) {
            id arg;
            int index = 3;
            while((arg = va_arg(args, id))){
                [invocation setArgument:&arg atIndex:index];
                ++index;
            }
        }
        [invocation invoke];
    }
    ///方法返回类型
    const char* retType = [methodSig methodReturnType];
    ///返回为void
    if (strcmp(retType, @encode(void)) == 0) {
        return nil;
    }
    
    ///返回int型
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    ///返回bool型
    if (strcmp(retType, @encode(BOOL)) == 0) {
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    ///返回float型
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    ///返回UInt型
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    ///原因是在arc模式下，getReturnValue：仅仅是从invocation的返回值拷贝到指定的内存地址，如果返回值是一个NSObject对象的话，是没有处理起内存管理的。而我们在定义resultSet时使用的是__strong类型的指针对象，arc就会假设该内存块已被retain（实际没有），当resultSet出了定义域释放时，导致该crash。假如在定义之前有赋值的话，还会造成内存泄露的问题
    id __unsafe_unretained result;
    [invocation getReturnValue:&result];
    return result;
}

/*
 scheme://[target]/[action]?[params]
 
 url sample:
 aaa://targetA/actionB?id=1234
 */
+ (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary * dict))completion{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
//    if ([actionName hasPrefix:@"native"]) {
//        return @(NO);
//    }
    NSObject *target;
    Class targetClass = NSClassFromString(url.host);
    target = [[targetClass alloc]init];

    NSString *errStr = [NSString stringWithFormat:@"对象生成失败_className:>%@",url.host];
    NSAssert(target, errStr);
    
    SEL sel = NSSelectorFromString(actionName);
    id result = [self performTarget:target action:sel params:(params.count==0?nil:params) orVAList:nil];
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}

#pragma mark -

- (NSMutableDictionary *)cachedTarget{
    if (_cachedTarget == nil) {
        _cachedTarget = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    return _cachedTarget;
}

@end
