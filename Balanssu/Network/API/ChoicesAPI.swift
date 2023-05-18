import Foundation
import Moya

enum ChoicesAPI {
    case postChoice(categoryId: String, choiceId: String)
}

extension ChoicesAPI: BaseTargetType {
    var path: String {
        switch self {
        case .postChoice:
            return URLConst.choices
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postChoice:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postChoice(let categoryId, let choiceId):
            return .requestParameters(parameters: [
                "categoryId": categoryId,
                "choiceId": choiceId
            ], encoding: JSONEncoding.default)
        }
    }
}
