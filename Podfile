platform :ios, '10.0'
#inhibit_all_warnings!
use_frameworks!

def pods

pod 'SnapKit', '5.0.1'
pod 'SVProgressHUD', '~> 1.1.3'
pod 'Kingfisher', '5.13.4'
pod 'YYKit'
pod 'SwiftHEXColors'

end

target 'DXDoctor' do
    pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
#            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
