Pod::Spec.new do |s|
  s.name             = 'KMAgoraRtc'
  s.version          = '1.0.0'
  s.summary          = '声网SDK封装'
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
    DESC

  s.homepage         = 'https://github.com/zhenlove/KMAgoraRtc.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhenlove' => '121910347@qq.com' }
  s.source           = { :git => 'https://github.com/zhenlove/KMAgoraRtc.git', :tag => s.version }
  s.ios.deployment_target = '9.0'
  s.static_framework = true
  s.source_files = 'KMAgoraRtc/Class/*.{swift}'
#  s.resource = 'KMAgoraRtc/Class/AgoraRtc.xcassets'
  s.resource_bundles = {
      'AgoraRtc' => ['KMAgoraRtc/Class/AgoraRtc.xcassets']
    }
  s.dependency 'AgoraRtcEngine_iOS'
  s.dependency 'SnapKit'

end
