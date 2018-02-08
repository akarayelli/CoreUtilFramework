Pod::Spec.new do |s|
          #1.
          s.name               = "CoreUtilFramework"
          #2.
          s.version            = "2.0.12"
          #3.  
          s.summary         = "'CoreUtilFramework' is bunch of files that consists util classes for Swift language. Extensions, Delegates, Custom Componenets..."
          #4.
          s.homepage        = "https://github.com/akarayelli/CoreUtilFramework"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "akarayelli"
          #7.
          s.platform            = :ios, "9.0"
          #8.
          s.source              = { :git => "https://github.com/akarayelli/CoreUtilFramework.git", :tag => "2.0.12", :tag => s.version.to_s }
          #9.
          s.source_files     = "CoreUtilFramework", "CoreUtilFramework/**/*.{h,m,swift}"
    end