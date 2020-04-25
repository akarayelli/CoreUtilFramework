

import Foundation

public extension Bundle {

    var appName: String {
        return string(for: "CFBundleDisplayName")
    }

    var appVersion: String {
        return string(for: "CFBundleShortVersionString")
    }

    var appBuild: String {
        return string(for: "CFBundleVersion")
    }

    var bundleId: String {
        return string(for: "CFBundleIdentifier")
    }
    
    var serverURL: String {
        return string(for: "ServerURL")
    }
    

    var pinedDomain: String {
        return string(for: "SSLPinningDomain")
    }
    
    
    var secureCertificateName: String {
        return string(for: "SSLCertificateName")
    }
    
    var verifySSLCertificate: Bool{
        return bool(for: "VerifySSLCertificate")
    }

    var adMobAppId: String {
        return string(for: "AdMod_APP_ID")
    }
    
    var databaseName: String {
        return string(for: "DBName")
    }
    var schemes: [String] {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let urlTypes = infoDictionary["CFBundleURLTypes"] as? [AnyObject],
            let urlType = urlTypes.first as? [String : AnyObject],
            let urlSchemes = urlType["CFBundleURLSchemes"] as? [String] else {
                return []
        }
        return urlSchemes
    }

    var mainScheme: String? {
        return schemes.first
    }

}

fileprivate extension Bundle {

    func string(for key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary[key] as? String else {
                return ""
        }
        return value
    }
    
    func bool(for key: String) -> Bool {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary[key] as? Bool else {
                return true
        }
        return value
    }

}
