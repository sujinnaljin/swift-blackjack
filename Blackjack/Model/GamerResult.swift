//
//  GamerResult.swift
//  Blackjack
//
//  Created by 강수진 on 2022/05/25.
//

import Foundation

struct GamerResult {
    
    enum Outcome: UserInformable {
        case win
        case draw
        case lose
        
        var guideDescription: String {
            switch self {
            case .win:
                return "승"
            case .draw:
                return "무"
            case .lose:
                return "패"
            }
        }
    }
    
    private let dealer: Dealer
    private let gamers: [Gamer]
    private var winningPoint: Int {
        let allPlayers: [Gamer] = gamers + [dealer]
        let winningPoint: Int = allPlayers
            .filter { gamer in
                ThresholdChecker().isTotalPointUnderThreshold(of: gamer.cards)
            }
            .map { $0.totalPoint }.max() ?? 0
        return winningPoint
    }
    
    init(dealer: Dealer, gamers: [Gamer]) {
        self.dealer = dealer
        self.gamers = gamers
    }
    
    func outcome(of gamer: Gamer) -> Outcome {
        guard !dealer.isBurst else {
            return .win
        }
        
        guard !gamer.isBurst else {
            return .lose
        }
        
        let isGamerPointOverWinningPoint: Bool = gamer.totalPoint >= winningPoint
        if isGamerPointOverWinningPoint {
            let isGamerPointSameWithDealer: Bool = dealer.totalPoint == gamer.totalPoint
            if isGamerPointSameWithDealer {
                return .draw
            } else {
                return .win
            }
        } else {
            return .lose
        }
    }
}
