
Pod::Spec.new do |s|
  s.name         = "JSModalInputer"
  s.version      = "0.0.1"
  s.summary      = "A Highly Customizable Modal/Popup Inputer View "

  s.homepage     = "https://github.com/JunsW/JSModalInputer"

  s.license      = "MIT (example)"
  s.author             = { "JunsW" => "wjunshuo@@qq.com" }

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source       = { :git => "http://github.com/JSModalInputer.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Source/*.swift"
  
  s.requires_arc = true

  s.framework  = "UIKit"

end
