//
//  StubResultView.swift
//  BlackjackTest
//
//  Created by Mephrine on 2021/11/15.
//

import Foundation

final class StubResultView: Presentable {
	var hitCount = [Int]()
	var gameResults = [GameResult]()
	var error: BlackjackError.InputError? = nil
	private var players: [Player] = [Player]()
	private var playerIndex = 0
	
	enum Verify {
		static var printOutGameStatusBeforePlay = false
		static var printOutDeckOfPlayer = false
		static var printOutGameResult = false
		static var printOutError = false
	}

	func printOutGameStatusBeforePlay(by players: [Player]) {
		self.players = players
		self.hitCount = (0...players.count - 1).map { _ in 0 }
		Verify.printOutGameStatusBeforePlay = true
	}
	
	func printOutDeck(of player: Player) {
		if players[playerIndex].name != player.name {
			playerIndex += 1
		}
		hitCount[playerIndex] += 1
		Verify.printOutDeckOfPlayer = true
	}
	
	func printOutError(error: BlackjackError.InputError) {
		self.error = error
		Verify.printOutError = true
	}
	
	func printOutGameResult(by playerGameResults: [GameResult]) {
		self.gameResults = playerGameResults
		Verify.printOutGameResult = true
	}
	
	func clear() {
		players = [Player]()
		gameResults = [GameResult]()
		hitCount = [Int]()
		playerIndex = 0
		error = nil
		Verify.printOutGameStatusBeforePlay = false
		Verify.printOutDeckOfPlayer = false
		Verify.printOutGameResult = false
		Verify.printOutError = false
	}
	
}
