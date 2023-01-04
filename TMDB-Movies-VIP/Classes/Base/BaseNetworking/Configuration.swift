//
//  Configuration.swift
//  
//
//  Created by Bradley Hoang on 28/12/2022.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding = URLEncoding.default)
}

protocol Configuration {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
    var data: Data? { get }
}

struct ServiceError: Error {
    let issueCode: IssueCode
    var message: String {
        return issueCode.message
    }
    static var urlError: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "URL is wrong"))
    }
    static var notFoundData: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Not found Data"))
    }
    static var parseError: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Parse Model Error"))
    }
    static var somethingWrong: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Something went wrong!"))
    }
}

// swiftlint:disable all
enum IssueCode {
    case UNAUTHORIZED
    case SESSION_EXPIRE
    case SESSION_NOT_FOUND
    case TIME_OUT
    case CUSTOM_MES(message: String)
    
    static func initValue(value: String) -> IssueCode {
        switch value.uppercased() {
        case "UNAUTHORIZED":
            return .UNAUTHORIZED
        case "SESSION_EXPIRE":
            return .SESSION_EXPIRE
        case "SESSION_NOT_FOUND":
            return .SESSION_NOT_FOUND
        case "TIME_OUT":
            return .TIME_OUT
        default:
            if value.asTrimmed.isEmpty {
                return .CUSTOM_MES(message: "Something went wrong!")
            }
            return .CUSTOM_MES(message: value)
        }
    }
    
    var message: String {
        switch self {
        case .UNAUTHORIZED:
            return "Unauthorized!"
        case .SESSION_EXPIRE:
            return "Session expired!"
        case .SESSION_NOT_FOUND:
            return "Session not found!"
        case .TIME_OUT:
            return "Time out!"
        case .CUSTOM_MES(let message):
            return message
        }
    }
}
