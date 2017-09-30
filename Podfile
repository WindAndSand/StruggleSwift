source 'https://github.com/CocoaPods/Specs.git'
source 'http://gitlab.x.yunio.com/ios/PodSpecs.git'
platform :ios,'8.0'
use_frameworks!

target 'StruggleSwift' do
   pod 'SnapKit', '3.2.0'
   pod 'Alamofire', '~> 4.5.0'
   pod 'chatkit', :git => 'git@gitlab.x.yunio.com:ios/chatkit.git', :tag => '0.9.3'
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
