Pod::Spec.new do |s|
  s.name         = "ZXNavigationTrasition"
  s.version      = "1.0.0"
  s.summary      = "一个简单的转场动画"
  s.homepage     = "https://github.com/zhangxing4418/ZXNavigationTrasition"
  s.license      = "MIT"
  s.author             = { "zhangxing4418" => "1092474399@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/zhangxing4418/ZXNavigationTrasition.git", :tag => "#{s.version}" }
  s.source_files  = 'ZXNavigationTrasition/ZXNavigationTrasition/ZXTransition/*.{h,m}'
  s.framework  = "UIKit"
end
