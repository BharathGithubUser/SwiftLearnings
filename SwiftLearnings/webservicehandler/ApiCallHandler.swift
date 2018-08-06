//
//  ApiCallHandler.swift
//  SwiftLearnings
//
//  Created by user on 01/08/18.
//  Copyright © 2018 this. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

final class ApiCallHandler: NSObject {
    // MARK: - Properties
    typealias CompletionClosure = (Data?, CustomError?) -> Void
    private let alamofire: Alamofire.SessionManager
    // MARK: - Initializer
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30
        self.alamofire = Alamofire.SessionManager(configuration: configuration)
        super.init()
    }
    // MARK: - GET method
    /**
     HTTP get method
     - parameter url: Path where we make get request
     - parameter body: This is optional and in dictionary format
     - parameter Completion: This is to handle the response return from the webservice request
     */
    func getMethod(url: String, body: [String: Any]?, Completion responseHandler: @escaping CompletionClosure) {
        if NetworkReachabilityManager()!.isReachable {
            alamofire.request(url).responseJSON {response in
                print("REQUEST:\n", url)
                print("RESPONSE:\n", response)
                self.handleResponse(response: response, withCompletionHandler: responseHandler)
            }
        } else {
            responseHandler(nil, CustomError.connectionError)
        }
    }
    
    func uploadImageAndData(image: Data, requestParams: [String: String]?, routeUrl: String, Completion responseHandler: @escaping CompletionClosure) {
        //parameters
        if NetworkReachabilityManager()!.isReachable {
            alamofire.upload(
                multipartFormData: { multipartFormData in
                    //param fileName: is very important one for actually uploading the image
                    multipartFormData.append(image, withName: "imageFile",fileName: "photo.png", mimeType: "image/png")
                    for (key, val) in requestParams! {
                        multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                    }
                },
                usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
                to: routeUrl,
                method: .post,
                headers: nil
                ) {(result: SessionManager.MultipartFormDataEncodingResult) in
                    switch result {
                    case .failure(let error):
                        print(error)
                        responseHandler(nil, CustomError.serverError)
                    case .success(let request, let streamingFromDisk, let streamFileURL):
                        print("successfully uploaded the image!")
                        //responseHandler(SessionMan, CustomError.serverError)
                    }
            }
        } else {
            print("Internet connection failed!")
        }
    }
    // MARK: - Handling response
    /**
     Handle the response return by the webservice
     - parameter response: This is the response return by the webservice requests
     - parameter handler: This closure handles the success result and error
     */
    func handleResponse(response: DataResponse<Any>, withCompletionHandler handler: CompletionClosure) {
        switch response.result {
        case .success(let value):
            do {
                let data = try JSONSerialization.data(
                    withJSONObject: value, options: JSONSerialization.WritingOptions(rawValue: 0))
                handler(data, nil)
            } catch {
                handler(nil, CustomError.jsonSerializeError)
            }
        case .failure(let error):
            switch error._code {
            case -1001:
                handler(nil, CustomError.connectionSlow)
            case 4:
                handler(nil, CustomError.jsonSerializeError)
            default:
                handler(nil, CustomError.serverError)
            }
        }
    }
}
/// Its all possible error cases
/// - connectionError: No internet connection error
/// - connectionSlow: Connection or response slow
/// - serverFailure: Internal server error
/// - jsonSerializeError: Json serialization error
enum CustomError: Error {
    case connectionError
    case connectionSlow
    case serverError
    case jsonSerializeError
    var description: String {
        switch self {
        case .connectionError:
            return NSLocalizedString("No internet connection", comment: "")
        case .connectionSlow:
            return NSLocalizedString("Internet connection is slow", comment: "")
        case .jsonSerializeError:
            return NSLocalizedString("Json parsing is failed", comment: "")
        case .serverError:
            return NSLocalizedString("Something is failure in server", comment: "")
        }
    }
}
