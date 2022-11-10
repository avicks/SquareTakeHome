source 'https://cdn.cocoapods.org/'

platform :ios, "16.0"
inhibit_all_warnings!

def shared_pods
  pod 'ReactiveCocoa', '~> 10.1'
  pod 'ReactiveSwift', '~> 6.1'
end


target 'SquareTakeHome' do
  shared_pods
end

target 'SquareTakeHomeTests' do
  inherit! :search_paths
  shared_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Silence Cocoapods warning as of Xcode 14
      config.build_settings['DEAD_CODE_STRIPPING'] = 'YES'
        # Forces the minimum to be 16.0 as that's our last deployment target
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 16.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
        end
      end
    end
  end