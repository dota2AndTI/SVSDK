#
# Be sure to run `pod lib lint SVSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SVSDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SVSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/dota2AndTI/SVSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dota2AndTI' => '706530573@qq.com' }
  s.source           = { :git => 'https://github.com/dota2AndTI/SVSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
# 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
  s.ios.deployment_target = '9.0'

  s.subspec 'Common' do |ss|
    ss.source_files = 'SVSDK/Common/*.{h,m}'
    ss.dependency 'Ads-CN','3.8.1.0'
    ss.dependency 'Google-Mobile-Ads-SDK','8.8.0'
    ss.vendored_frameworks = 'SVSDK/Common/ABUAdSDK.framework'
  end
  s.subspec 'Google' do |ss|
    ss.source_files = 'SVSDK/Google/*.{h,m}'
    ss.dependency 'SVSDK/Common'
  end
  s.subspec 'ABU' do |ss|
    ss.source_files = 'SVSDK/ABU/*.{h,m}'
    ss.dependency 'SVSDK/Common'
    
  end
  s.subspec 'BU' do |ss|
    ss.source_files = 'SVSDK/BU/*.{h,m}'
    ss.dependency 'SVSDK/Common'
  end
  
  # s.resource_bundles = {
  #   'SVSDK' => ['SVSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
