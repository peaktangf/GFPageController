#
#  Be sure to run `pod spec lint GFPageController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "GFPageController"
  s.version      = "0.6.0"
  s.summary      = "A common paging controls."
  s.description  = <<-DESC
                   It is a component for ios paging controls,written by Objective-C
                   DESC
  s.homepage     = "https://github.com/gaofengtan/GFPageController"
  s.license      = "MIT（LICENSE）"
  s.author             = { "gaofengtan" => "1755059481@qq.com" }
  s.source       = { :git => "https://github.com/gaofengtan/GFPageController.git", :tag => "0.6.0" }
  s.platform     = :ios, '8.0'

  s.source_files  = "GFPageController/*.{h,m}"

  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true

end
