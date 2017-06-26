
Pod::Spec.new do |s|
  s.name         = "RWRecorder"
  s.version      = "1.0.0"
  s.summary      = "RWRecorder"
  s.description  = <<-DESC
                  RWRecorder
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RWRecorder.git", :tag => "master" }
  s.source_files  = "RWRecorder/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  s.dependency "EZAudio", "-> 1.1.4"

end
