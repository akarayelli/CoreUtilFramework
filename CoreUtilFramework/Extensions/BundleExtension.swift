

import Foundation

public extension Bundle {

    public var appName: String {
        return string(for: "CFBundleDisplayName")
    }

    public var appVersion: String {
        return string(for: "CFBundleShortVersionString")
    }

    public var appBuild: String {
        return string(for: "CFBundleVersion")
    }

    public var bundleId: String {
        return string(for: "CFBundleIdentifier")
    }
    
    public var serverURL: String {
        return string(for: "ServerURL")
    }
    

    public var pinedDomain: String {
        return string(for: "SSLPinningDomain")
    }
    
    
    public var secureCertificateName: String {
        return string(for: "SSLCertificateName")
    }
    
    public var verifySSLCertificate: Bool{
        return bool(for: "VerifySSLCertificate")
    }

    public var adMobAppId: String {
        return string(for: "AdMod_APP_ID")
    }
    
    public var databaseName: String {
        return string(for: "DBName")
    }
    public var schemes: [String] {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let urlTypes = infoDictionary["CFBundleURLTypes"] as? [AnyObject],
            let urlType = urlTypes.first as? [String : AnyObject],
            let urlSchemes = urlType["CFBundleURLSchemes"] as? [String] else {
                return []
        }
        return urlSchemes
    }

    public var mainScheme: String? {
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
                return false
        }
        return value
    }

}
