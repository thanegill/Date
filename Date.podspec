Pod::Spec.new do |s|
  s.name        = 'Date'
  s.version     = '0.1.0'
  s.summary     = 'A repacement for NSDate'
  s.description = <<-DESC
    A Date struct that Swift deserves
                DESC
  s.homepage    = 'https://github.com/thanegill/Date'
  s.license     = 'MIT'
  s.author      = { 'Thane Gill' => 'me@thanegill.com' }
  s.source      = { :git => 'https://github.com/thanegill/Date.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Source/**/*'

  s.frameworks = 'Foundation', 'CoreFoundation'
end
