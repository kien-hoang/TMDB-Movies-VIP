platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

def shared_pods
  # Networking
  pod 'Alamofire'
  
  # Utility
  pod 'Kingfisher'
  pod 'SVProgressHUD'
  pod 'SVPullToRefresh'
  pod 'Localize-Swift', '~> 3.2'
  
  # Quality + Generation
  pod 'SwiftLint'
end

target 'TMDB-Movies-VIP' do
  shared_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
