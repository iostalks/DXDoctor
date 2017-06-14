platform:ios,'8.0'
inhibit_all_warnings!
use_frameworks!

def pods

pod 'SnapKit', :git => 'https://github.com/SnapKit/SnapKit', :branch => 'swift-4'
pod 'SVProgressHUD', '~> 1.1.3'
pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher', :branch => 'swift4'
pod 'YYKit'

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
