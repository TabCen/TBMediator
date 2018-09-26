#
# Be sure to run `pod lib lint TBMediator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TBMediator'
  s.version          = '0.1.0'
  s.summary          = '组件化中间件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "组件化中间件，相当于直接调用对应的类方法 + (void)mediatorLoad:(UIViewController *)fromVC params:(NSDictionary *)params handler:(MediatorBlock)block{}"

  s.homepage         = 'https://github.com/TabCen/TBMediator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenfeigogo@gmail.com' => '964267617@qq.com' }
  s.source           = { :git => 'git@github.com:TabCen/TBMediator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TBMediator/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TBMediator' => ['TBMediator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
