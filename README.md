# TBMediator

[![CI Status](https://img.shields.io/travis/chenfeigogo@gmail.com/TBMediator.svg?style=flat)](https://travis-ci.org/chenfeigogo@gmail.com/TBMediator)
[![Version](https://img.shields.io/cocoapods/v/TBMediator.svg?style=flat)](https://cocoapods.org/pods/TBMediator)
[![License](https://img.shields.io/cocoapods/l/TBMediator.svg?style=flat)](https://cocoapods.org/pods/TBMediator)
[![Platform](https://img.shields.io/cocoapods/p/TBMediator.svg?style=flat)](https://cocoapods.org/pods/TBMediator)



TBMediator 是一个组件化中间件，主要思想借鉴与casa的文章及源码

[iOS应用架构谈 组件化方案]()

[在现有工程中实施基于CTMediator的组件化方案]()

[CTMediator的Swift应用]()

[casatwy/CTMediator](https://github.com/casatwy)

本库借鉴其思想

组件化的目的是降低代码的耦合度，本库也适合未抽离组件化的代码，实现类的方法调用、控制器的调用

##使用
### 1、调用打开控制器方法

- 目标控制器TBTestAViewController 中 实现 TBMediator 协议

```
+(void)mediatorLoad:(UIViewController *)fromVC params:(NSDictionary *)params handler:(MediatorBlock)block{
    TBTestAViewController *testAVC = [TBTestAViewController new];
    [fromVC presentViewController:testAVC animated:YES completion:^{

    }];
}

```

- 调用控制器

```
[TBMediator callViewController:@"TBTestAViewController"
                        params:@{@"paramsA":@"aaaa"}
                viewController:self
                      callBack:^(NSDictionary *callBackDic) {
                      }];
```


### 2、对象方法调用

- 直接调用

```
[TBMediator performTargetClassName:@"TBTestAViewController" action:@selector(testBFunction) params:nil, nil];
```

- 带参数

```
[TBMediator performTarget:self action:@selector(aprint:) params:@"我是一个参数", nil];

```

- 多参数带返回

```
NSArray *arr = [TBMediator performTargetClassName:@"TBViewController" action:@selector(aprint:bbb:ccc:ddd:) params:@"你",@"最",@6,@"B", nil];
NSLog(@"%@",arr);
```

- 通过URL方法调用

```
[TBMediator performActionWithUrl:[NSURL URLWithString:@"tb://TBViewController/testForUrl:?a=12&b=44"] completion:^(NSDictionary *dict) {
    NSLog(@"%@",dict);
}];

```



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

TBMediator is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TBMediator'
```

## Author

chenfeigogo@gmail.com

## License

TBMediator is available under the MIT license. See the LICENSE file for more info.
