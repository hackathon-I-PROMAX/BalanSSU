//
//  NetworkService.swift
//  Balanssu
//
//  Created by 김규철 on 2023/02/19.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    let auth = AuthService()
    
    let main = MainCategoriesService()
    let voteList = VoteListService()
    let voteView = VoteViewService()
    let choices = ChoicesService()
    let myPage = MyPageService()
    let comment = CommentService()
    let report = ReportService()
}
