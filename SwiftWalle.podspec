#
# Be sure to run `pod lib lint SwiftWalle.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftWalle'
  s.version          = '0.1.0'
  s.summary          = 'A collection of useful extenison of Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A collection of useful extenison of Swift, incluing some extenison of SwifterSwift'

  s.homepage         = 'https://github.com/mistdon/SwiftWalle'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mistdon' => 'shendong13014@gmail.com' }
  s.source           = { :git => 'https://github.com/mistdon/SwiftWalle.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.5'
  s.requires_arc = true
  s.source_files = 'SwiftWalle/Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'SwiftWalle' => ['SwiftWalle/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.ios.framework = 'UIKit'
  s.dependency 'SwifterSwift/SwiftStdlib'
  s.dependency 'SwifterSwift/Foundation'
  s.dependency 'SwifterSwift/UIKit'
  s.dependency 'SwifterSwift/Dispatch'
  
end
