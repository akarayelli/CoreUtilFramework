Pod::Spec.new do |s|
          #1.
          s.name               = "CoreUtilFramework"
          #2.
          s.version            = "4.0.8"
          #3.  
          s.summary         = "'CoreUtilFramework' is bunch of files that consists util classes for Swift language. Extensions, Delegates, Custom Componenets..."
          #4.
          s.homepage        = "https://github.com/akarayelli/CoreUtilFramework"
          #5.
          s.license      = { :type => "MIT", :file => "LICENSE" }
          #6.
          s.author               = "akarayelli"
          #7.
          s.platform            = :ios, "10.0"
          #8.
          s.source              = { :git => "https://github.com/akarayelli/CoreUtilFramework.git", :branch => "master", :tag => s.version.to_s }
          #9.
          s.source_files     = "CoreUtilFramework", "CoreUtilFramework/**/*.{h,m,swift}"
          #10
          s.swift_version = '5.0'
    end