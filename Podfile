# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'HDelivery' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HDelivery
  
  pod 'GoogleMaps'
  pod 'Google-Maps-iOS-Utils'
  pod 'GooglePlaces'
  
  
  # Firebase Core (required)
  pod 'Firebase/Core'

  

  # Firebase Cloud Messaging (Push Notifications)
  pod 'Firebase/Messaging'

 
  

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_phases.each do |phase|
      if phase.respond_to?(:name) && phase.name == 'Copy Pods Resources'
        phase.shell_script = phase.shell_script
          .gsub('${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt',
                '${TARGET_TEMP_DIR}/resources-to-copy-${TARGETNAME}.txt')
      end
    end
  end

  Dir.glob("Pods/Target Support Files/*/*-resources.sh").each do |script_path|
    text = File.read(script_path)
    # Remove `-m` from realpath calls
    text.gsub!('realpath -m', 'realpath')
    File.write(script_path, text)
  end
end

