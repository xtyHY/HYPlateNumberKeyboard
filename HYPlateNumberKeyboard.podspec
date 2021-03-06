#
# Be sure to run `pod lib lint HYPlateNumberKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYPlateNumberKeyboard'
  s.version          = '0.2.0'
  s.summary          = '货车自定义车牌输入键盘'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
货车自定义输入车牌
                       DESC

  s.homepage         = 'https://github.com/xtyHY/HYPlateNumberKeyboard'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xtyHY' => 'devhy@foxmail.com' }
  s.source           = { :git => 'https://github.com/xtyHY/HYPlateNumberKeyboard.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HYPlateNumberKeyboard/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HYPlateNumberKeyboard' => ['HYPlateNumberKeyboard/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
