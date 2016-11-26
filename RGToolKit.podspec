Pod::Spec.new do |spec|
  spec.name         =  'RGToolKit'
  spec.version      =  '1.0'
  spec.summary   =  'Its provides some useful utility functions, handlers, extensions etc which makes Swift development fun!!!'
  spec.author = {
    'Ritesh Gupta' => 'rg.riteshh@gmail.com'
  }
  spec.license          =  'MIT' 
  spec.homepage         =  'https://github.com/riteshhgupta/RGToolKit'
  spec.source = {
    :git => 'https://github.com/riteshhgupta/RGToolKit.git',
    :tag => '1.0'
  }
  spec.ios.deployment_target = "9.0"
  spec.source_files =  'Source/*.{swift}'
  spec.requires_arc     =  true
end
