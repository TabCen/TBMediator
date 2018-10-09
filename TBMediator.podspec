Pod::Spec.new do |s|
  s.name             = 'TBMediator'
  s.version          = '1.0'
  s.summary          = '组件化中间件'
  s.description      = "组件化中间件，相当于直接调用对应的类方法 + (void)mediatorLoad:(UIViewController *)fromVC params:(NSDictionary *)params handler:(MediatorBlock)block{}"

  s.homepage         = 'https://github.com/TabCen/TBMediator'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenfeigogo@gmail.com' => '964267617@qq.com' }
  s.source           = { :git => 'https://github.com/TabCen/TBMediator.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TBMediator/Classes/**/*'
end
