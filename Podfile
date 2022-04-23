source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.0'
use_frameworks!

def cross_pods
# Pods for DigioChallenge
  pod 'SwiftLint'
  pod 'Kingfisher'
end

target 'DigioChallenge' do
 cross_pods
end

target 'DigioChallengeTests' do
  inherit! :search_paths
  # Pods for testing
end


target 'DigioChallengeSnapshotTests' do
  use_frameworks!
  # Pods for testing
  pod 'iOSSnapshotTestCase'
end
