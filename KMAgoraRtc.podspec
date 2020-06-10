Pod::Spec.new do |s|
  s.name             = 'KMAgoraRtc'
  s.version          = '1.1.1'
  s.summary          = '声网SDK封装'
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
    DESC

  s.homepage         = 'https://github.com/zhenlove/KMAgoraRtc.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhenlove' => '121910347@qq.com' }
  s.source           = { :git => 'https://github.com/zhenlove/KMAgoraRtc.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  #s.static_framework = true #因为 AgoraRtcEngine_iOS 是静态库，所以本库也需要设置为静态库
  s.source_files = 'KMAgoraRtc/Class/*.{swift}'
  s.resource_bundles = {
      'AgoraRtc' => ['KMAgoraRtc/Assets/*']
    }
  s.dependency 'SnapKit','4.2.0'
  s.dependency 'AgoraRtcEngine_iOS','3.0.1'
  s.dependency 'Kingfisher','4.10.1'
end
