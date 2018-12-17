
Pod::Spec.new do |s|

  s.name         = "LTViewPager"
  s.version      = "0.0.2"
  s.summary      = "Pager switch like Netease"
  s.homepage     = "https://github.com/alicialy/LTViewPager"
  s.license      = "MIT"
  s.author             = { "alicialy" => "alicialy@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/alicialy/LTViewPager.git", :tag => "#{s.version}" }
  s.source_files  = "LTViewPager/*.{h,m}"
  s.requires_arc = true

end
